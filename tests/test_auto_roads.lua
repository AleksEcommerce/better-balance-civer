-- Run with Lua 5.4. Exercises the actual gameplay script with engine mocks.
local callbacks = {}
local function event(name) return {Add=function(fn) callbacks[name]=fn end} end
Events={LoadGameViewStateDone=event('load'),UnitMoved=event('moved')}
GameEvents={BBC_AutoRoadsTarget=event('target'),BBC_AutoRoadsStep=event('step')}
local turn=1
Game={GetCurrentGameTurn=function() return turn end}
local plots={}
for i=0,4 do
    local p={x=i,route=-1,pillaged=false}
    function p:GetX() return self.x end
    function p:GetY() return 0 end
    function p:GetIndex() return self.x end
    function p:IsWater() return self.water or false end
    function p:IsMountain() return false end
    function p:GetRouteType() return self.route end
    function p:IsRoutePillaged() return self.pillaged end
    plots[i]=p
end
Map={GetPlot=function(x,y) return y==0 and plots[x] or nil end,GetPlotByIndex=function(i) return plots[i] end,GetPlotDistance=function(x,y,a,b) return math.abs(x-a)+math.abs(y-b) end}
local roads={{Index=0,RouteType='ROUTE_ANCIENT_ROAD',PlacementValue=1},{Index=4,RouteType='ROUTE_RAILROAD',PlacementValue=5}}
local routes=setmetatable({[0]=roads[1],[4]=roads[2],ROUTE_ANCIENT_ROAD=roads[1],ROUTE_RAILROAD=roads[2]}, {__call=function() local n=0;return function() n=n+1;return roads[n] end end})
GameInfo={Units={[1]={UnitType='UNIT_BUILDER'},[2]={UnitType='UNIT_MILITARY_ENGINEER'},[3]={UnitType='UNIT_TANK'}},Routes=routes,Technologies={TECH_STEAM_POWER={Index=7}},Eras={[0]={ChronologyIndex=0}},Resources={RESOURCE_IRON={Index=1},RESOURCE_COAL={Index=2}}}
local units={}
local gold=20
local stock={[1]=10,[2]=10}
local tech=true
local treasury={GetGoldBalance=function()return gold end,ChangeGoldBalance=function(_,n)gold=gold+n end}
local resources={GetResourceAmount=function(_,id)return stock[id] end,ChangeResourceAmount=function(_,id,n)stock[id]=stock[id]+n end}
local collection={FindID=function(_,id)return units[id] end}
local player={GetUnits=function()return collection end,GetEra=function()return 0 end,GetTechs=function()return {HasTech=function()return tech end} end,GetTreasury=function()return treasury end,GetResources=function()return resources end}
Players={[0]=player}
UnitManager={ChangeMovesRemaining=function(u,n)u.moves=u.moves+n end}
local builds=0
RouteBuilder={SetRouteType=function(p,id)p.route=id;builds=builds+1 end,SetRoutePillaged=function(p,b)p.pillaged=b end}
local function unit(id,kind)
 local u={id=id,kind=kind,x=0,moves=3,props={}}
 function u:GetType()return self.kind end
 function u:GetID()return self.id end
 function u:GetX()return self.x end
 function u:GetY()return 0 end
 function u:GetMovesRemaining()return self.moves end
 function u:GetProperty(k)return self.props[k] end
 function u:SetProperty(k,v)self.props[k]=v end
 units[id]=u;return u
end
local function load()
 dofile('Integrated/AutoRoads/BBC_AutoRoads_Gameplay.lua');callbacks.load()
end
local function target(u,index)callbacks.target(0,{UnitID=u.id,Target=index})end
local function prepare(u,index)callbacks.step(0,{UnitID=u.id,NextPlot=index})end
local function arrive(u,index)
 assert(u:GetProperty('BBC_ROAD_PENDING')==index,'unauthorized move')
 assert(math.abs(u.x-index)==1,'non-adjacent move')
 u.x=index;u.moves=u.moves-.25;callbacks.moved(0,u.id,index,0)
