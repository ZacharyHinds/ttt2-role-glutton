L = LANG.GetLanguageTableReference("it")

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

--SETTING STRINGS
    --GLUTTON
    -- L["label_ttt2_eat_bleed_amount"] = "Blood decal spawn rate when eating"
    -- L["label_ttt2_glut_hunger"] = "Seconds to completely empty hunger"
    -- L["label_ttt2_glut_rav_max_health"] = "Maximum health"
    -- L["label_ttt2_glut_devour_dmg_heal"] = "Healing from Devour damage"
    -- L["label_ttt2_glut_devour_dmg_hunger"] = "Hunger replenish Devour from damage"
    -- L["label_ttt2_glut_devour_dmg_base"] = "Base Devour damage"
    -- L["label_ttt2_glut_devour_dmg_max"] = "Maximum Devour damage"
    -- L["label_ttt2_glut_devour_kill_bonus"] = "Healing from kill with Devour"
    -- L["label_ttt2_glut_devour_kill_feed"] = "Hunger replenish from kill with Devour"
    -- L["label_ttt2_glut_eat_time_base"] = "Base time to eat"
    -- L["label_ttt2_glut_eat_time_max"] = "Maximum time to eat"
    -- L["label_ttt2_glut_eat_health"] = "Health from Devouring player corpse"
    -- L["label_ttt2_glut_eat_hunger"] = "Hunger replenish from Devouring player corpse"
    -- L["label_ttt2_glut_speed_base"] = "Base movement speed multiplier with Devour equipped"
    -- L["label_ttt2_glut_speed_max"] = "Maximum speed multiplier with Devour equipped"
    -- L["label_ttt2_glut_stamina_base"] = "Base stamina regen multiplier with Devour equipped"
    -- L["label_ttt2_glut_stamina_max"] = "Maximum stamina multiplier with Devour equipped"
    -- L["label_ttt2_glut_rav_grace_time"] = "Seconds it takes to transform after empty hunger"
        
    --RAVENOUS
    -- L["label_ttt2_rav_radar_time"] = "Delay between radar pulses"
    -- L["label_ttt2_rav_hurt"] = "Damage received per tick"
    -- L["label_ttt2_rav_alert"] = "Transformation Alert Mode"
    -- L["label_ttt2_rav_alert_info"] = [[
    --     Ravenous Alert Modes:
        
    --     0 - No Alert except for transforming player
    --     1 - Alert All Players
    --     2 - Alert Glutton's Teammates
    -- ]]