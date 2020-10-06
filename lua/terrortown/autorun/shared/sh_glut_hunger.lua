CreateConVar("ttt2_glut_hunger", 180, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE})
if SERVER then
  local ttt2_glut_hunger = GetConVar("ttt2_glut_hunger")

  hook.Add("Think", "GlutHungerThink", function()
    if GetRoundState() ~= ROUND_ACTIVE then return end
    for _, ply in ipairs(player.GetAll()) do
      if not ply:Alive() or ply:IsSpec() then continue end
      if ply:GetSubRole() ~= ROLE_GLUTTON then continue end
      if not ply:GetNWBool("HungerGrows", false) then continue end

      if ply:GetNWInt("Hunger_Level") == 0 and ply.hungerTime <= CurTime() then
        if GetConVar("ttt2_glut_turn_rav"):GetBool() then
          ply:SetRole(ROLE_RAVENOUS, TEAM_RAVENOUS)
          SendFullStateUpdate()
          net.Start("glut_rav")
          net.WriteString(ply:SteamID64())
          net.Broadcast()
        else
          ply:SetNWBool("isStarving", true)
        end
        ply.hungerTime = CurTime() + 2
        ply:SetNWBool("DoBloody", true)
      elseif ply:GetNWInt("Hunger_Level") > 0 and (ply:GetNWBool("DoBloody") or ply:GetNWBool("isStarving")) then
        ply:SetNWBool("DoBloody", false)
        ply:SetNWBool("isStarving", false)
      end

      if ply.hungerTime <= CurTime() then
        ply:SetNWInt("Hunger_Level", math.Clamp(ply:GetNWInt("Hunger_Level", 0) - 1, 0, ttt2_glut_hunger:GetInt()))
        if ply:GetNWInt("Hunger_Level") > 0 then
          ply.hungerTime = CurTime() + 1
        else
          ply.hungerTime = CurTime() + GetConVar("ttt2_glut_rav_grace_time"):GetInt()
        end
      end
    end
  end)

  -- hook.Add("Think", "GlutStarveThink", function()
  --   if GetRoundState() ~= ROUND_ACTIVE then return end
  --   for _, ply in ipairs(player.GetAll()) do
  --     if not ply:Alive() or ply:IsSpec() then continue end
  --
  -- end)

  hook.Add("Think", "RavHungerThink", function()
    if GetRoundState() ~= ROUND_ACTIVE then return end
    for _, ply in ipairs(player.GetAll()) do
      if not ply:Alive() or ply:IsSpec() then continue end
      if ply:GetSubRole() ~= ROLE_RAVENOUS and not (ply:GetNWBool("isStarving") and ply:GetSubRole() == ROLE_GLUTTON) then continue end

      if ply.hungerTime <= CurTime() then
        ply:TakeDamage(GetConVar("ttt2_rav_hurt"):GetInt(), game.GetWorld())
        ply.hungerTime = CurTime() + 2
      end
    end
  end)

  function ResetGlutPly(ply)
    ply:SetNWBool("HungerGrows", true)
    ply:SetNWBool("DoBloody", false)
    ply:SetNWBool("isStarving", false)
    ply:SetNWBool("Knife_Out", false)
    ply.hungerTime = nil
  end

  function ResetGlutton()
    for _, ply in ipairs(player.GetAll()) do
      if ply:GetSubRole() == ROLE_GLUTTON and GetRoundState() == ROUND_ACTIVE then continue end
      -- ply:SetNWInt("Hunger_Level", 0)
      ResetGlutPly(ply)
    end
  end

  hook.Add("TTTEndRound", "ResetGlutton", ResetGlutton)
  hook.Add("TTTPrepRound", "ResetGlutton", ResetGlutton)
  hook.Add("TTTBeginRound", "ResetGlutton", ResetGlutton)

  hook.Add("TTT2PostPlayerDeath", "ResetGlutton", function(ply)
    if ply:GetSubRole() == ROLE_GLUTTON or ply:GetSubRole() == ROLE_RAVENOUS then
      ResetGlutPly(ply)
    end
  end)

  hook.Add("PlayerCanPickupWeapon", "NoRavPickup", function(ply, wep)
    if not ply:Alive() or ply:IsSpec() then return end
    if wep:GetClass() == "weapon_ttt_glut_bite" then
      if ply:GetSubRole() ~= ROLE_GLUTTON and ply:GetSubRole() ~= ROLE_RAVENOUS then
        return false
      else
        return
      end
    end
    if ply:GetSubRole() == ROLE_RAVENOUS then return false end
  end)

end

local ttt2_glut_hunger = GetConVar("ttt2_glut_hunger")
local function GluttonSpeed(ply, _, _, speedMultiplierModifier)
  if not IsValid(ply) then return end
  if not ply:Alive() or ply:IsSpec() then return end
  if (ply:GetSubRole() ~= ROLE_GLUTTON and ply:GetSubRole() ~= ROLE_RAVENOUS) then return end
  if not ply:GetNWBool("Knife_Out", false) then return end

  local base_speed = GetConVar("ttt2_glut_speed_base"):GetFloat()
  local max_speed = GetConVar("ttt2_glut_speed_max"):GetFloat()
  local speed_multi = base_speed + ((max_speed - base_speed) * (1 - (ply:GetNWInt("Hunger_Level") / ttt2_glut_hunger:GetInt())))

  speedMultiplierModifier[1] = speedMultiplierModifier[1] * speed_multi
end

local function GluttonStamina(ply, stamina_mod)
  if not IsValid(ply) then return end
  if not ply:Alive() or ply:IsSpec() then return end
  if (ply:GetSubRole() ~= ROLE_GLUTTON and ply:GetSubRole() ~= ROLE_RAVENOUS) then return end
  if not ply:GetNWBool("Knife_Out") then return end

  local base_stam = GetConVar("ttt2_glut_stamina_base"):GetFloat()
  local max_stam = GetConVar("ttt2_glut_stamina_max"):GetFloat()
  local stamina_multi = base_stam + ((max_stam - base_stam) * (1 - (ply:GetNWInt("Hunger_Level") / ttt2_glut_hunger:GetInt())))

  stamina_mod[1] = stamina_mod[1] * stamina_multi
end

hook.Add("TTTPlayerSpeedModifier", "GlutRavSpeed", GluttonSpeed)
hook.Add("TTT2StaminaRegen", "GlutRavStamina", GluttonStamina)

if CLIENT then
  net.Receive("glut_rav", function()
    local client = LocalPlayer()

    local steam_id = net.ReadString()

    if client:SteamID64() == steam_id then
      EPOP:AddMessage({
          text = LANG.GetTranslation("glut_rav"),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_rav_text")
      )
    elseif client:GetTeam() == TEAM_TRAITOR then
      EPOP:AddMessage({
          text = LANG.GetTranslation("glut_rav_traitors"),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_rav_traitors_text")
      )
    else
      EPOP:AddMessage({
          text = LANG.GetTranslation("glut_rav_all"),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_rav_all_text")
      )
    end
  end)
end
