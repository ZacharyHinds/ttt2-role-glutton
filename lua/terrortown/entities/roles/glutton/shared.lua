if SERVER then
  AddCSLuaFile()
end

roles.InitCustomTeam(ROLE.name, {
  icon = ""
  color = Color(56, 27, 27, 255)
})

local AP_NONE = 0
local AP_HUNGRY = 1
local AP_STARVING = 2
local AP_INSATIABLE = 3
local AP_RAVENOUS = 4

function ROLE:PreInitialize()
  self.color = Color(227, 19, 0, 255)

	self.abbr = "gl" -- abbreviation
	self.surviveBonus = 0.5 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 5 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -16 -- multiplier for teamkill

	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment
	self.defaultTeam = TEAM_TRAITOR

	self.conVarData = {
		pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 6, -- minimum amount of players until this role is able to get selected
		credits = 0, -- the starting credits of a specific role
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 50,
		traitorButton = 1, -- can use traitor buttons
		shopFallback = SHOP_FALLBACK_TRAITOR
	}
end

function ROLE:Initialize()
  roles.SetBaseRole(self, ROLE_TRAITOR)
end

if SERVER then
  function ROLE:GiveRoleLoadout(ply, isRoleChange)
    if not isRoleChange then return end

    ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")

  end

  function ROLE:RemoveRoleLoadout(ply, isRoleChange)
    ply:StripWeapon("weapon_ttt_glut_bite")

  end

  function GetHunger(ply)
    if not IsValid(ply) or not ply:IsActive() or not ply:IsPlayer() then return end
    if ply:GetSubRole() ~= ROLE_GLUTTON then return end

    local appetite_state = ply:GetNWInt("Appetite", 0)

    if appetite_state == AP_HUNGRY then
      return 30
    elseif appetite_state == AP_STARVING then
      return 20
    elseif appetite_state == AP_INSATIABLE then
      return 10
    elseif appetite_state == AP_RAVENOUS then
      return 0
    end
  end

  function ActivateAppetite(ply)
    if not IsValid(ply) or not ply:IsActive() or not ply:IsPlayer() then return end
    if ply:GetSubRole() ~= ROLE_GLUTTON then return end

    local appetite_state = ply:GetNWInt("Appetite", 0)

    if appetite_state == AP_NONE then return end

    if appetite_state == AP_HUNGRY then
      print(ply:Nick() .. " is Hungry")
    elseif appetite_state == AP_STARVING then
      print(ply:Nick() .. " is Starving")
    elseif appetite_state == AP_INSATIABLE then
      print(ply:Nick() .. " is Insatiable")
    elseif appetite_state == AP_RAVENOUS then
      print(ply:Nick() .. " is Ravenous")
      ply:SetRole(ROLE_RAVENOUS)
    end
  end

  hook.Add("TTTEndRound", "ClearGlutHunger", function()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetNWInt("Appetite", nil)
      ply:SetNWInt("Hunger", nil)
    end
  end)

  hook.Add("TTT2UpdateSubRole", "UpdateGlutRoleSelect", function(ply, old, now)
    if new == ROLE_GLUTTON then
      ply:SetNWInt("Appetite", 1)
      ply:SetNWInt("Hunger", CurTime() + GetHunger(ply))
    end
  end)

  hook.Add("Think", "ThinkHunger", function()
    for _, ply in ipairs(player.GetAll()) do
      if ply:IsActive() and ply:GetSubRole() == ROLE_GLUTTON then
        if ply:GetNWBool("Ate", false) and ply:GetNWInt("Appetite", 0) < AP_RAVENOUS then
          print(ply:Nick() .. " ate!")
          ply:SetNWInt("Hunger", CurTime() + GetHunger(ply))
          ply:SetNWBool("Ate", false)
        end
        if ply:GetNWInt("Hunger", 0) < CurTime() and ply:GetNWInt("Appetite", 0) < AP_RAVENOUS then
          ply:SetNWInt("Appetite", ply:GetNWInt("Appetite", 0) + 1)
          ply:SetNWInt("Hunger", CurTime() + GetHunger(ply))
          ActivateAppetite(ply)
        end
        if ply:GetNWInt("Hunger", 0) < CurTime() and ply:GetNWInt("Appetite", 0) >= AP_RAVENOUS then
          ply:TakeDamage(1, game.GetWorld())
          ply:SetNWInt("Hunger", CurTime() + 1)
        end
      end
    end
  end)

  hook.Add("TTTPlayerSpeedModifier", "GlutSpeedRun", function(ply, _, _, speedMultiplierModifier)
    if not IsValid(ply) then return end

    if not ply:GetNWBool("Knife_Out", false) then
      speedMultiplierModifier[1] = speedMultiplierModifier[1] * 1
      return
    end

    local appetite_state = ply:GetNWInt("Appetite", 0)
    local app_speed_mod = 1

    if appetite_state == 0 then return end

    if appetite_state == 1 then
      app_speed_mod = 1.2
    elseif appetite_state == 2 then
      app_speed_mod = 1.4
    elseif appetite_state == 3 then
      app_speed_mod = 1.6
    elseif appetite_state == 4 then
      app_speed_mod = 1.8
    end

    speedMultiplierModifier[1] = speedMultiplierModifier[1] * app_speed_mod
  end)

  hook.Add("TTT2StaminaRegen", "GlutStaminaRegen", function(ply, stamina_mod)
    if not IsValid(ply) then return end

    if not ply:GetNWBool("Knife_Out", false) then
      stamina_mod[1] = stamina_mod[1] * 1
      return
    end

    local appetite_state = ply:GetNWInt("Appetite", 0)
    local app_stamina_mod = 1

    if appetite_state == 1 then
      app_stamina_mod = 1.2
    elseif appetite_state == 2 then
      app_stamina_mod = 1.5
    elseif appetite_state == 3 then
      app_stamina_mod = 1.8
    elseif appetite_state == 4 then
      app_stamina_mod = 2.0
    end
  end)
end
