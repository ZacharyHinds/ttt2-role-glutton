L = LANG.GetLanguageTableReference("ru")

-- GENERAL ROLE LANGUAGE STRINGS
L[GLUTTON.name] = "Обжора"
L["info_popup_" .. GLUTTON.name] = [[Вы обжора!
Кормите себя или голодайте!]]
L["body_found_" .. GLUTTON.abbr] = "Он был обжорой!"
L["search_role_" .. GLUTTON.abbr] = "Этот человек был обжорой!"
L["target_" .. GLUTTON.name] = "Обжора"
L["ttt2_desc_" .. GLUTTON.name] = [[Обжора - предатель, который может полакомиться живыми и мёртвыми, чтобы побороть его растущий голод.
По мере того, как растёт ваш голод, растёт и ваша сила. Но будьте осторожны, если вы позволите себе съесть, вам нужно будет съесть всех, чтобы выжить!]]

L[RAVENOUS.name] = "Прожорливый"
L[RAVENOUS.defaultTeam] = "Команда прожорливых"
L["hilite_win_" .. RAVENOUS.defaultTeam] = "Все были поглощены!"
L["info_popup_" .. RAVENOUS.name] = [[Вы голодны!
Ваш голод поглощает!]]
L["body_found_" .. RAVENOUS.abbr] = "Он был прожорливым!"
L["search_role_" .. RAVENOUS.abbr] = "Этот человек был прожорливым!"
L["target_" .. RAVENOUS.name] = "Прожорливый"
L["ttt2_desc_" .. RAVENOUS.name] = [[Прожорливые были поглощены своим голодом, они должны убить всех, чтобы победить!]]

-- Appetite names
L["appetite_hungry"] = "проголодался"
L["appetite_starving"] = "голодный"
L["appetite_insatiable"] = "ненасытный"
L["appetite_ravenous"] = "зверски голодный"
L["appetite_HUD"] = "Голод: {appetite} %"

-- EPOPs
L["glut_hungry_tm"] = "Обжора голоден!"
L["glut_hungry"] = "Вы голодны!"
L["glut_starving_tm"] = "{nick} сейчас голодает!"
L["glut_starving_tm_text"] = "Их голод продолжает расти!"
L["glut_insatiable_tm"] = "{nick} теперь ненасытен!"
L["glut_insatiable_tm_text"] = "Если их голод станет ещё больше, они предадут вас!"
L["glut_starving"] = "Вы сейчас голодаете!"
L["glut_starving_text"] = "Ваш укус сильнее, вы быстрее двигаетесь с ним, и ваш голод растёт быстрее!"
L["glut_insatiable"] = "Вы сейчас ненасытны!"
L["glut_insatiable_text"] = "Ваш укус сильнее, вы быстрее! Если вы станете голоднее, вы будете сами по себе!"
L["glut_rav_traitors"] = "Обжора стал прожорливым!"
L["glut_rav_traitors_text"] = "Они были поглощены своим голодом и предали предателей!"
L["glut_rav"] = "Ваш голод поглотил вас, теперь вы зверски голодны!"
L["glut_rav_text"] = "Вы больше не предатель, вы должны убить всех, чтобы победить!"
L["glut_rav_all"] = "Зверски голодный пробудился!"
L["glut_rav_all_text"] = "Следите за их кровавым следом, они пришли поесть!"

-- Bite weapon translation
L["glutton_bite_name"] = "Пожирать"
L["glutbite_hold_key_to_revive"] = "Удерживайте [{key}], чтобы сожрать труп ради здоровья и утолить голод!"
L["glutbite_eat_progress"] = "Осталось времени: {time}с"
