if SERVER then
  AddCSLuaFile()
end

if CLIENT then
  SWEP.PrintName = "glutton_eat_name"

  SWEP.ViewModelFlip = false
  SWEP.ViewModelFOV = 54
  SWEP.DrawCrosshair = true

  SWEP.EquipMenuData = {
    type = "item_weapon",
    desc = "knife_desc"
  }

  SWEP.Icon = "vgui/ttt/icon_knife"
  SWEP.IconLetter = "j"
end

SWEP.Base = "weapon_tttbase"

SWEP.HoldType = "knife"
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.UseHands = true

SWEP.Primary.Damage = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 12

SWEP.Kind = WEAPON_SPECIAL

SWEP.HitDistance = 64

SWEP.AllowDrop = false
SWEP.IsSilent = true

-- Pull out faster than standard guns
SWEP.DeploySpeed = 2

function:Initialize()
  self:SetHoldType("knife")
end
