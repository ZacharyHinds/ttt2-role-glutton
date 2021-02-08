if SERVER then
  AddCSLuaFile()
end

if CLIENT then
  hook.Add("TTT2FinishedLoading", "mes_devicon", function() -- addon developer emblem for me ^_^
    AddTTT2AddonDev("76561198049910438")
  end)

  SWEP.PrintName = "Devour"

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
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.UseHands = true

SWEP.Primary.Damage = 25
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

local swingSound = Sound("WeaponFrag.Throw")
local hitSound = Sound("Flesh.ImpactHard")
local BITE_EAT = 1
local BITE_NONE = 0

local AP_NONE = 0
local AP_HUNGRY = 1
local AP_STARVING = 2
local AP_INSATIABLE = 3
local AP_RAVENOUS = 4

if SERVER then
  function SWEP:Initialize()
    self:SetHoldType("knife")
  end

  function SWEP:SetState(state)
    self:SetNWInt("bite_state", state or BITE_NONE)
  end

  function SWEP:Reset()
    self:SetState(BITE_NONE)
    self.eatTime = nil
    self:GetOwner():SetNWBool("HungerGrows", true)
  end

  function SWEP:SetStartTime(time)
    self:SetNWFloat("bite_start_time", time or 0)
  end

  function SWEP:SetEatTime(time)
    self:SetNWFloat("bite_eat_time", time or 0)
  end

end

function SWEP:Deploy()
  local owner = self:GetOwner()
  owner:SetNWBool("Knife_Out", true)
  return true
end

function SWEP:Holster(weapon)
  local owner = self:GetOwner()
  owner:SetNWBool("Knife_Out", false)
  return true
end

function SWEP:OnDrop()
  self:GetOwner():SetNWBool("Knife_Out", false)
  self:Remove()
end

function SWEP:GetState()
  return self:GetNWInt("bite_state", BITE_NONE)
end

function SWEP:GetStartTime()
  return self:GetNWFloat("bite_start_time", 0)
end

function SWEP:GetEatTime()
  return self:GetNWFloat("bite_eat_time", 0)
end

function SWEP:PrimaryAttack()
  self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

  if not IsValid(self:GetOwner()) then return end

  self:GetOwner():LagCompensation(true)

  local spos = self:GetOwner():GetShootPos()
  local sdest = spos + (self:GetOwner():GetAimVector() * 70)

  local kmins = Vector(1, 1, 1) * -10
  local kmaxs = Vector(1, 1, 1) * 10

  local tr = util.TraceHull({
      start = spos,
      endpos = sdest,
      filter = self:GetOwner(),
      mask = MASK_SHOT_HULL,
      mins = kmins,
      maxs = kmaxs
  })

  if not IsValid(tr.Entity) then
    tr = util.TraceLine({
        start = spos,
        endpos = sdest,
        filter = self:GetOwner(),
        mask = MASK_SHOT_HULL
    })
  end

  local hitEnt = tr.Entity

  if IsValid(hitEnt) then
    self:SendWeaponAnim(ACT_VM_HITCENTER)

    local edata = EffectData()
    edata:SetStart(spos)
    edata:SetOrigin(tr.HitPos)
    edata:SetNormal(tr.Normal)
    edata:SetEntity(hitEnt)

    if hitEnt:IsPlayer() or hitEnt:GetClass() == "prop_ragdoll" then
      self:GetOwner():SetAnimation(PLAYER_ATTACK1)

      self:SendWeaponAnim(ACT_VM_MISSCENTER)

      util.Effect("BloodImpact", edata)
    end

  else
    self:SendWeaponAnim(ACT_VM_MISSCENTER)
  end

  if SERVER then
    self:GetOwner():SetAnimation(PLAYER_ATTACK1)
  end

  if SERVER and tr.Hit and tr.HitNonWorld and IsValid(hitEnt) and hitEnt:IsPlayer() then

    if hitEnt:Health() < (self.Primary.Damage) then
      self:StabKill(tr, spos, sdest)
    else
      local dmg = DamageInfo()
      dmg:SetDamage(self.Primary.Damage)
      dmg:SetAttacker(self:GetOwner())
      dmg:SetInflictor(self)
      dmg:SetDamageForce(self:GetOwner():GetAimVector() * 5)
      dmg:SetDamagePosition(self:GetOwner():GetPos())
      dmg:SetDamageType(DMG_SLASH)

      hitEnt:DispatchTraceAttack(dmg, spos + (self:GetOwner():GetAimVector() * 3), sdest)
      local dmg_dealt = dmg:GetDamage()

      local dmg_ratio = dmg_dealt / GetConVar("ttt2_glut_devour_dmg_max"):GetInt()
      local heal_amount = dmg_dealt * math.Round(GetConVar("ttt2_glut_devour_dmg_heal"):GetFloat(), 1)
      local feed_amount = GetConVar("ttt2_glut_hunger"):GetInt() * math.Round(GetConVar("ttt2_glut_devour_dmg_hunger"):GetFloat() * dmg_ratio, 1)
      if heal_amount + self:GetOwner():Health() < GetConVar("ttt2_glut_rav_max_health"):GetInt() then
        self:GetOwner():SetHealth(math.Clamp(self:GetOwner():Health() + heal_amount, 0, GetConVar("ttt2_glut_rav_max_health"):GetInt()))
      else
        self:GetOwner():SetHealth(GetConVar("ttt2_glut_rav_max_health"):GetInt())
      end
      if self:GetOwner():GetSubRole() == ROLE_GLUTTON then
        self:GetOwner():SetNWInt("Hunger_Level", self:GetOwner():GetNWInt("Hunger_Level") + feed_amount)
      end
    end
  end

  self:GetOwner():LagCompensation(false)
