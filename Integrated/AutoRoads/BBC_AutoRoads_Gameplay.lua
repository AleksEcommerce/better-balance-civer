-- Better Balance Civer: saved road destination, authorized adjacent steps.
-- Inspired by Auto Build Road (Steam 3592659261, Genever).
local ACTIVE = 'BBC_IS_BUILD_ROUTE'
local TARGET = 'BBC_ROAD_TARGET'
local STEP = 'BBC_ROAD_STEP_TURN'
local PENDING = 'BBC_ROAD_PENDING'
local PENDING_TURN = 'BBC_ROAD_PENDING_TURN'

local function Worker(playerID, unitID)
    local player = Players[playerID]
    if not player then return nil end
    local unit = player:GetUnits():FindID(unitID)
    if not unit then return nil end
    local kind = GameInfo.Units[unit:GetType()].UnitType
    if kind ~= 'UNIT_BUILDER' and kind ~= 'UNIT_MILITARY_ENGINEER' then return nil end
    return unit, player, kind
end

local function Stop(unit)
    local moves = unit:GetMovesRemaining()
    if moves > 0 then UnitManager.ChangeMovesRemaining(unit, -moves) end
end

local function Pause(unit, reason)
    unit:SetProperty('BBC_ROAD_STATUS', reason)
    unit:SetProperty(PENDING, -1)
end

local function Finish(unit)
    unit:SetProperty(ACTIVE, 0)
    unit:SetProperty(PENDING, -1)
    unit:SetProperty('BBC_ROAD_STATUS', 'DONE')
end

local function Route(player, kind)
    if kind == 'UNIT_MILITARY_ENGINEER' then
        local tech = GameInfo.Technologies['TECH_STEAM_POWER']
        if not tech or not player:GetTechs():HasTech(tech.Index) then return nil end
        return GameInfo.Routes['ROUTE_RAILROAD']
    end
    local best = nil
    local era = GameInfo.Eras[player:GetEra()]
    for row in GameInfo.Routes() do
        local prereq = row.PrereqEra and GameInfo.Eras[row.PrereqEra]
        if row.RouteType ~= 'ROUTE_RAILROAD' and (not prereq or prereq.ChronologyIndex <= era.ChronologyIndex) then
            if not best or row.PlacementValue > best.PlacementValue then best = row end
        end
    end
    return best
end

local function CanPay(player, kind)
    if kind == 'UNIT_BUILDER' then return player:GetTreasury():GetGoldBalance() >= 2 end
    local resources = player:GetResources()
    return resources:GetResourceAmount(GameInfo.Resources['RESOURCE_IRON'].Index) >= 1
       and resources:GetResourceAmount(GameInfo.Resources['RESOURCE_COAL'].Index) >= 1
end

local function NeedsRoute(plot, route)
    local current = GameInfo.Routes[plot:GetRouteType()]
    return plot:IsRoutePillaged() or not current or current.PlacementValue < route.PlacementValue
end

local function Build(player, kind, plot, route)
    if not NeedsRoute(plot, route) then return true end
    if not CanPay(player, kind) then return false end
    RouteBuilder.SetRouteType(plot, route.Index)
    if plot:IsRoutePillaged() then RouteBuilder.SetRoutePillaged(plot, false) end
    if kind == 'UNIT_BUILDER' then
        player:GetTreasury():ChangeGoldBalance(-2)
    else
        player:GetResources():ChangeResourceAmount(GameInfo.Resources['RESOURCE_IRON'].Index, -1)
        player:GetResources():ChangeResourceAmount(GameInfo.Resources['RESOURCE_COAL'].Index, -1)
    end
    return true
end

local function SetTarget(playerID, params)
    local unit = Worker(playerID, params.UnitID)
    if not unit then return end
    if params.Cancel == 1 then Finish(unit); return end
    local target = type(params.Target) == 'number' and Map.GetPlotByIndex(params.Target)
    if not target or target:IsWater() or target:IsMountain() then return end
    unit:SetProperty(TARGET, target:GetIndex())
    unit:SetProperty(PENDING, -1)
    unit:SetProperty(ACTIVE, 1)
    unit:SetProperty('BBC_ROAD_STATUS', 'ACTIVE')
end

local function PrepareStep(playerID, params)
    local unit, player, kind = Worker(playerID, params.UnitID)
    if not unit or unit:GetProperty(ACTIVE) ~= 1 then return end
    if params.Blocked == 1 then Pause(unit, 'PATH'); return end
    local turn = Game.GetCurrentGameTurn()
    if unit:GetProperty(STEP) == turn or unit:GetMovesRemaining() <= 0 then return end
    -- Never authorize a second movement while the first request is pending.
    if unit:GetProperty(PENDING_TURN) == turn and (unit:GetProperty(PENDING) or -1) >= 0 then return end
    local route = Route(player, kind)
    if not route then Pause(unit, 'TECH'); return end
    local here = Map.GetPlot(unit:GetX(), unit:GetY())
    if here:IsWater() then Pause(unit, 'LAND'); return end
    -- Fill the starting/current tile first; do not leave a gap when resuming.
    if NeedsRoute(here, route) then
        if not Build(player, kind, here, route) then Pause(unit, 'RESOURCES'); return end
        unit:SetProperty(STEP, turn)
        Stop(unit)
        if here:GetIndex() == unit:GetProperty(TARGET) then Finish(unit) end
        return
    end
    if here:GetIndex() == unit:GetProperty(TARGET) then Finish(unit); return end
    local nextPlot = type(params.NextPlot) == 'number' and Map.GetPlotByIndex(params.NextPlot)
    if not nextPlot or nextPlot:IsWater() or nextPlot:IsMountain()
       or Map.GetPlotDistance(here:GetX(), here:GetY(), nextPlot:GetX(), nextPlot:GetY()) ~= 1 then
        Pause(unit, 'PATH'); return
    end
    if NeedsRoute(nextPlot, route) and not CanPay(player, kind) then Pause(unit, 'RESOURCES'); return end
    unit:SetProperty('BBC_ROAD_STATUS', 'ACTIVE')
    unit:SetProperty(PENDING_TURN, turn)
    unit:SetProperty(PENDING, nextPlot:GetIndex())
end

local function OnMoved(playerID, unitID, x, y)
    local unit, player, kind = Worker(playerID, unitID)
    if not unit or unit:GetProperty(ACTIVE) ~= 1 then return end
    local turn = Game.GetCurrentGameTurn()
    if unit:GetProperty(STEP) == turn then return end
    local plot = Map.GetPlot(x, y)
    if not plot or plot:GetIndex() ~= unit:GetProperty(PENDING)
       or unit:GetProperty(PENDING_TURN) ~= turn then return end
    unit:SetProperty(STEP, turn)
    unit:SetProperty(PENDING, -1)
    Stop(unit)
    local route = Route(player, kind)
    if not route or not Build(player, kind, plot, route) then Pause(unit, 'RESOURCES'); return end
    if plot:GetIndex() == unit:GetProperty(TARGET) then Finish(unit) end
end

local function Initialize()
    GameEvents.BBC_AutoRoadsTarget.Add(SetTarget)
    GameEvents.BBC_AutoRoadsStep.Add(PrepareStep)
    Events.UnitMoved.Add(OnMoved)
    print('BBC AutoRoads v3: adjacent-step route controller loaded')
end
Events.LoadGameViewStateDone.Add(Initialize)
