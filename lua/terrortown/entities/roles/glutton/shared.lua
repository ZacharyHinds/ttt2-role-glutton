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
