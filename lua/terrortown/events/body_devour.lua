if CLIENT then
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_glut.vmt")
    EVENT.title = "title_event_body_devour"

    function EVENT:GetText()
        return {
            {
                string = "desc_event_body_devour",
                params = {
                    player = self.event.glut.nick,
                    victim = self.event.victim.nick,

                },
                translateParams = false
            }
        }
    end
end

if SERVER then
    function EVENT:Trigger(glut, victim)

        return self:Add({
            glut = {
                nick = glut:Nick(),
                sid64 = glut:SteamID64()
            },
            victim = {
                nick = victim:Nick(),
                sid64 = glut:SteamID64()
            }
        })
    end

end
function EVENT:Serialize()
    return self.event.glut.nick .. " ate the corpse of " .. self.event.victim.nick
end