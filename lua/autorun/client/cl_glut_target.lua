hook.Add("TTTRenderEntityInfo", "ttt2_glut_traitor_highlight", function(tData)
  if not GLUTTON then return end

  local ent = tData:GetEntity()

  if not ent:IsPlayer() then return end

  local ply = LocalPlayer()

  if (ply:GetTeam() ~= TEAM_TRAITOR or ply:GetTeam() ~= ent:GetTeam()) then return end

  if ent:GetSubRole() == ROLE_GLUTTON then
    local appetite_state = ent:GetNWInt("Appetite", 0)
    local appetite_str = ""

    if appetite_state == 0 then
    elseif appetite_state == 1 then
      appetite_str = LANG.GetTranslation("appetite_hungry")
    elseif appetite_state == 2 then
      appetite_str = LANG.GetTranslation("appetite_starving")
    elseif appetite_state == 3 then
      appetite_str = LANG.GetTranslation("appetite_insatiable")
    elseif appetite_state == 4 then
      appetite_str = LANG.GetTranslation("appetite_ravenous")
    end

    if tData:GetAmountDescriptionLines() > 0 then
        tData:AddDescriptionLine()
    end

    tData:AddDescriptionLine(
      LANG.GetParamTranslation("appetite_HUD", {appetite = appetite_str}),
      GLUTTON.ltcolor
    )
  end
end)
