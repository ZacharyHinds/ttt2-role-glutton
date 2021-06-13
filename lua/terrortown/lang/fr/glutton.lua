L = LANG.GetLanguageTableReference("fr")

-- GENERAL ROLE LANGUAGE STRINGS
L[GLUTTON.name] = "Glouton"
L["info_popup_" .. GLUTTON.name] = [[Vous êtes le Glouton!
 Nourris-toi ou meurt de faim!]]
L["body_found_" .. GLUTTON.abbr] = "C'était un Glouton!"
L["search_role_" .. GLUTTON.abbr] = "C'était un Glouton!"
L["target_" .. GLUTTON.name] = "Glouton"
L["ttt2_desc_" .. GLUTTON.name] = [[Le Glouton est un traître qui se régale des vivants et des morts pour combattre sa fringale croissante.
Plus tu auras faim plus tu sera fort. Mais attention, si tu la laisses te consumer, tu devras manger tout le monde pour survivre!]]

L[RAVENOUS.name] = "Vorace"
L[RAVENOUS.defaultTeam] = "Team des Vorace"
L["hilite_win_" .. RAVENOUS.defaultTeam] = "Tout a été dévoré!"
L["info_popup_" .. RAVENOUS.name] = [[Vous êtes Vorace!
Votre faim vous consume!]]
L["body_found_" .. RAVENOUS.abbr] = "C'était un Vorace!"
L["search_role_" .. RAVENOUS.abbr] = "C'était un Vorace!"
L["target_" .. RAVENOUS.name] = "Vorace"
L["ttt2_desc_" .. RAVENOUS.name] = [[Le Vorace est consumé par la faim, il doit tuer tout le monde pour gagner!]]

-- Appetite names
L["appetite_hungry"] = "a faim"
L["appetite_starving"] = "affamé"
L["appetite_insatiable"] = "insatiable"
L["appetite_ravenous"] = "vorace"
L["appetite_HUD"] = "Faim: {appetite} %"

-- EPOPs
L["glut_hungry_tm"] = "Le Glouton a faim!"
L["glut_hungry"] = "Vous avez faim!"
L["glut_starving_tm"] = "{nick} est affamé!"
L["glut_starving_tm_text"] = "Sa faim continue de grandir!"
L["glut_insatiable_tm"] = "{nick} est insatiable!"
L["glut_insatiable_tm_text"] = "Si sa faim augmente encore, il vous trahira!"
L["glut_starving"] = "Vous êtes affamé!"
L["glut_starving_text"] = "Votre morsure est plus forte, vous vous déplacez plus rapidement avec elle équipée et votre faim augmente plus rapidement!"
L["glut_insatiable"] = "Vous êtes insatiable!"
L["glut_insatiable_text"] = "Votre morsure est plus forte, vous êtes plus rapide! Si vous devenez plus affamé, vous serez tout seul!"
L["glut_rav_traitors"] = "Le Glouton est devenue Vorace!"
L["glut_rav_traitors_text"] = "Il a été consumé par la faim et a trahi les traîtres!"
L["glut_rav"] = "Votre faim vous a consumé, vous êtes désormais Vorace!"
L["glut_rav_text"] = "Vous n'êtes plus un traître, vous devez tuer tout le monde pour gagner!"
L["glut_rav_all"] = "Le Vorace s'est réveillé!"
L["glut_rav_all_text"] = "Faites attention aux trainée sanglante, il est venu pour manger!"

-- Bite weapon translation
L["glutton_bite_name"] = "Dévorer"
L["glutbite_hold_key_to_revive"] = "Restez appuyer sur [{key}] pour dévorer le cadavre et obtenir de la vie et combler votre faim!"
L["glutbite_eat_progress"] = "Temps restant: {time}s"

-- Event Strings
L["title_event_body_devour"] = "Un corps a été dévoré"
L["desc_event_body_devour"] = "{player} a dévoré le corps de {victim}"
L["desc_event_glut_rav_starve"] = "{player} est mort de faim"
L["title_event_glut_rav_starve"] = "Un joueur est mort de faim"
