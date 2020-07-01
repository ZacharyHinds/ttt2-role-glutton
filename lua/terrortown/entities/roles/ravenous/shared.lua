if SERVER then

  AddCSLuaFile()
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_rav.vmt")

end

local AP_NONE = 0
local AP_RAVENOUS = 4

roles.InitCustomTeam(ROLE.name, {
  icon = "vgui/ttt/dynamic/roles/icon_rav",
  color = Color(161, 58, 32, 255)
})

function ROLE:PreInitialize()
  self.color = Color(171, 51, 21, 255)

	self.abbr = "rav" -- abbreviation
	self.surviveBonus = 0.5 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 5 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -16 -- multiplier for teamkill

	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment
	self.defaultTeam = TEAM_RAVENOUS
  self.notSelectable = true

	self.conVarData = {
		credits = 0, -- the starting credits of a specific role
		traitorButton = 0, -- can use traitor buttons
		shopFallback = SHOP_DISABLED
	}
end

function ROLE:Initialize()
  if SERVER and JESTER then
    self.networkRoles = {JESTER}
  end
end

function ROLE:GiveRoleLoadout(ply, isRoleChange)
  if not isRoleChange then return end
  ply:StripWeapons()
  ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")
  ply:SelectWeapon("weapon_ttt_glut_bite")
  ply:SetNWInt("Appetite", AP_RAVENOUS)
end

function ROLE:RemoveRoleLoadout(ply, isRoleChange)
  ply:StripWeapon("weapon_ttt_glut_bite")

end

if SERVER then
  hook.Add("TTTEndRound", "ClearRavBlood", function()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetNWInt("Hunger", nil)
      ply:SetNWBool("DoBloody", false)
      ply:SetNWInt("Appetite", nil)
      ply:SetNWBool("Ate_Full", false)
    end
  end)

  hook.Add("Think", "ThinkRav", function()
    for _, ply in ipairs(player.GetAll()) do
      if ply:IsActive() and ply:GetSubRole() == ROLE_RAVENOUS then
        if ply:GetNWInt("Hunger", 0) < CurTime() and ply:GetSubRole() == ROLE_RAVENOUS then
          ply:TakeDamage(GetConVar("ttt2_rav_hurt"):GetInt(), game.GetWorld())
          ply:SetNWInt("Hunger", CurTime() + 2)
        end
      end
    end
  end)

  hook.Add("TTTPlayerSpeedModifier", "RavSpeedRun", function(ply, _, _, speedMultiplierModifier)
    if not IsValid(ply) then return end
    if ply:GetSubRole() ~= ROLE_RAVENOUS then return end

    speedMultiplierModifier[1] = speedMultiplierModifier[1] * GetConVar("ttt2_rav_speed_bonus"):GetFloat()
  end)

  hook.Add("TTT2StaminaRegen", "RavStaminaRegen", function(ply, stamina_mod)
    if not IsValid(ply) then return end
    if ply:GetSubRole() ~= ROLE_RAVENOUS then return end

    stamina_mod[1] = stamina_mod[1] * GetConVar("ttt2_rav_stam_regen"):GetFloat()
  end)

  hook.Add("TTTEndRound", "ClearRavHunger", function()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetNWInt("Appetite", 0)
      ply:SetNWInt("Hunger", 0)
      ply:SetNWBool("Ate_Full", false)
      ply:SetNWBool("Ate_Part", false)
    end
  end)

  hook.Add("TTTPrepRound", "PrepRavHunger", function()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetNWInt("Appetite", 0)
      ply:SetNWInt("Hunger", 0)
      ply:SetNWBool("Ate_Full", false)
      ply:SetNWBool("Ate_Part", false)
    end
  end)
end
