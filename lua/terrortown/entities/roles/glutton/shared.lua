if SERVER then
  AddCSLuaFile()
end

function ROLE:PreInitialization()
  self.color = Color(227, 19, 0, 255)

  self.abbr = "glut"
  self.surviveBonus = 0.5
  self.scoreKillsMultiplier = 5
  self.scoreTeamKillsMuiltiplier = -16

  self.defaultTeam = TEAM_TRAITOR
  self.defaultEquipment = SPECIAL_EQUIPMENT

  self.conVarData = {
    pct = 0.1,
    maximum = 1,
    minPlayers = 6,
    togglable = true,
    traitorButton = 1,
    credits = 0,
    shopFallback = SHOP_TRAITOR,
    random = 20
  }
end

function ROLE:Initialize()
  roles.SetBaseRole(self, ROLE_TRAITOR)
end

if SERVER then
  function ROLE:GiveRoleLoadout(ply, isRoleChange)
    if not isRoleChange then return end

    ply:GiveEquipmentWeapon("weapon_ttt_glut_bite")
    ply:GiveEquipmentWeapon("weapon_ttt_glut_consume")
  end

  function ROLE:RemoveRoleLoadout(ply, isRoleChange)
    ply:StripWeapon("weapon_ttt_glut_bite")
    ply:StripWeapon("weapon_ttt_glut_consume")
  end
end
