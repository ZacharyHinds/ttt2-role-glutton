if SERVER then
  AddCSLuaFile()
end

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
  util.AddNetworkString("glut_hungry")
  util.AddNetworkString("glut_starving")
  util.AddNetworkString("glut_insatiable")
  util.AddNetworkString("glut_rav")

  function ROLE:GiveRoleLoadout(ply, isRoleChange)
    if not isRoleChange then return end

    ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")
    ply:SetNWInt("Appetite", 1)
    ply:SetNWInt("Hunger", 30 + CurTime())
    ActivateAppetite(ply)
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
      ply:SetNWBool("DoBloody", true)
      ply:StripWeapons()
      ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")
    elseif appetite_state == AP_RAVENOUS then
      print(ply:Nick() .. " is Ravenous")
      ply:SetRole(ROLE_RAVENOUS)
      SendFullStateUpdate()
    end

    SendPop(appetite_state, ply:SteamID64())
  end

  function SendPop(id, ply_steam)
    local net_id = nil
    if id == AP_HUNGRY then
      net_id = "glut_hungry"
    elseif id == AP_STARVING then
      net_id = "glut_starving"
    elseif id == AP_INSATIABLE then
      net_id = "glut_insatiable"
    elseif id == AP_RAVENOUS then
      net_id = "glut_rav"
    end

    for _, ply in ipairs(player.GetAll()) do
      if ply:IsPlayer() and not ply:IsBot() then
        net.Start(net_id)
        net.WriteString(ply_steam)
        net.WriteBool(true)
        net.Send(ply)
        -- timer.Simple(5, function(ply)
        --   net.Start(net_id)
        --   net.WriteBool(false)
        --   net.Send(ply)
        -- end)
      end
    end
  end

  hook.Add("TTTEndRound", "ClearGlutHunger", function()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetNWInt("Appetite", 0)
      ply:SetNWInt("Hunger", 0)
      ply:SetNWBool("Ate", false)
    end
  end)

  hook.Add("TTTPrepRound", "PrepGlutHunger", function()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetNWInt("Appetite", 0)
      ply:SetNWInt("Hunger", 0)
      ply:SetNWBool("Ate", false)
      ply:SetNWBool("DoBloody", false)
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
      app_stamina_mod = 1.4
    elseif appetite_state == 3 then
      app_stamina_mod = 1.6
    end
  end)
  -- prevent spy and glutton from spawning together
  hook.Add("TTT2ModifySelectableRoles", "TTTGlutOrSpy", function(selectableRoles)
    if not selectableRoles[GLUTTON] or not selectableRoles[SPY] then return end

		if math.random(2) == 2 then
			selectableRoles[GLUTTON] = nil
		else
			selectableRoles[SPY] = nil
		end
  end)
end

if CLIENT then
  net.Receive("glut_hungry", function()
    local client = LocalPlayer()
    client.epopId = client.epopId or {}

    local steam_id = net.ReadString()
    local glut_ply = player.GetBySteamID64(steam_id)
    if IsValid(glut_ply) then
      local glut_nick = glut_ply:Nick()
    else
      local glut_nick = "The Glutton"
    end
    if not glut_nick then glut_nick = "The Glutton" end
    local shouldAdd = net.ReadBool()

    if client:GetTeam() ~= TEAM_TRAITOR then return end

    if shouldAdd then
      if client:SteamID64() == steam_id then
        client.epopId["glut_hungry"] = EPOP:AddMessage(
        {
          text = LANG.GetTranslation("glut_hungry"),
          color = GLUTTON.ltcolor
        }
        )
      else
        client.epopId["glut_hungry"] = EPOP:AddMessage(
        {
          text = LANG.GetParamTranslation("glut_hungry_tm", {nick = glut_nick}),
          color = GLUTTON.ltcolor
        }
        )
      end
    else
      if client.epopId["glut_hungry"] then
        EPOP:RemoveMessage(client.epopId["glut_hungry"])
      end
    end
  end)

  net.Receive("glut_starving", function()
    local client = LocalPlayer()
    client.epopId = client.epopId or {}

    local steam_id = net.ReadString()
    local glut_ply = player.GetBySteamID64(steam_id)
    if IsValid(glut_ply) then
      local glut_nick = glut_ply:Nick()
    else
      local glut_nick = "The Glutton"
    end
    if not glut_nick then glut_nick = "The Glutton" end
    local shouldAdd = net.ReadBool()

    if client:GetTeam() ~= TEAM_TRAITOR then return end

    if shouldAdd then
      if client:SteamID64() == steam_id then
        client.epopId["glut_starving"] = EPOP:AddMessage(
        {
          text = LANG.GetTranslation("glut_starving"),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_starving_text")
        )
      else
        client.epopId["glut_starving"] = EPOP:AddMessage(
        {
          text = LANG.GetParamTranslation("glut_starving_tm", {nick = glut_nick}),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_starving_tm_text")
        )
      end
    else
      if client.epopId["glut_starving"] then
        EPOP:RemoveMessage(client.epopId["glut_starving"])
      end
    end
  end)

  net.Receive("glut_insatiable", function()
    local client = LocalPlayer()
    client.epopId = client.epopId or {}

    local steam_id = net.ReadString()
    local glut_ply = player.GetBySteamID64(steam_id)
    if IsValid(glut_ply) then
      local glut_nick = glut_ply:Nick()
    else
      local glut_nick = "The Glutton"
    end
    if not glut_nick then glut_nick = "The Glutton" end
    local shouldAdd = net.ReadBool()

    if client:GetTeam() ~= TEAM_TRAITOR then return end

    if shouldAdd then
      if client:SteamID64() == steam_id then
        client.epopId["glut_insatiable"] = EPOP:AddMessage(
        {
          text = LANG.GetTranslation("glut_insatiable"),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_insatiable_text")
        )
      else
        client.epopId["glut_insatiable"] = EPOP:AddMessage(
        {
          text = LANG.GetParamTranslation("glut_insatiable_tm", {nick = glut_nick}),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_insatiable_tm_text")
        )
      end
    else
      if client.epopId["glut_insatiable"] then
        EPOP:RemoveMessage(client.epopId["glut_insatiable"])
      end
    end
  end)

  net.Receive("glut_rav", function()
    local client = LocalPlayer()
    client.epopId = client.epopId or {}

    local steam_id = net.ReadString()
    local glut_ply = player.GetBySteamID64(steam_id)
    if IsValid(glut_ply) then
      local glut_nick = glut_ply:Nick()
    else
      local glut_nick = "The Glutton"
    end
    if not glut_nick then glut_nick = "The Glutton" end
    local shouldAdd = net.ReadBool()

    if shouldAdd then
      if client:SteamID64() == steam_id then
        client.epopId["glut_rav"] = EPOP:AddMessage(
        {
          text = LANG.GetTranslation("glut_rav"),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_rav_text")
        )
      elseif client:GetTeam() == TEAM_TRAITOR then
        client.epopId["glut_rav"] = EPOP:AddMessage(
        {
          text = LANG.GetParamTranslation("glut_rav_traitors", {nick = glut_nick}),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_rav_traitors_text")
        )
      else
        client.epopId["glut_rav"] = EPOP:AddMessage(
        {
          text = LANG.GetTranslation("glut_rav_all"),
          color = GLUTTON.ltcolor
        },
        LANG.GetTranslation("glut_rav_all_text")
        )
      end
    else
      if client.epopId["glut_rav"] then
        EPOP:RemoveMessage(client.epopId["glut_rav"])
      end
    end
  end)
end
