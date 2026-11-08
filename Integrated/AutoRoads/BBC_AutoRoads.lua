-- Better Balance Civer: choose a saved destination, issue adjacent moves only.
local pickingUnit = nil
local elapsed = 0
local prepared = {}
local issued = {}
local ready = false
local statuses = { TECH='Нужна технология «Паровая машина».', RESOURCES='Недостаточно ресурсов для следующего участка.', PATH='Путь заблокирован. Повторная попытка в следующем ходу.', LAND='Прокладка доступна только на суше.', DONE='Маршрут завершён.' }

local function Send(event, params)
    params.OnStart = event
    UI.RequestPlayerOperation(Game.GetLocalPlayer(), PlayerOperations.EXECUTE_SCRIPT, params)
end
local function IsWorker(unit)
    if not unit then return false end
    local kind = GameInfo.Units[unit:GetType()].UnitType
    return kind == 'UNIT_BUILDER' or kind == 'UNIT_MILITARY_ENGINEER'
end
local function Refresh()
    local unit = UI.GetHeadSelectedUnit()
    Controls.BuildRouteGrid:SetHide(not IsWorker(unit))
    if not IsWorker(unit) then return end
    local active = unit:GetProperty('BBC_IS_BUILD_ROUTE') == 1
    local target = unit:GetProperty('BBC_ROAD_TARGET')
    local kind = GameInfo.Units[unit:GetType()].UnitType
    local cost = kind == 'UNIT_BUILDER' and '2 золота за клетку дороги.' or '1 железо и 1 уголь за клетку железной дороги. Нужна «Паровая машина».'
    local tip = 'Автоматическая прокладка: ' .. (active and 'включена' or 'выключена') .. '[NEWLINE]' .. cost
    tip = tip .. '[NEWLINE]Один соседний гекс за ход. Сначала достраивается текущая клетка, если на ней нет нужной дороги.'
    if active and type(target) == 'number' then
        local plot = Map.GetPlotByIndex(target)
        if plot then tip = tip .. '[NEWLINE]Цель: ' .. plot:GetX() .. ', ' .. plot:GetY() .. '.' end
        tip = tip .. '[NEWLINE]Нажмите для отмены. Для ручного движения сначала отмените автопрокладку.'
    else
        tip = tip .. '[NEWLINE]Нажмите кнопку, затем выберите конечную клетку на карте.'
    end
    local status = statuses[unit:GetProperty('BBC_ROAD_STATUS')]
    if status then tip = tip .. '[NEWLINE]' .. status end
    if pickingUnit == unit:GetID() then tip = 'Выбор цели: щёлкните конечную клетку на карте. Esc — отмена; цель выбирается левой или правой кнопкой.[NEWLINE]' .. tip end
    Controls.BuildRouteButton:SetSelected(active or pickingUnit == unit:GetID())
    Controls.BuildRouteButton:SetToolTipString(tip)
end
local function EndPicking()
    local wasPicking = pickingUnit ~= nil
    pickingUnit = nil
    Controls.RoadTargetCapture:SetHide(true)
    Controls.RoadTargetHint:SetHide(true)
    if wasPicking then
        UIManager:DequeuePopup(ContextPtr)
        -- Keep the non-modal controller alive after closing its temporary picker.
        ContextPtr:SetHide(false)
    end
end
local function OnPick()
    local unit = pickingUnit and UnitManager.GetUnit(Game.GetLocalPlayer(), pickingUnit)
    local index = UI.GetCursorPlotID()
    local plot = index and Map.GetPlotByIndex(index)
    if not IsWorker(unit) or not plot or plot:IsWater() or plot:IsMountain() then return end
    local id = unit:GetID()
    prepared[id] = nil
    issued[id] = nil
    Send('BBC_AutoRoadsTarget', {UnitID=id, Target=index})
    EndPicking()
end
local function OnButton()
    local unit = UI.GetHeadSelectedUnit()
    if not IsWorker(unit) then return end
    -- Clear any previously queued long movement before taking control.
    if UnitManager.CanStartCommand(unit, UnitCommandTypes.CANCEL, false) then
        UnitManager.RequestCommand(unit, UnitCommandTypes.CANCEL)
    end
    if unit:GetProperty('BBC_IS_BUILD_ROUTE') == 1 and type(unit:GetProperty('BBC_ROAD_TARGET')) == 'number' then
        Send('BBC_AutoRoadsTarget', {UnitID=unit:GetID(), Cancel=1})
        return
    end
    pickingUnit = unit:GetID()
    local width, height = UIManager:GetScreenSizeVal()
    Controls.RoadTargetCapture:SetSizeVal(width, height)
    UIManager:QueuePopup(ContextPtr, PopupPriority.Current)
    Controls.RoadTargetCapture:SetHide(false)
    Controls.RoadTargetHint:SetHide(false)
    Refresh()
