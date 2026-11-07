-- Expanded Initial Vision by TC (Workshop 970242434), adapted for multiplayer.
-- Reveal each human's starting area once, with no local-player state.
local RADIUS = 20
local REVEALED = "BBC_INITIAL_VISION_REVEALED"

local function RevealStartingAreas()
    if Game.GetCurrentGameTurn() ~= GameConfiguration.GetStartTurn() then return end

    local players = PlayerManager.GetAliveMajors()
    table.sort(players, function(a, b) return a:GetID() < b:GetID() end)
    for _, player in ipairs(players) do
        if player:IsHuman() and not player:GetProperty(REVEALED) then
            local start = player:GetStartingPlot()
            local visibility = PlayersVisibility[player:GetID()]
            if start and visibility then
                local visited = {}
                for dx = -RADIUS, RADIUS do
                    for dy = -RADIUS, RADIUS do
                        local plot = Map.GetPlotXYWithRangeCheck(
                            start:GetX(), start:GetY(), dx, dy, RADIUS)
                        if plot and not visited[plot:GetIndex()] then
                            local index = plot:GetIndex()
                            visited[index] = true
                            -- Leave natural wonders for ordinary exploration.
                            if not plot:IsNaturalWonder() then
                                if plot:GetUnitCount() > 0 or plot:IsCity() then
                                    visibility:ChangeVisibilityCount(index, 0)
                                else
                                    visibility:ChangeVisibilityCount(index, 1)
                                    visibility:ChangeVisibilityCount(index, -1)
                                end
                            end
                        end
                    end
                end
                player:SetProperty(REVEALED, true)
            end
        end
    end
end

Events.TurnBegin.Add(RevealStartingAreas)
RevealStartingAreas()
