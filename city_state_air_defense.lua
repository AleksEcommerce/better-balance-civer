-- One AA gun per city-state once any major civilization has Advanced Flight.
-- Save properties persist eligibility and successful grants across reloads.
local UNLOCKED = "BBC_CITYSTATE_AA_UNLOCKED"
local GRANTED = "BBC_CITYSTATE_AA_GRANTED"
local TECH = GameInfo.Technologies["TECH_ADVANCED_FLIGHT"]
local UNIT = GameInfo.Units["UNIT_ANTIAIR_GUN"]

local function TryGrantAirDefense()
    if not TECH or not UNIT then return end
    if not Game:GetProperty(UNLOCKED) then
        for _, player in ipairs(PlayerManager.GetAliveMajors()) do
            if player:GetTechs():HasTech(TECH.Index) then
                Game:SetProperty(UNLOCKED, true)
                print("BBC: city-state AA grants unlocked by Advanced Flight")
                break
            end
        end
    end
    if not Game:GetProperty(UNLOCKED) then return end

    for _, player in ipairs(PlayerManager.GetAliveMinors()) do
        if not player:GetProperty(GRANTED) then
            local capital = player:GetCities():GetCapitalCity()
            if capital then
                local unit = UnitManager.InitUnitValidAdjacentHex(
                    player:GetID(), UNIT.UnitType, capital:GetX(), capital:GetY(), 1)
                if unit then
                    player:SetProperty(GRANTED, true)
                    print("BBC: granted city-state AA gun to player " .. tostring(player:GetID()))
                end
                -- No valid tile: retry next turn; never mark a failed grant as complete.
            end
        end
    end
end

Events.ResearchCompleted.Add(TryGrantAirDefense)
Events.TurnBegin.Add(TryGrantAirDefense)
-- Also handle existing saves and starts in later eras.
TryGrantAirDefense()