end
load()
local u=unit(1,1);plots[0].route=0;target(u,3)
prepare(u,1);assert(u:GetProperty('BBC_ROAD_PENDING')==1);arrive(u,1)
assert(plots[1].route==0 and plots[2].route==-1 and u.moves==0 and gold==18)
-- Duplicate/late event and re-target on same turn cannot build a second tile.
callbacks.moved(0,u.id,2,0);prepare(u,2);assert(plots[2].route==-1 and builds==1)
target(u,4);prepare(u,2);assert(builds==1)
-- Saved destination and last-step property survive a Lua reload on same turn.
load();u.moves=3;prepare(u,2);assert(builds==1 and u:GetProperty('BBC_ROAD_PENDING')==-1)
turn=2;prepare(u,2);arrive(u,2);assert(plots[2].route==0 and plots[3].route==-1)
-- Deliberately distant request is rejected by gameplay validation.
turn=3;u.moves=3;prepare(u,4);assert(u:GetProperty('BBC_ROAD_PENDING')==-1 and u:GetProperty('BBC_ROAD_STATUS')=='PATH')
-- No resource means no authorization; resume next turn after stock restored.
gold=1;prepare(u,3);assert(u:GetProperty('BBC_ROAD_PENDING')==-1 and gold==1)
turn=4;gold=10;prepare(u,3);arrive(u,3);assert(gold==8)
turn=5;u.moves=3;prepare(u,4);arrive(u,4);assert(u:GetProperty('BBC_IS_BUILD_ROUTE')==0)
-- Engineer fills its starting tile first, then follows a continuous railway.
turn=6;local e=unit(2,2);target(e,2);prepare(e,1)
assert(plots[0].route==4 and e.x==0 and e.moves==0 and stock[1]==9 and stock[2]==9)
turn=7;e.moves=3;prepare(e,1);arrive(e,1)
assert(plots[1].route==4 and e.x==1 and e.moves==0 and stock[1]==8)
-- Steam Power, depleted coal, blocked tile, and canceled route.
turn=8;e.moves=3;tech=false;prepare(e,2);assert(e:GetProperty('BBC_ROAD_PENDING')==-1 and e:GetProperty('BBC_ROAD_STATUS')=='TECH')
tech=true;stock[2]=0;prepare(e,2);assert(e:GetProperty('BBC_ROAD_PENDING')==-1)
stock[2]=8;plots[2].water=true;prepare(e,2);assert(e:GetProperty('BBC_ROAD_PENDING')==-1);plots[2].water=false
callbacks.target(0,{UnitID=e.id,Cancel=1});prepare(e,2);assert(e:GetProperty('BBC_IS_BUILD_ROUTE')==0 and e.moves==3)
-- An ordinary unautomated worker is not drained or used for construction.
local off=unit(3,1);local old=builds;callbacks.moved(0,3,1,0);assert(off.moves==3 and builds==old)
local tank=unit(4,3);target(tank,2);assert(tank:GetProperty('BBC_IS_BUILD_ROUTE')==nil)
print('PASS: adjacent-only authorization, 1 step/turn, no double resource spending, saved route/reload, continuous starting tile, completion, resources/tech, cancellation and unrelated units.')
-- Exercise actual UI polling and the two-stage gameplay/native-move handshake.
local selected=unit(5,1)
local cursor=2
local localID=0
local nativeMoves=0
local detour=false
local uiCallbacks={}
function collection:Members() return next,units,nil end
function player:IsTurnActive()return true end
Game.GetLocalPlayer=function()return localID end
UI={DataError=function(message)error(message)end,GetHeadSelectedUnit=function()return selected end,GetCursorPlotID=function()return cursor end,
 RequestPlayerOperation=function(_,_,params)
  if params.OnStart=='BBC_AutoRoadsTarget' then callbacks.target(0,params) else callbacks.step(0,params) end
 end}
