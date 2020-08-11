if CLIENT then
  function DoBloody()
    for _, ply in ipairs(player.GetAll()) do
      if ply:Alive() and ply:GetNWBool("DoBloody", false) and GetConVar("ttt2_glut_do_blood_smoke"):GetBool() then
        if not ply.BloodEmitter then ply.BloodEmitter = ParticleEmitter(ply:GetPos()) end
        if not ply.BloodNextPart then ply.BloodNextPart = CurTime() end

        local pos = ply:GetPos() + Vector(0, 0, 0)
        local client = LocalPlayer()
        if ply.BloodNextPart < CurTime() then
          if client:GetPos():Distance(pos) > 1000 then return end

          ply.BloodEmitter:SetPos(pos)
          ply.BloodNextPart = CurTime() + math.Rand(0.003, 0.01)

          local vec = Vector(math.Rand(-8, 8), math.Rand(-8,8), math.Rand(0, 10))
          local pos = ply:LocalToWorld(vec)
          local particle = ply.BloodEmitter:Add("particle/snow.vmt", pos)
          particle:SetVelocity(Vector(0, 0, -4) + VectorRand() * 3)
          particle:SetDieTime(math.Rand(4, 7 + ply:GetNWInt("Appetite", 0)))
          particle:SetStartAlpha(math.random(200, 255))
          particle:SetEndAlpha(0)
          local size = math.random(4, 7 + ply:GetNWInt("Appetite", 0))
          particle:SetStartSize(size)
          particle:SetEndSize(size + 1*(-1 ^ math.random(1,2)))
          particle:SetRoll(0)
          particle:SetRollDelta(0)
          particle:SetColor(171 - ply:GetNWInt("Appetite")*20, 10, 10)
        end
      else
        if ply.BloodEmitter then
          ply.BloodEmitter:Finish()
          ply.BloodEmitter = nil
        end
      end
    end
  end

  hook.Add("Think", "DoGluttonBlood", function()
    DoBloody()
  end)
end
--
-- if SERVER then
--   hook.Add("PlayerFootstep", "TTT2GlutBloodTrail", function(ply, pos, foot)
--
--   end)
