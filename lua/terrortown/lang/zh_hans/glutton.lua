L = LANG.GetLanguageTableReference("zh_hans")

-- GENERAL ROLE LANGUAGE STRINGS
L[GLUTTON.name] = "食尸鬼"
L["info_popup_" .. GLUTTON.name] = [[你是个食尸鬼!
吃饱或挨饿!]]
L["body_found_" .. GLUTTON.abbr] = "他们是食尸鬼!"
L["search_role_" .. GLUTTON.abbr] = "这个人是食尸鬼!"
L["target_" .. GLUTTON.name] = "食尸鬼"
L["ttt2_desc_" .. GLUTTON.name] = [[食尸鬼是一个叛徒,他能以生者和死者为食来对抗他们日益增长的饥饿.
随着饥饿的增长,你的力量也在增长.但要小心,如果你让它吃了,你需要吃掉所有人才能生存!]]

L[RAVENOUS.name] = "饥饿者"
L[RAVENOUS.defaultTeam] = "饥饿者队伍"
L["hilite_win_" .. RAVENOUS.defaultTeam] = "一切都被吞噬了!"
L["info_popup_" .. RAVENOUS.name] = [[你饿极了!
你的饥饿消耗!]]
L["body_found_" .. RAVENOUS.abbr] = "他们是饥饿者!"
L["search_role_" .. RAVENOUS.abbr] = "这个人是饥饿者!"
L["target_" .. RAVENOUS.name] = "饥饿者"
L["ttt2_desc_" .. RAVENOUS.name] = [[贪婪的人已经被饥饿吞噬了,他们必须杀死无辜的人才能获胜!]]

-- Appetite names
L["appetite_hungry"] = "感到饿"
L["appetite_starving"] = "饥饿"
L["appetite_insatiable"] = "贪得无厌"
L["appetite_ravenous"] = "极其饥饿的"
L["appetite_HUD"] = "饥饿: {appetite} %"

-- EPOPs
L["glut_hungry_tm"] = "食尸鬼饿了!"
L["glut_hungry"] = "你饿了!"
L["glut_starving_tm"] = "{nick} 现在正在挨饿!"
L["glut_starving_tm_text"] = "他们的饥饿继续增加!"
L["glut_insatiable_tm"] = "{nick} 现在贪得无厌!"
L["glut_insatiable_tm_text"] = "如果他们的饥饿加剧,他们就会背叛你!"
L["glut_starving"] = "你现在饿了!"
L["glut_starving_text"] = "你的咬力更强,装备后你的移动速度更快,饥饿感增长更快!"
L["glut_insatiable"] = "你现在贪得无厌!"
L["glut_insatiable_text"] = "你咬得越厉害,你就越快!如果你变得更饿,你就只能靠自己了!"
L["glut_rav_traitors"] = "暴食者变得贪婪了!"
L["glut_rav_traitors_text"] = "他们被饥饿吞噬,背叛了叛徒!"
L["glut_rav"] = "你的饥饿吞噬了你,你现在又饿了!"
L["glut_rav_text"] = "你不再是叛徒了,你必须杀光一切才能获胜!"
L["glut_rav_all"] = "食尸鬼醒了!"
L["glut_rav_all_text"] = "注意他们的血迹,他们来吃东西了!"

-- Bite weapon translation
L["glutton_bite_name"] = "吞食"
L["glutbite_hold_key_to_revive"] = "按住[{key}]以吞噬尸体以获得健康并填补饥饿!"
L["glutbite_eat_progress"] = "剩下时间: {time}秒"

-- Event Strings
L["title_event_body_devour"] = "一具尸体被吃掉了"
L["desc_event_body_devour"] = "{player} 吞噬 {victim}的身体"
L["desc_event_glut_rav_starve"] = "{player} 饿死了"
L["title_event_glut_rav_starve"] = "一个玩家饿死了"