end
local function NextPlot(unit, destination)
    local path = UnitManager.GetMoveToPathEx(unit, destination)
    if not path or not path.plots then return nil end
    local here = Map.GetPlot(unit:GetX(), unit:GetY()):GetIndex()
    for _, index in ipairs(path.plots) do
        if index ~= here then
            local plot = Map.GetPlotByIndex(index)
            if plot and not plot:IsWater() and not plot:IsMountain()
               and Map.GetPlotDistance(unit:GetX(),unit:GetY(),plot:GetX(),plot:GetY()) == 1 then return plot end
            return nil
        end
    end
end
local function AdjacentPathOnly(unit, plot)
    local path = UnitManager.GetMoveToPathEx(unit, plot:GetIndex())
    if not path or not path.plots then return false end
    local here = Map.GetPlot(unit:GetX(),unit:GetY()):GetIndex()
    local count = 0
    for _, index in ipairs(path.plots) do
        if index ~= here then
            if index ~= plot:GetIndex() then return false end
            count = count + 1
        end
    end
    return count == 1
end
local function ProcessUnit(unit, turn)
    if not IsWorker(unit) or unit:GetProperty('BBC_IS_BUILD_ROUTE') ~= 1 then return end
    if unit:GetProperty('BBC_ROAD_STEP_TURN') == turn or unit:GetMovesRemaining() <= 0 then return end
    local destination = unit:GetProperty('BBC_ROAD_TARGET')
    if type(destination) ~= 'number' or destination < 0 then return end
    local id = unit:GetID()
    local key = turn .. ':' .. destination
    local pending = unit:GetProperty('BBC_ROAD_PENDING')
    if unit:GetProperty('BBC_ROAD_PENDING_TURN') == turn and type(pending)=='number' and pending >= 0 then
        if issued[id] == key then return end
        local plot = Map.GetPlotByIndex(pending)
        issued[id] = key
        if not plot or Map.GetPlotDistance(unit:GetX(),unit:GetY(),plot:GetX(),plot:GetY()) ~= 1 or not AdjacentPathOnly(unit, plot) then
            Send('BBC_AutoRoadsStep', {UnitID=id, Blocked=1})
            return
        end
        local params = {}
        params[UnitOperationTypes.PARAM_X] = plot:GetX()
        params[UnitOperationTypes.PARAM_Y] = plot:GetY()
        if UnitManager.CanStartOperation(unit, UnitOperationTypes.MOVE_TO, nil, params) then
            UnitManager.RequestOperation(unit, UnitOperationTypes.MOVE_TO, params)
        else
            Send('BBC_AutoRoadsStep', {UnitID=id, Blocked=1})
        end
        return
    end
    if prepared[id] == key then return end
    prepared[id] = key
    local nextPlot = NextPlot(unit, destination)
    -- -1 still lets gameplay finish or repair the current tile before pausing.
    Send('BBC_AutoRoadsStep', {UnitID=id, NextPlot=nextPlot and nextPlot:GetIndex() or -1})
end
local function Update(delta)
    if not ready then return end
    elapsed = elapsed + delta
    if elapsed < 0.35 then return end
    elapsed = 0
    local playerID = Game.GetLocalPlayer()
    local player = Players[playerID]
    if not player or not player:IsTurnActive() then return end
    for _, unit in player:GetUnits():Members() do ProcessUnit(unit, Game.GetCurrentGameTurn()) end
    Refresh()
end
local function OnInput(input)
    if not pickingUnit then return false end
    local message = input:GetMessageType()
    if message == KeyEvents.KeyUp and input:GetKey() == Keys.VK_ESCAPE then
        EndPicking()
    elseif message == MouseEvents.LButtonUp or message == MouseEvents.RButtonUp then
        OnPick()
    end
    -- A modal target picker must never leak a move order to WorldInput/CQUI.
    return true
end
-- Report engine/API errors through the log available on this Mac.
local function Guard(name, callback)
    return function(...)
        local ok, result = pcall(callback, ...)
        if not ok then
            local message = 'BBC AutoRoads ' .. name .. ': ' .. tostring(result)
            print(message)
            UI.DataError(message)
            Controls.BuildRouteButton:SetToolTipString('Ошибка автопрокладки: ' .. tostring(result))
            return false
        end
        return result
    end
end
local function Initialize()
    local parent = ContextPtr:LookUpControl('/InGame/UnitPanel/StandardActionsStack')
    if not parent then print('BBC AutoRoads: unit panel container missing'); return end
    Controls.BuildRouteGrid:ChangeParent(parent)
    Controls.BuildRouteButton:RegisterCallback(Mouse.eLClick, Guard("button", OnButton))
    Controls.RoadTargetCapture:RegisterCallback(Mouse.eLClick, Guard("target", OnPick))
    Controls.RoadTargetCapture:RegisterCallback(Mouse.eRClick, Guard("target-right", OnPick))
    Events.UnitSelectionChanged.Add(Refresh)
    Events.PlayerTurnDeactivated.Add(EndPicking)
    ContextPtr:SetInputHandler(Guard("input", OnInput), true)
    ContextPtr:SetUpdate(Guard("update", Update))
    EndPicking()
    Refresh()
    ready = true
    print('BBC AutoRoads v3: adjacent-step UI loaded')
end
Events.LoadGameViewStateDone.Add(Guard("initialize", Initialize))
