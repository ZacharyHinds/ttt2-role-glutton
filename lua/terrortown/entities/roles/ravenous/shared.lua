if SERVER then

  AddCSLuaFile()

end

local AP_NONE = 0
local AP_RAVENOUS = 4

roles.InitCustomTeam(ROLE.name, {
  icon = "",
  color = Color(171, 51, 21, 255)
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
  hook.Add("Think", "ThinkRav", function()
    for _, ply in ipairs(player.GetAll()) do
      if ply:IsActive() and ply:GetSubRole() == ROLE_RAVENOUS then
        if ply:GetNWInt("Hunger", 0) < CurTime() and ply:GetSubRole() == ROLE_RAVENOUS then
          ply:TakeDamage(1, game.GetWorld())
          ply:SetNWInt("Hunger", CurTime() + 0.5)
        end
      end
    end
  end)

  hook.Add("TTTPlayerSpeedModifier", "RavSpeedRun", function(ply, _, _, speedMultiplierModifier)
    if not IsValid(ply) then return end
    if ply:GetSubRole() ~= ROLE_RAVENOUS then return end

    speedMultiplierModifier[1] = speedMultiplierModifier[1] * 2
  end)

  hook.Add("TTT2StaminaRegen", "RavStaminaRegen", function(ply, stamina_mod)
    if not IsValid(ply) then return end
    if ply:GetSubRole() ~= ROLE_RAVENOUS then return end

    stamina_mod[1] = stamina_mod[1] * 2
  end)
end
