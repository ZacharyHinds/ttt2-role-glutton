L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[GLUTTON.name] = "Vielfraß"
L["info_popup_" .. GLUTTON.name] = [[Du bist ein Vielfraß!
Friss oder stirb!]]
L["body_found_" .. GLUTTON.abbr] = "Er war ein Vielfraß!"
L["search_role_" .. GLUTTON.abbr] = "Diese Person war ein Vielfraß!"
L["target_" .. GLUTTON.name] = "Vielfraß"
L["ttt2_desc_" .. GLUTTON.name] = [[The Glutton is a Traitor who can feast on the living and the dead to fight their growing hunger.
As your hunger grows, so does your strength. But be careful, if you let it consume you'll need to eat everyone to survive!]]

L[RAVENOUS.name] = "Heißhungriger"
L[RAVENOUS.defaultTeam] = "TEAM Heißhungrige"
L["hilite_win_" .. RAVENOUS.defaultTeam] = "Alle wurden Vielfraße!"
L["info_popup_" .. RAVENOUS.name] = [[Du bist heißhungrig!
Der Hunger frisst dich auf!]]
L["body_found_" .. RAVENOUS.abbr] = "Er war ein Heißhungriger!"
L["search_role_" .. RAVENOUS.abbr] = "Diese Person war ein Heißhungriger!"
L["target_" .. RAVENOUS.name] = "Heißhungriger"
L["ttt2_desc_" .. RAVENOUS.name] = [[Die Heißhungrigen wurden von ihrem Hunger übermannt. Töte jeden, um zu gewinnen!]]

-- Appetite names
L["appetite_hungry"] = "hungrig"
L["appetite_starving"] = "verhungernd"
L["appetite_insatiable"] = "unersättlich"
L["appetite_ravenous"] = "heißhungrig"
L["appetite_HUD"] = "Hunger: {appetite} %"

-- EPOPs
L["glut_hungry_tm"] = "Der Vielfraß ist hungrig!"
L["glut_hungry"] = "Du bist hungrig!"
L["glut_starving_tm"] = "{nick} ist am verhungern!"
L["glut_starving_tm_text"] = "Sein Hunger wächst weiter an!"
L["glut_insatiable_tm"] = "{nick} ist nun unersättlich!"
L["glut_insatiable_tm_text"] = "Wenn sein Hunger weiter steigt wird er dich verraten!"
L["glut_starving"] = "Du bist am verhungern!"
L["glut_starving_text"] = "Dein Biss ist stärker und du bewegst dich schneller, aber dein Hunger steigt schneller!"
L["glut_insatiable"] = "Du bist nun unersättlich!"
L["glut_insatiable_text"] = "Dein Biss ist noch stärker und du bewegst dich noch schneller! Wenn du noch hungriger wirst, bist du auf dich alleine angewiesen!"
L["glut_rav_traitors"] = "Der Vielfraß wurde heißhungrig!"
L["glut_rav_traitors_text"] = "Er wurde von seinem Hunger übermannt und hat die Traitor verraten!"
L["glut_rav"] = "Dein Hunger hat dich übermannt, du bist nun heißhungrig!"
L["glut_rav_text"] = "Du bist kein Traitor mehr. Du musst jeden töten, um zu gewinnen!"
L["glut_rav_all"] = "Der Heißhunrige ist erwacht!"
L["glut_rav_all_text"] = "Achte auf seine blutige Spur, er ist gekommen um zu fressen!"

-- Bite weapon translation
L["glutton_bite_name"] = "Verschlingen"
L["glutbite_hold_key_to_revive"] = "Halte [{key}], um eine Leiche zu verschlingen und deinen Hunger zu nähren!"
L["glutbite_eat_progress"] = "Zeit übrig: {time}s"

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