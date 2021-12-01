L = LANG.GetLanguageTableReference("es")

-- GENERAL ROLE LANGUAGE STRINGS
L[GLUTTON.name] = "Glotón"
L["info_popup_" .. GLUTTON.name] = [[¡Eres un Glotón!
¡Aliméntate o muere de hambre!]]
L["body_found_" .. GLUTTON.abbr] = "¡Era un Glotón"
L["search_role_" .. GLUTTON.abbr] = "Esta persona era un Glotón."
L["target_" .. GLUTTON.name] = "Glotón"
L["ttt2_desc_" .. GLUTTON.name] = [[El Glotón es un traidor que puede alimentarse de los demás cuerpos y satisfacer su hambre.
A medida que  tu hambre crezca, también lo hace tu fuerza y velocidad. ¡Ten cuidado, si dejas que el hambre te consuma empezarás a necesitar comer más o incluso transformarte en un Famélico!]]

L[RAVENOUS.name] = "Famélico"
L[RAVENOUS.defaultTeam] = "EQUIPO Famélico"
L["hilite_win_" .. RAVENOUS.defaultTeam] = "¡Todos han sido devorados!"
L["info_popup_" .. RAVENOUS.name] = [[¡Eres un Famélico!
¡Tu hambre te consume!]]
L["body_found_" .. RAVENOUS.abbr] = "¡Era un Famélico!"
L["search_role_" .. RAVENOUS.abbr] = "Esta persona era un Famélico."
L["target_" .. RAVENOUS.name] = "Famélico"
L["ttt2_desc_" .. RAVENOUS.name] = [[El Famélico es un Glotón que fue consumido por su hambre y ahora necesitará comer más para recuperarse.
A este nivel tu velocidad y fuerza es absoluta. Sin embargo, ahora no eres más parte de los traidores y estás completamente solo.]]

-- Appetite names
L["appetite_hungry"] = "hambriento"
L["appetite_starving"] = "en inanición"
L["appetite_insatiable"] = "insasiable"
L["appetite_ravenous"] = "famélico"
L["appetite_HUD"] = "Apetito: {appetite}"

-- EPOPs
L["glut_hungry_tm"] = "¡{nick} está hambriento!"
L["glut_hungry"] = "¡Estás hambriento!"
L["glut_starving_tm"] = "¡{nick} entró en estado de inanición!"
L["glut_starving_tm_text"] = "¡Su hambre continúa!"
L["glut_insatiable_tm"] = "¡{nick} ahora es insasiable! "
L["glut_insatiable_tm_text"] = "¡Si su hambre sigue creciendo, te traicionará!"
L["glut_starving"] = "¡Estás muriendo de hambre!"
L["glut_starving_text"] = "¡Tu mordida es más fuerte, eres más rápido cuando la tengas equipada, pero tu hambre crece más rápido!"
L["glut_insatiable"] = "¡Ahora eres insasiable!"
L["glut_insatiable_text"] = "¡Tu mordida tiene una fuerza inhumana y corres a la velocidad de un tren! ¡Cuidado, si sigues así estarás solo!"
L["glut_rav_traitors"] = "¡{nick} se ha vuelto un Famélico!"
L["glut_rav_traitors_text"] = "¡Fue consumido por el hambre y traicionó a los traidores!"
L["glut_rav"] = "¡Tu hambre te ha ganado, ahora eres un Famélico!"
L["glut_rav_text"] = "¡Ya no eres un traidor! ¡Debes matar a todos para ganar!"
L["glut_rav_all"] = "El Famélico se ha levantado."
L["glut_rav_all_text"] = "Atento a su rastro de sangre, debe estar cerca."

-- Bite weapon translation
L["glutton_bite_name"] = "Devorar"
L["glutbite_hold_key_to_revive"] = "¡Mantén [{key}] para comer el cuerpo y así reducir el hambre y ganar vida!"
L["glutbite_eat_progress"] = "Tiempo restante: {time}s"

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