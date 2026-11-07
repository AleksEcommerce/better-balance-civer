-- Gameplay-only deterministic grants. No UI, local-player state, timers or randomness.
local UNLOCKED = 'BBC_AI_AA_UNLOCKED'
local GRANTED = 'BBC_AI_AA_TOTAL_GRANTED'
local UNIT_TYPE = 'UNIT_BBC_AI_GIFT_ANTIAIR'
local TECH = GameInfo.Technologies['TECH_ADVANCED_FLIGHT']
local UNIT = GameInfo.Units[UNIT_TYPE]
local running = false
local function SortedMajors()
    local list = {}
    for _, p in ipairs(PlayerManager.GetAliveMajors()) do list[#list + 1] = p end
    table.sort(list, function(a,b) return a:GetID() < b:GetID() end)
    return list
end
local function Grant()
    if running or not TECH or not UNIT then return end
    running = true
    local players = SortedMajors()
    if not Game:GetProperty(UNLOCKED) then
        for _, p in ipairs(players) do
            if p:GetTechs():HasTech(TECH.Index) then
                Game:SetProperty(UNLOCKED, true)
                break
            end
        end
    end
    if Game:GetProperty(UNLOCKED) then
        for _, p in ipairs(players) do
            if not p:IsHuman() then
                local cities = {}
                for _, city in p:GetCities():Members() do cities[#cities+1] = city end
                local quota = math.floor(#cities / 3)
                local granted = p:GetProperty(GRANTED) or 0
                local capital = p:GetCities():GetCapitalCity()
                local capitalID = capital and capital:GetID()
                table.sort(cities, function(a,b)
                    local ac,bc = a:GetID()==capitalID, b:GetID()==capitalID
                    if ac~=bc then return ac end
                    if a:GetPopulation()~=b:GetPopulation() then return a:GetPopulation()>b:GetPopulation() end
                    return a:GetID()<b:GetID()
                end)
                -- The city stamp is permanent: no repeated grants after a loss or recapture.
                local cityStamp = 'BBC_AI_AA_CITY_GRANTED_' .. tostring(p:GetID())
                for _, city in ipairs(cities) do
                    if granted >= quota then break end
                    if not city:GetProperty(cityStamp) then
                        local unit = UnitManager.InitUnitValidAdjacentHex(
                            p:GetID(), UNIT_TYPE, city:GetX(), city:GetY(), 1)
                        if unit then
                            granted = granted + 1
                            p:SetProperty(GRANTED, granted)
                            city:SetProperty(cityStamp, true)
                            unit:SetProperty('BBC_AI_AA_GIFT', true)
                            print('BBC AI AA: player=' .. p:GetID() .. ' city=' .. city:GetID()
                                .. ' lifetime grants=' .. granted .. ' quota=' .. quota)
                        end
                        -- Blocked city: try the next ranked city, then retry next turn if needed.
                    end
                end
            end
        end
    end
    running = false
end
Events.ResearchCompleted.Add(Grant)
Events.TurnBegin.Add(Grant)
Grant()
