if CLIENT then
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_rav.vmt")
    EVENT.title = "title_event_glut_rav_starve"
    function EVENT:GetText()
        return {
            {
                string = "desc_event_glut_rav_starve",
                params = {
                    player = self.event.victim.nick,
                    -- role = self.event.glut.role,
                    -- team = self.event.glut.team
                }
            }
        }
    end
end

if SERVER then
    function EVENT:Trigger(victim)
        self.wasStarvation = true
        victim.wasGlutStarveDeath = true

        return self:Add({
            victim = {
                nick = victim:Nick(),
                sid64 = victim:SteamID64()
            }
        })
    end

    hook.Add("TTT2OnTriggeredEvent", "cancel_glut_rav_kill_event", function(type, eventData)
        if type ~= EVENT_KILL then return end

        local ply = player.GetBySteamID64(eventData.victim.sid64)

        if not IsValid(ply) or not ply.wasGlutStarveDeath then return end

        ply.wasGlutStarveDeath = nil

        return false
    end)
end