PlayerOperations={EXECUTE_SCRIPT=1}
UnitCommandTypes={CANCEL=2}
UnitOperationTypes={MOVE_TO=3,PARAM_X='x',PARAM_Y='y'}
Mouse={eLClick=1,eRClick=2}
KeyEvents={KeyUp=3};Keys={VK_ESCAPE=27};MouseEvents={LButtonUp=4,RButtonUp=5};PopupPriority={Current=1}
local modal=false
UIManager={GetScreenSizeVal=function()return 1920,1080 end,QueuePopup=function()modal=true end,DequeuePopup=function()modal=false end}
UnitManager.GetUnit=function(_,id)return units[id] end
UnitManager.CanStartCommand=function(un,command,loose) assert(type(loose)=='boolean','native CanStartCommand requires explicit check mode');return false end
UnitManager.RequestCommand=function()error('unexpected cancel')end
UnitManager.GetMoveToPathEx=function(un,dest)
 if detour and dest==1 then return {plots={0,3,1}} end
 local path={un.x}
 for i=un.x+1,dest do path[#path+1]=i end
 return {plots=path}
end
UnitManager.CanStartOperation=function()return true end
UnitManager.RequestOperation=function(un,op,params)
 assert(op==3 and math.abs(un.x-params.x)==1,'UI submitted distant native movement')
 nativeMoves=nativeMoves+1;arrive(un,params.x)
end
local function control(name)
 return {SetSizeVal=function()end,SetHide=function()end,SetSelected=function()end,SetToolTipString=function()end,
 ChangeParent=function()end,RegisterCallback=function(_,key,fn)uiCallbacks[name..key]=fn end}
end
Controls={BuildRouteGrid=control('grid'),BuildRouteButton=control('button'),RoadTargetCapture=control('pick'),RoadTargetHint=control('hint')}
ContextPtr={SetHide=function()end,LookUpControl=function()return {}end,SetInputHandler=function(_,fn)uiCallbacks.input=fn end,SetUpdate=function(_,fn)uiCallbacks.update=fn end}
Events.UnitSelectionChanged=event('selected');Events.PlayerTurnDeactivated=event('deactivated')
dofile('Integrated/AutoRoads/BBC_AutoRoads.lua');callbacks.load()
turn=9;uiCallbacks.button1();assert(modal,'target picker must block world input');
local consumed=uiCallbacks.input({GetMessageType=function()return MouseEvents.RButtonUp end});assert(consumed and not modal,'right-click must choose target and close picker')
assert(selected:GetProperty('BBC_ROAD_TARGET')==2)
uiCallbacks.update(.4);uiCallbacks.update(.4);uiCallbacks.update(.4)
assert(selected.x==1 and nativeMoves==1 and selected.moves==0)
turn=10;selected.moves=3;uiCallbacks.update(.4);uiCallbacks.update(.4)
assert(selected.x==2 and nativeMoves==2 and selected:GetProperty('BBC_IS_BUILD_ROUTE')==0)
-- A changed path that would detour around a blocked adjacent tile is not submitted.
turn=11;selected=unit(6,1);uiCallbacks.button1();uiCallbacks.pick1();uiCallbacks.update(.4)
detour=true;uiCallbacks.update(.4)
assert(selected.x==0 and nativeMoves==2 and selected:GetProperty('BBC_ROAD_STATUS')=='PATH')
print('PASS: real UI issues only one adjacent native move per turn, resumes saved destination, and rejects detours after preparation.')

-- Escape cancels choosing a new target without issuing movement or enabling a route.
selected=unit(7,1);uiCallbacks.button1();assert(modal)
local consumed=uiCallbacks.input({GetMessageType=function()return KeyEvents.KeyUp end,GetKey=function()return Keys.VK_ESCAPE end})
assert(consumed and not modal and selected:GetProperty('BBC_IS_BUILD_ROUTE')==nil)
assert(uiCallbacks.input({GetMessageType=function()return MouseEvents.RButtonUp end})==false)
print('PASS: modal input capture, right-click target, Escape cancel, normal input restored.')