end

function SWEP:StabKill(tr, spos, sdest)
  local target = tr.Entity

  local dmg = DamageInfo()
  dmg:SetDamage(2000)
  dmg:SetAttacker(self:GetOwner())
  dmg:SetInflictor(self)
  dmg:SetDamageForce(self:GetOwner():GetAimVector())
  dmg:SetDamagePosition(self:GetOwner():GetPos())
  dmg:SetDamageType(DMG_SLASH)

  local retr = util.TraceLine({
      start = spos,
      endpos = sdest,
      filter = self:GetOwner(),
      mask = MASK_SHOT_HULL
  })

  if retr.Entity ~= target then
    local center = target:LocalToWorld(target:OBBCenter())

    retr = util.TraceLine({
        start = spos,
        endpos = sdest,
        filter = self:GetOwner(),
        mask = MASK_SHOT_HULL
    })
  end

  local bone = retr.PhysicsBone
  local pos = retr.HitPos
  local norm = tr.Normal

  local ang = Angle(-28, 0, 0) + norm:Angle()
  ang:RotateAroundAxis(ang:Right(), -90)

  pos = pos - (ang:Forward() * 7)

  local ignore = self:GetOwner()

  target.effect_fn = function(rag)
    local rtr = util.TraceLine({start = pos, endpos = pos + norm * 40, filter = ignore, mask = MASK_SHOT_HULL})

    if IsValid(rtr.Entity) and rtr.Entity == rag then
      bone = rtr.PhysicsBone
      pos = rtr.HitPos
      ang = Angle(-28, 0, 0) + rtr.Normal:Angle()
      ang:RotateAroundAxis(ang:Right(), -90)
      pos = pos - (ang:Forward() * 10)
    end

    local knife = ents.Create("prop_physics")
    knife:SetModel("models/weapons/w_knife_t.mdl")
    knife:SetPos(pos)
    knife:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    knife:SetAngles(ang)

    knife.CanPickup = false

    knife:Spawn()

    local phys = knife:GetPhysicsObject()

    if IsValid(phys) then
      phys:EnableCollisions(false)
    end

    constraint.Weld(rag, knife, bone, 0, 0, true)

    -- need to close over knife in order to keep a valid ref to it
    rag:CallOnRemove("ttt_knife_cleanup", function()
      SafeRemoveEntity(knife)
    end)
  end

  target:DispatchTraceAttack(dmg, spos + (self:GetOwner():GetAimVector() * 3), sdest)
  local heal_amount = GetConVar("ttt2_glut_devour_kill_bonus"):GetInt()
  self:GetOwner():SetHealth(math.Clamp(self:GetOwner():Health() + heal_amount, 0, GetConVar("ttt2_glut_rav_max_health"):GetInt()))
  local devour_kill_feed = GetConVar("ttt2_glut_devour_kill_feed"):GetFloat()
  local feed_amount = GetConVar("ttt2_glut_hunger"):GetInt() * devour_kill_feed
  if self:GetOwner():GetSubRole() == ROLE_GLUTTON then
    self:GetOwner():SetNWInt("Hunger_Level", self:GetOwner():GetNWInt("Hunger_Level") + feed_amount)
  end
