hook.Add("TTTRenderEntityInfo", "ttt2_glut_traitor_highlight", function(tData)
  if not GLUTTON then return end
  -- if true then return end

  local ent = tData:GetEntity()

  if not ent:IsPlayer() then return end

  local ply = LocalPlayer()

  if (ply:GetTeam() ~= TEAM_TRAITOR or ply:GetTeam() ~= ent:GetTeam()) then return end

  if ent:GetSubRole() == ROLE_GLUTTON then
    local hunger_max = GetConVar("ttt2_glut_hunger"):GetInt()
    local hunger_lvl = ent:GetNWInt("Hunger_Level")
    local hunger_pct = math.Round(100 - ((hunger_lvl / hunger_max) * 100), 0)

    if tData:GetAmountDescriptionLines() > 0 then
        tData:AddDescriptionLine()
    end

    tData:AddDescriptionLine(
      LANG.GetParamTranslation("appetite_HUD", {appetite = hunger_pct}),
      GLUTTON.ltcolor
    )
  end
end)
