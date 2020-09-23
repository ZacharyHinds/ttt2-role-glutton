L = LANG.GetLanguageTableReference("italiano")

-- GENERAL ROLE LANGUAGE STRINGS
L[GLUTTON.name] = "Ghiottone"
L["info_popup_" .. GLUTTON.name] = [[Tu sei Ghiottone!
Mangia o muori!]]
L["body_found_" .. GLUTTON.abbr] = "Loro erano Ghiottoni!"
L["search_role_" .. GLUTTON.abbr] = "Questa persona era Ghiottone!"
L["target_" .. GLUTTON.name] = "Ghiottone"
L["ttt2_desc_" .. GLUTTON.name] = [[Il Ghiottone è un traditore che può banchettare con i vivi e i morti per combattere la sua crescente fame.
Come la tua fame cresce, cresce anche la tua forza. Ma stai attento, Se ti fai consumare dalla tua fame avrai bisogno di mangiare!]]

L[RAVENOUS.name] = "Ingordo"
L[RAVENOUS.defaultTeam] = "TEAM Ingordi"
L["hilite_win_" .. RAVENOUS.defaultTeam] = "Tutti sono stati divorati!"
L["info_popup_" .. RAVENOUS.name] = [[Tu sei Ingordo!
La tua fame ti consuma!]]
L["body_found_" .. RAVENOUS.abbr] = "Loro erano Ingordi!"
L["search_role_" .. RAVENOUS.abbr] = "Lui era un Ingordo!"
L["target_" .. RAVENOUS.name] = "Ingordo"
L["ttt2_desc_" .. RAVENOUS.name] = [[L'ingordo è stato consumato dalla fame, Loro devono uccidere tutti per vincere!]]

-- Appetite names
L["appetite_hungry"] = "fame"
L["appetite_starving"] = "affammato"
L["appetite_insatiable"] = "insaziabile"
L["appetite_ravenous"] = "ingordo"
L["appetite_HUD"] = "Fame: {appetite} %"

-- EPOPs
L["glut_hungry_tm"] = "Il Ghiottone ha fame!"
L["glut_hungry"] = "Tu hai Fame!"
L["glut_starving_tm"] = "{nick} è ora affamato!"
L["glut_starving_tm_text"] = "La loro fame continua a salire!"
L["glut_insatiable_tm"] = "{nick} è ora insaziabile!"
L["glut_insatiable_tm_text"] = "Se la loro fame sale molto, Loro ti tradiranno!"
L["glut_starving"] = "Sei ora Affamato!"
L["glut_starving_text"] = "Il tuo morso è forte, ti muovi più veloce quando l'equipaggi, e la tua fama salirà più rapidamente!"
L["glut_insatiable"] = "Tu ora sei insaziabile!"
L["glut_insatiable_text"] = "Il tuo morso è più forte, ti muovi più veloce quando l'equipaggi! Se diventerai più affamato sarai da solo!"
L["glut_rav_traitors"] = "Il Ghiottone è diventato Ingordo!"
L["glut_rav_traitors_text"] = "Loro sono consumati dalla fame e tradiscono i traditori!"
L["glut_rav"] = "La fame ti ha consumato, Ora sei un Ingordo!"
L["glut_rav_text"] = "Non sei più un traditore, devi uccidere tutti per vincere!"
L["glut_rav_all"] = "L'Ingordo si è svegliato !"
L["glut_rav_all_text"] = "Guarda i suoi passi insanguinati, Stanno venendo a mangiarti!"

-- Bite weapon translation
L["glutton_bite_name"] = "Divorare"
L["glutbite_hold_key_to_revive"] = "Tieni [{key}] per mangiare i cadaveri per la vita e diminuire la fame!"
L["glutbite_eat_progress"] = "Tempo rimasto: {time} secondi"
