if SERVER then
  -- CreateConVar("ttt2_rav_radar_time", 15, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Radar delay for ravenous
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

  self.isOmniscientRole = true

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

if SERVER then
  ROLE.CustomRadar = function(ply)
    local targets = {}
    local corpses = ents.FindByClass("prop_ragdoll")

    for _, crp in ipairs(corpses) do
      -- verify bodies
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

    for _, pl in ipairs(player.GetAll()) do
      if not IsValid(pl) or pl == ply or pl:GetTeam() == TEAM_RAVENOUS then continue end
      if pl:IsSpec() or not pl:Alive() then continue end

      local pos = pl:LocalToWorld(pl:OBBCenter())

      pos.x = math.Round(pos.x)
      pos.y = math.Round(pos.y)
      pos.z = math.Round(pos.z)

      local subrole = ROLE_RAVENOUS
      local team = TEAM_RAVENOUS

      targets[#targets + 1] = {
        subrole = subrole,
        team = team,
        pos = pos
      }
    end

    return targets
  end

  ROLE.radarTime = GetConVar("ttt2_rav_radar_time"):GetInt() or 15
end

local function StripPlyWeps(ply)
  local weps = ply:GetWeapons()
  for i = 1, #weps do
    local wep = weps[i]
    if wep:GetClass() == "weapon_ttt_glut_bite" then continue end
    if wep.SetIronSights then wep:SetIronSights(false) end
    if wep.SetZoom then wep:SetZoom(false) end
    ply:StripWeapon(wep:GetClass())
  end
end

function ROLE:GiveRoleLoadout(ply, isRoleChange)
  if not isRoleChange then return end
  StripPlyWeps(ply)
  ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")
  ply:GiveEquipmentItem("item_ttt_radar")
  ply:SelectWeapon("weapon_ttt_glut_bite")
  ply:SetNWInt("Appetite", AP_RAVENOUS)
end

function ROLE:RemoveRoleLoadout(ply, isRoleChange)
  ply:StripWeapon("weapon_ttt_glut_bite")
  ply:RemoveEquipmentItem("item_ttt_radar")
end

if CLIENT then
  function ROLE:AddToSettingsMenu(parent)
    local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

    form:MakeSlider({
      serverConvar = "ttt2_rav_radar_time",
      label = "label_ttt2_rav_radar_time",
      min = 1,
      max = 60,
      decimal = 0
    })

    form:MakeSlider({
      serverConvar = "ttt2_rav_hurt",
      label = "label_ttt2_rav_hurt",
      min = 1,
      max = 25,
      decimal = 0
    })

    -- form:MakeComboBox({
    --   serverConvar = "ttt2_rav_alert",
    --   label = "label_ttt2_rav_alert",
    --   choices = {"label_ttt2_rav_alert_0", "label_ttt2_rav_alert_1", "label_ttt2_rav_alert_2"},
    --   OnChange = function(_, index, _)
    --     RunConsoleCommand("ttt2_rav_alert", index)
    --   end
    -- })

    form:MakeHelp({
      label = "label_ttt2_rav_alert_info"
    })

    form:MakeSlider({
      serverConvar = "ttt2_rav_alert",
      label = "label_ttt2_rav_alert",
      min = 0,
      max = 2,
      decimal = 0
    })

  end
end
