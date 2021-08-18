L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[GLUTTON.name] = "Glutton"
L["info_popup_" .. GLUTTON.name] = [[You are a Glutton!
Feed or Starve!]]
L["body_found_" .. GLUTTON.abbr] = "They were a Glutton!"
L["search_role_" .. GLUTTON.abbr] = "This person was a Glutton!"
L["target_" .. GLUTTON.name] = "Glutton"
L["ttt2_desc_" .. GLUTTON.name] = [[The Glutton is a Traitor who can feast on the living and the dead to fight their growing hunger.
As your hunger grows, so does your strength. But be careful, if you let it consume you'll need to eat everyone to survive!]]

L[RAVENOUS.name] = "Ravenous"
L[RAVENOUS.defaultTeam] = "Team Ravenous"
L["hilite_win_" .. RAVENOUS.defaultTeam] = "All Has Been Devoured!"
L["info_popup_" .. RAVENOUS.name] = [[You are Ravenous!
Your Hunger Consumes!]]
L["body_found_" .. RAVENOUS.abbr] = "They were Ravenous!"
L["search_role_" .. RAVENOUS.abbr] = "This person was Ravenous!"
L["target_" .. RAVENOUS.name] = "Ravenous"
L["ttt2_desc_" .. RAVENOUS.name] = [[The Ravenous has been consumed by their hunger, they must kill everyone to win!]]

-- Appetite names
L["appetite_hungry"] = "hungry"
L["appetite_starving"] = "starving"
L["appetite_insatiable"] = "insatiable"
L["appetite_ravenous"] = "ravenous"
L["appetite_HUD"] = "Hunger: {appetite} %"

-- EPOPs
L["glut_hungry_tm"] = "The Glutton is hungry!"
L["glut_hungry"] = "You are hungry!"
L["glut_starving_tm"] = "{nick} is now starving!"
L["glut_starving_tm_text"] = "Their hunger continues to grow!"
L["glut_insatiable_tm"] = "{nick} is now insatiable!"
L["glut_insatiable_tm_text"] = "If their hunger grows much more, they will betray you!"
L["glut_starving"] = "You are now starving!"
L["glut_starving_text"] = "Your bite is stronger, you move faster with it equipped, and your hunger grows more rapidly!"
L["glut_insatiable"] = "You are now insatiable!"
L["glut_insatiable_text"] = "Your bite is stronger, you are faster! If you become hungrier you will be on your own!"
L["glut_rav_traitors"] = "The Glutton has become Ravenous!"
L["glut_rav_traitors_text"] = "They have been consumed by their hunger and betrayed the Traitors!"
L["glut_rav"] = "Your hunger has consumed you, you are now Ravenous!"
L["glut_rav_text"] = "You are no longer a traitor, you must kill all to win!"
L["glut_rav_all"] = "The Ravenous has Awakened!"
L["glut_rav_all_text"] = "Watch for their bloody trail, they have come to eat!"

-- Bite weapon translation
L["glutton_bite_name"] = "Devour"
L["glutbite_hold_key_to_revive"] = "Hold [{key}] to devour the corpse for health and to fill hunger!"
L["glutbite_eat_progress"] = "Time left: {time}s"

-- Event Strings
L["title_event_body_devour"] = "A body was devoured"
L["desc_event_body_devour"] = "{player} devoured {victim}'s body"
L["desc_event_glut_rav_starve"] = "{player} starved to death"
L["title_event_glut_rav_starve"] = "A player starved to death"