end

function SWEP:Error()

end

function SWEP:DropRemains(rag)
  if not IsValid(self.eatTarget) then return end
  local pos = self.eatTarget:GetPos()

  local jitter = VectorRand() * 20
  jitter.z = 20
  util.PaintDown(pos + jitter, "Blood", rag)
end

function SWEP:BeginEat(rag)
  if self:GetState() == BITE_EAT then return end

  self:GetOwner():SetNWBool("HungerGrows", false)
  local ply = CORPSE.GetPlayer(rag)

  local hunger_ratio = self:GetOwner():GetNWInt("Hunger_Level") / GetConVar("ttt2_glut_hunger"):GetInt()
  local eat_time_base = GetConVar("ttt2_glut_eat_time_base"):GetFloat()
  local eat_time_max = GetConVar("ttt2_glut_eat_time_max"):GetFloat()
  self.eatTime = eat_time_base + ((eat_time_max - eat_time_base) * hunger_ratio)

  local eatTime = self.eatTime

  self:SetState(BITE_EAT)
  self:SetStartTime(CurTime())
  self:SetEatTime(eatTime)
  self.eatTarget = rag
  timer.Create("EatBlood", GetConVar("ttt2_eat_bleed_amount"):GetFloat(), 0, function(rag)
    self:DropRemains()
  end)
end

function SWEP:FinishEat()
  local body_eat_bonus = GetConVar("ttt2_glut_eat_health"):GetInt()
  local old_max_health = self:GetOwner():GetMaxHealth()
  local new_max_health = math.Clamp(old_max_health + body_eat_bonus, 0, GetConVar("ttt2_glut_rav_max_health"):GetInt())
  -- if new_max_health > GetConVar("ttt2_glut_rav_max_health"):GetInt() then
  --   new_max_health = GetConVar("ttt2_glut_rav_max_health"):GetInt()
  -- end
  local feed_amount = GetConVar("ttt2_glut_hunger"):GetInt() * GetConVar("ttt2_glut_eat_hunger"):GetFloat()

  local health_dif = new_max_health - old_max_health
  if health_dif <= 0 then health_dif = body_eat_bonus end

  self:GetOwner():SetMaxHealth(new_max_health)
  self:GetOwner():SetHealth(math.Clamp(self:GetOwner():Health() + health_dif, 0, GetConVar("ttt2_glut_rav_max_health"):GetInt()))
  -- self:GetOwner():SetNWBool("Ate_Full", true)
  if self:GetOwner():GetSubRole() == ROLE_GLUTTON then
    self:GetOwner():SetNWInt("Hunger_Level", self:GetOwner():GetNWInt("Hunger_Level") + feed_amount)
  end
  timer.Remove("EatBlood")
  if not CLIENT and IsValid(self.eatTarget) then self.eatTarget:Remove() end
  self:Reset()
end

function SWEP:CancelEat()
  timer.Remove("EatBlood")
  self:Reset()
end

