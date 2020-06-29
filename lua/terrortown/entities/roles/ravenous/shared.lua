if SERVER then

  AddCSLuaFile()

end

roles.InitCustomTeam(ROLE.name, {

  icon = ""

  color = Color(56, 27, 27, 255)

})

function ROLE:PreInitialize()
  self.color = Color(227, 19, 0, 255)

	self.abbr = "gl" -- abbreviation
	self.surviveBonus = 0.5 -- bonus multiplier for every survive while another player was killed
	self.scoreKillsMultiplier = 5 -- multiplier for kill of player of another team
	self.scoreTeamKillsMultiplier = -16 -- multiplier for teamkill

	self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment
	self.defaultTeam = TEAM_TRAITOR
  self.notSelectable = true

	self.conVarData = {
		credits = 0, -- the starting credits of a specific role
		traitorButton = 0, -- can use traitor buttons
		shopFallback = SHOP_DISABLED
	}
end
