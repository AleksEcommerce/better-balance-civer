-- Gameplay-only ammunition accounting; no local-player or combat-visualization logic.
local TYPE = GameInfo.Units['UNIT_ROCKET_ARTILLERY']
if not TYPE then return end
local SHOTS = 'BBC_ROCKET_ARTILLERY_SHOTS_FIRED'
local COUNTED = 'BBC_ROCKET_ARTILLERY_OPERATION_COUNTED'
local LIMIT = 3
local attack = GameInfo.UnitOperations['UNITOPERATION_RANGE_ATTACK']
local function IsAttack(operation)
    return attack and (operation == attack.Hash or operation == attack.Index)
end
local function GetLauncher(playerID, unitID)
    local u = UnitManager.GetUnit(playerID, unitID)
    if u and u:GetType() == TYPE.Index then return u end
end
local function Shots(u) return u:GetProperty(SHOTS) or 0 end
local function OnOperationAdded(playerID, unitID, operation)
    if not IsAttack(operation) then return end
    local u = GetLauncher(playerID, unitID)
    if u and Shots(u) < LIMIT then u:SetProperty(COUNTED, false) end
end
local function OnCombat(combat)
    local a = combat and combat[CombatResultParameters.ATTACKER]
    local id = a and a[CombatResultParameters.ID]
    if not id then return end
    local u = GetLauncher(id.player, id.id)
    if not u or u:GetProperty(COUNTED) then return end
    local count = math.min(LIMIT, Shots(u) + 1)
    u:SetProperty(SHOTS, count)
    u:SetProperty(COUNTED, true)
    print('BBC rocket artillery: player=' .. tostring(id.player) .. ' unit=' .. tostring(id.id)
        .. ' shots remaining=' .. tostring(LIMIT - count))
end
local function Retire(playerID, unitID)
    local u = GetLauncher(playerID, unitID)
    if u and Shots(u) >= LIMIT then
        print('BBC rocket artillery: ammunition exhausted; retiring ' .. tostring(playerID) .. ':' .. tostring(unitID))
        UnitManager.Kill(u)
    end
end
local function OnOperationEnded(playerID, unitID, operation)
    if IsAttack(operation) then Retire(playerID, unitID) end
end
local function Sweep()
    local list = {}
    for _, p in ipairs(Game.GetPlayers()) do
        for _, u in p:GetUnits():Members() do
            if u:GetType() == TYPE.Index and Shots(u) >= LIMIT then
                list[#list + 1] = {p:GetID(), u:GetID()}
            end
        end
    end
    table.sort(list, function(a,b) return a[1] < b[1] or (a[1] == b[1] and a[2] < b[2]) end)
    for _, id in ipairs(list) do Retire(id[1],id[2]) end
end
local function CanStart(playerID, unitID, operationIndex)
    local u = GetLauncher(playerID, unitID)
    return not u or Shots(u) < LIMIT
end
Events.UnitOperationAdded.Add(OnOperationAdded)
Events.Combat.Add(OnCombat)
Events.UnitOperationDeactivated.Add(OnOperationEnded)
Events.TurnBegin.Add(Sweep)
GameEvents.CanStartOperation.Add(CanStart)
print('BBC rocket artillery: 3-shot prototype loaded')