if SERVER then
  function SWEP:Think()
    local owner = self:GetOwner()
    local glut_hunger_max = GetConVar("ttt2_glut_hunger"):GetInt()
    local glut_hunger_lvl = owner:GetNWInt("Hunger_Level", 0)
    local hunger_ratio = glut_hunger_lvl / glut_hunger_max

    local devour_dmg_base = GetConVar("ttt2_glut_devour_dmg_base"):GetInt()
    local devour_dmg_max = GetConVar("ttt2_glut_devour_dmg_max"):GetInt()
    self.Primary.Damage = devour_dmg_base + ((devour_dmg_max - devour_dmg_base) * (1 - hunger_ratio))

    if self:GetState() ~= BITE_EAT then return end
    local eat_time_base = GetConVar("ttt2_glut_eat_time_base"):GetFloat()
    local eat_time_max = GetConVar("ttt2_glut_eat_time_max"):GetFloat()
    self.eatTime = eat_time_base + ((eat_time_max - eat_time_base) * hunger_ratio)

    if CurTime() >= self:GetStartTime() + self.eatTime - 0.01 then
      self:FinishEat()
    elseif not owner:KeyDown(IN_ATTACK2) or owner:GetEyeTrace(MASK_SHOT_HULL).Entity ~= self.eatTarget then
      self:CancelEat()
      self:Error()
    end
  end

end

if SERVER then
  function SWEP:SecondaryAttack()
    -- local tr = util.TraceLine({
    --   start = self:GetOwner():GetShootPos(),
    --   endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 100,
    --   filter = self:GetOwner()
    -- })
    local owner = self:GetOwner()
    local trace = owner:GetEyeTrace(MASK_SHOT_HULL)
    local distance = trace.StartPos:Distance(trace.HitPos)
    local ent = trace.Entity

    if distance > 100 or not IsValid(ent) or ent:GetClass() ~= "prop_ragdoll" or not CORPSE.IsValidBody(ent) then return end

    if self:GetState() ~= BITE_NONE then
      self:Error()
      return
    end

    self:BeginEat(ent)

  end
end


if CLIENT then
  function SWEP:SecondaryAttack()

  end
  local colorRed = Color(196, 35, 35)

  hook.Add("TTTRenderEntityInfo", "ttt2_glut_eat_display_info", function(tData)
    local ent = tData:GetEntity()
    local client = LocalPlayer()
    local activeWeapon = client:GetActiveWeapon()
    if ent:GetClass() ~= "prop_ragdoll" or not CORPSE.IsValidBody(ent) then return end
    if not IsValid(activeWeapon) or activeWeapon:GetClass() ~= "weapon_ttt_glut_bite" then return end
    if tData:GetEntityDistance() > 100 then return end
    -- local ply = CORPSE.GetPlayer(ent)
    --
    -- if ply:Alive() and IsValid(ply) then return end
    -- print(activeWeapon:GetState())

    tData:AddDescriptionLine(
      LANG.GetParamTranslation("glutbite_hold_key_to_revive", {key = Key("+attack2", "RIGHT MOUSE")}),
      colorRed
    )
    if activeWeapon:GetState() ~= BITE_EAT then return end
    local progress = math.min((CurTime() - activeWeapon:GetStartTime()) / activeWeapon:GetEatTime(), 1.0)
    local timeLeft = activeWeapon:GetEatTime() - (CurTime() - activeWeapon:GetStartTime())

    local x = 0.5 * ScrW()
    local y = 0.5 * ScrH()
    local w, h = 0.2 * ScrW(), 0.025 * ScrH()

    y = 0.95 * y
    surface.SetDrawColor(50, 50, 50, 220)
    surface.DrawRect(x - 0.5 * w, y - h, w, h)
    surface.SetDrawColor(clr(colorRed))
    surface.DrawOutlinedRect(x - 0.5 * w, y - h, w, h)
    surface.SetDrawColor(clr(ColorAlpha(colorRed, (0.5 + 0.15 * math.sin(CurTime() * 4)) * 255)))
    surface.DrawRect(x - 0.5 * w + 2, y - h + 2, w * progress - 4, h - 4)
    tData:AddDescriptionLine(
      LANG.GetParamTranslation("glutbite_eat_progress", {time = math.Round(timeLeft, 1)}),
      colorRed
    )
    tData:SetOutlineColor(colorRed)

  end)
end
