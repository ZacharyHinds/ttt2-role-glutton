CreateConVar("ttt2_eat_bleed_amount", 0.05, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Rate at which body bleeds while being eaten using devour
CreateConVar("ttt2_glut_rav_max_health", 250, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Maximum possible health for both glutton and ravenous
CreateConVar("ttt2_glut_do_blood_smoke", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Toggle blood smoke effect
CreateConVar("ttt2_glut_hunger", 120, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})
CreateConVar("ttt2_glut_devour_dmg_heal", 0.2, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_dmg_hunger", 0.1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_dmg_base", 20, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_dmg_max", 100, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_kill_bonus", 10, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- how much heal is earned for kill shot with devour bite
CreateConVar("ttt2_glut_devour_kill_feed", 0.20, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_time_base", 0.50, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_time_max", 5.00, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_health", 50, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_hunger", 0.33, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_speed_base", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_speed_max", 2, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_stamina_base", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_stamina_max", 2, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_rav_grace_time", 5, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_rav_radar_time", 15, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Radar delay for ravenous
CreateConVar("ttt2_glut_turn_rav", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_rav_alert", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Whether or not to send playerwide alert

if SERVER then
  AddCSLuaFile()
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_glut.vmt")
end

local AP_NONE = 0
local AP_HUNGRY = 1
local AP_STARVING = 2
local AP_INSATIABLE = 3
local AP_RAVENOUS = 4

function ROLE:PreInitialize()
  self.color = Color(199, 40, 16, 255)

  self.abbr = "glut" -- abbreviation
  self.surviveBonus = 0.5 -- bonus multiplier for every survive while another player was killed
  self.scoreKillsMultiplier = 5 -- multiplier for kill of player of another team
  self.scoreTeamKillsMultiplier = -16 -- multiplier for teamkill

  self.isOminiscientRole = true

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
    shopFallback = SHOP_DISABLED
  }
end

function ROLE:Initialize()
  roles.SetBaseRole(self, ROLE_TRAITOR)
end

if SERVER then
  util.AddNetworkString("glut_rav")
  ROLE.CustomRadar = function(ply)
    local targets = {}
    local corpses = ents.FindByClass("prop_ragdoll")

    for _, crp in ipairs(corpses) do
      if not crp.player_ragdoll then continue end

      local pos = crp:LocalToWorld(crp:OBBCenter())

      pos.x = math.Round(pos.x)
      pos.y = math.Round(pos.y)
      pos.z = math.Round(pos.z)

      targets[#targets + 1] = {
        subrole = -1,
        pos = pos
      }
    end

    return targets
  end


  function ROLE:GiveRoleLoadout(ply, isRoleChange)
    if not isRoleChange then return end

    ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")
    ply:GiveEquipmentItem("item_ttt_radar")
    ply:SetNWInt("Hunger_Level", GetConVar("ttt2_glut_hunger"):GetInt())
    ply:SetNWBool("HungerGrows", true)
    ply:SetNWBool("isStarving", false)
    ply.hungerTime = CurTime() + 1
    -- ActivateAppetite(ply)
  end

  function ROLE:RemoveRoleLoadout(ply, isRoleChange)
    if not isRoleChange or ply:GetSubRole() == ROLE_RAVENOUS then return end
    ply:StripWeapon("weapon_ttt_glut_bite")
  end

  hook.Add("PlayerSpawn", "GlutRavRevive", function(ply)
    if ply:GetSubRole() ~= ROLE_GLUTTON and ply:GetSubRole() ~= ROLE_RAVENOUS then return end
    ply.hungerTime = CurTime() + 1
    ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")
  end)
end

if CLIENT then
  function ROLE:AddToSettingsMenu(parent)
    local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

    form:MakeSlider({
      serverConvar = "ttt2_eat_bleed_amount",
      label = "label_ttt2_eat_bleed_amount",
      min = 0,
      max = 1,
      decimal = 2
    })

    form:MakeCheckBox({
      serverConvar = "ttt2_glut_turn_rav",
      label = "label_ttt2_glut_turn_rav"
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_hunger",
      label = "label_ttt2_glut_hunger",
      min = 30,
      max = 600,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_rav_max_health",
      label = "label_ttt2_glut_rav_max_health",
      min = 100,
      max = 500,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_devour_dmg_heal",
      label = "label_ttt2_glut_devour_dmg_heal",
      min = 0,
      max = 1,
      decimal = 1
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_devour_dmg_hunger",
      label = "label_ttt2_glut_devour_dmg_hunger",
      min = 0,
      max = 1,
      decimal = 1
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_devour_dmg_base",
      label = "label_ttt2_glut_devour_dmg_base",
      min = 1,
      max = 100,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_devour_dmg_max",
      label = "label_ttt2_glut_devour_dmg_max",
      min = 1,
      max = 200,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_devour_kill_bonus",
      label = "label_ttt2_glut_devour_kill_bonus",
      min = 1,
      max = 10,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_devour_kill_feed",
      label = "label_ttt2_glut_devour_kill_feed",
      min = 0,
      max = 1,
      decimal = 2
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_eat_time_base",
      label = "label_ttt2_glut_eat_time_base",
      min = 0,
      max = 2,
      decimal = 2
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_eat_time_max",
      label = "label_ttt2_glut_eat_time_max",
      min = 0,
      max = 10,
      decimal = 2
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_eat_health",
      label = "label_ttt2_glut_eat_health",
      min = 1,
      max = 100,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_eat_hunger",
      label = "label_ttt2_glut_eat_hunger",
      min = 0,
      max = 1,
      decimal = 2
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_speed_base",
      label = "label_ttt2_glut_speed_base",
      min = 0,
      max = 5,
      decimal = 1
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_speed_max",
      label = "label_ttt2_glut_speed_max",
      min = 0,
      max = 5,
      decimal = 1
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_stamina_base",
      label = "label_ttt2_glut_stamina_base",
      min = 0,
      max = 5,
      decimal = 1
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_stamina_max",
      label = "label_ttt2_glut_stamina_max",
      min = 0,
      max = 5,
      decimal = 1
    })

    form:MakeSlider({
      serverConvar = "ttt2_glut_rav_grace_time",
      label = "label_ttt2_glut_rav_grace_time",
      min = 0,
      max = 10,
      decimal = 0
    })

  end
end
