CreateConVar("ttt2_eat_bleed_amount", 0.05, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Rate at which body bleeds while being eaten using devour
CreateConVar("ttt2_glut_rav_max_health", 250, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Maximum possible health for both glutton and ravenous
CreateConVar("ttt2_glut_do_blood_smoke", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Toggle blood smoke effect
CreateConVar("ttt2_glut_hunger", 300, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})
CreateConVar("ttt2_glut_devour_dmg_heal", 0.2, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_dmg_hunger", 0.1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_dmg_base", 20, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_dmg_max", 100, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_devour_kill_bonus", 10, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- how much heal is earned for kill shot with devour bite
CreateConVar("ttt2_glut_devour_kill_feed", 0.20, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_time_base", 0.50, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_time_max", 5.00, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_health", 50, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_eat_hunger", 0.33, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_speed_base", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_speed_max", 2, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_stamina_base", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_stamina_max", 2, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_glut_rav_grace_time", 5, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_rav_radar_time", 15, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Radar delay for ravenous
CreateConVar("ttt2_glut_turn_rav", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_glut_convars", function(tbl)
  tbl[ROLE_GLUTTON] = tbl[ROLE_GLUTTON] or {}

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_eat_bleed_amount",
    slider = true,
    min = 0.00,
    max = 1.00,
    decimal = 2,
    desc = "ttt2_eat_bleed_amount (def. 0.05)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_do_blood_smoke",
    checkbox = true,
    desc = "ttt2_glut_do_blood_smoke (def. 1)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_turn_rav",
    checkbox = true,
    desc = "ttt2_glut_turn_rav (def. 1)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_hunger",
    slider = true,
    min = 30,
    max = 600,
    desc = "ttt2_glut_hunger (def. 120)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_rav_max_health",
    slider = true,
    min = 100,
    max = 500,
    decimal = 0,
    desc = "ttt2_glut_rav_max_health (def. 250)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_dmg_heal",
    slider = true,
    min = 0,
    max = 1,
    decimal = 1,
    desc = "ttt2_glut_devour_dmg_heal (def. 0.2)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_dmg_hunger",
    slider = true,
    min = 0,
    max = 1,
    decimal = 1,
    desc = "ttt2_glut_devour_dmg_hunger (def. 0.1)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_dmg_base",
    slider = true,
    min = 1,
    max = 100,
    desc = "ttt2_glut_devour_dmg_base (def. 20)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_dmg_max",
    slider = true,
    min = 1,
    max = 200,
    desc = "ttt2_glut_devour_dmg_max (def. 100)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_kill_bonus",
    slider = true,
    min = 1,
    max = 10,
    desc = "ttt2_glut_devour_kill_bonus (def. 10)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_kill_feed",
    slider = true,
    min = 0,
    max = 1,
    decimal = 2,
    desc = "ttt2_glut_devour_kill_feed (def. 0.20)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_eat_time_base",
    slider = true,
    min = 0,
    max = 2,
    decimal = 2,
    desc = "ttt2_glut_eat_time_base (def. 0.50)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_eat_time_max",
    slider = true,
    min = 0,
    max = 10,
    decimal = 2,
    desc = "ttt2_glut_eat_time_max (def. 5.00)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_eat_health",
    slider = true,
    min = 1,
    max = 100,
    desc = "ttt2_glut_eat_health (def. 50)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_eat_hunger",
    slider = true,
    min = 0,
    max = 1,
    decimal = 2,
    desc = "ttt2_glut_eat_hunger (def. 0.33)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_speed_base",
    slider = true,
    min = 0,
    max = 5,
    decimal = 1,
    desc = "ttt2_glut_speed_base (def. 1.0)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_speed_max",
    slider = true,
    min = 0,
    max = 5,
    decimal = 1,
    desc = "ttt2_glut_speed_max (def. 2.0)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_stamina_base",
    slider = true,
    min = 0,
    max = 5,
    decimal = 1,
    desc = "ttt2_glut_stamina_base (def. 1.0)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_stamina_max",
    slider = true,
    min = 0,
    max = 5,
    decimal = 1,
    desc = "ttt2_glut_stamina_max (def. 2.0)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_rav_grace_time",
    slider = true,
    min = 0,
    max = 10,
    desc = "ttt2_glut_rav_grace_time (def. 5)"
  })

end)

CreateConVar("ttt2_rav_hurt", 5, {FCVAR_ARCHIVE, FCVAR_NOTIFY})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_rav_convars", function(tbl)
  tbl[ROLE_RAVENOUS] = tbl[ROLE_RAVENOUS] or {}

  table.insert(tbl[ROLE_RAVENOUS], {
    cvar = "ttt2_rav_radar_time",
    slider = true,
    min = 1,
    max = 60,
    desc = "ttt2_rav_radar_time (def. 15)"
  })

  table.insert(tbl[ROLE_RAVENOUS], {
    cvar = "ttt2_rav_hurt",
    slider = true,
    min = 1,
    max = 25,
    desc = "ttt2_rav_hurt (def. 5)"
  })

end)
