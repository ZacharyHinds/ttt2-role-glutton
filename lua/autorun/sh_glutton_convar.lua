CreateConVar("ttt2_glut_hungry", 30, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Lenght of hungry stage
CreateConVar("ttt2_glut_starving", 20, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Length of starving stage
CreateConVar("ttt2_glut_insatiable", 10, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Length of insatiable stage
CreateConVar("ttt2_glut_eat_time_hungry", 5.00, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- How long it takes to devour a corpse at the hungry stage
CreateConVar("ttt2_glut_eat_time_starving", 4.00, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- How long it takes to devour a corpse at the starving stage
CreateConVar("ttt2_glut_eat_time_insatiable", 2.00, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- How long it takes to devour a corpse at the insatiable stage
CreateConVar("ttt2_rav_eat_time", 1.00, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- How long it takes a ravenous to devour a corpse
CreateConVar("ttt2_glut_devour_dmg_hungry", 20, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- how much damage devour does at hungry
CreateConVar("ttt2_glut_devour_dmg_starving", 40, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- how much it does at starving
CreateConVar("ttt2_glut_devour_dmg_insatiable", 60, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- devour damage at insatiable
CreateConVar("ttt2_glut_devour_heal_multi", 0.2, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- multiplier applied to damage dealt with devour attack
CreateConVar("ttt2_glut_devour_kill_bonus", 10, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- how much heal is earned for kill shot with devour bite
CreateConVar("ttt2_glut_devour_body_heal", 50, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- how much eating a body is worth
CreateConVar("ttt2_glut_devour_kill_hunger", 0.5, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- multiplier to determine kill's food value
CreateConVar("ttt2_glut_devour_bite_hunger", 0.2, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- multiplier to determine bite's food value
CreateConVar("ttt2_glut_speed_bonus_hungry", 1.2, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- speed bonus for hungry
CreateConVar("ttt2_glut_speed_bonus_starving", 1.4, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- speed bonus for starving
CreateConVar("ttt2_glut_speed_bonus_insatiable", 1.6, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- speed bonus for insatiable
CreateConVar("ttt2_glut_stam_regen_hungry", 1.2, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- sprint regen for hungry
CreateConVar("ttt2_glut_stam_regen_starving", 1.4, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- sprint regen for starving
CreateConVar("ttt2_glut_stam_regen_insatiable", 1.6, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- sprint regen for insatiable
CreateConVar("ttt2_eat_bleed_amount", 0.05, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Rate at which body bleeds while being eaten using devour
CreateConVar("ttt2_glut_rav_max_health", 250, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Maximum possible health for both glutton and ravenous
CreateConVar("ttt2_glut_do_blood_smoke", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- Toggle blood smoke effect

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
    cvar = "ttt2_glut_rav_max_health",
    slider = true,
    min = 100,
    max = 500,
    decimal = 0,
    desc = "ttt2_glut_rav_max_health (def. 250)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_heal_multi",
    slider = true,
    min = 0.0,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_devour_heal_multi (def. 0.2)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_bite_hunger",
    slider = true,
    min = 0.0,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_devour_bite_hunger (def. 0.2)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_body_heal",
    slider = true,
    min = 1,
    max = 100,
    decimal = 0,
    desc = "ttt2_glut_devour_body_heal (def. 50)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_kill_hunger",
    slider = true,
    min = 20,
    max = 200,
    decimal = 0,
    desc = "ttt2_glut_devour_kill_hunger (def. 0.5)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_hungry",
    slider = true,
    min = 10,
    max = 240,
    decimal = 0,
    desc = "ttt2_glut_hungry (def. 30)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_starving",
    slider = true,
    min = 10,
    max = 240,
    decimal = 0,
    desc = "ttt2_glut_starving (def. 20)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_insatiable",
    slider = true,
    min = 10,
    max = 240,
    decimal = 0,
    desc = "ttt2_glut_insatiable (def. 10)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_eat_time_hungry",
    slider = true,
    min = 0.10,
    max = 10.00,
    decimal = 2,
    desc = "ttt2_glut_eat_time_hungry (def. 5.00)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_eat_time_starving",
    slider = true,
    min = 0.10,
    max = 10.00,
    decimal = 2,
    desc = "ttt2_glut_eat_time_starving (def. 4.00)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_eat_time_insatiable",
    slider = true,
    min = 0.10,
    max = 10.00,
    decimal = 2,
    desc = "ttt2_glut_eat_time_insatiable (def. 2.00)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_dmg_hungry",
    slider = true,
    min = 20,
    max = 200,
    decimal = 0,
    desc = "ttt2_glut_devour_dmg_hungry (def. 20)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_dmg_starving",
    slider = true,
    min = 20,
    max = 200,
    decimal = 0,
    desc = "ttt2_glut_devour_dmg_starving (def. 40)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_devour_dmg_insatiable",
    slider = true,
    min = 20,
    max = 200,
    decimal = 0,
    desc = "ttt2_glut_devour_dmg_insatiable (def. 60)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_speed_bonus_hungry",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_speed_bonus_hungry (def. 1.2)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_speed_bonus_starving",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_speed_bonus_starving (def. 1.4)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_speed_bonus_insatiable",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_speed_bonus_insatiable (def. 1.6)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_stam_regen_hungry",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_stam_regen_hungry (def. 1.2)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_stam_regen_starving",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_stam_regen_starving (def. 1.4)"
  })

  table.insert(tbl[ROLE_GLUTTON], {
    cvar = "ttt2_glut_stam_regen_insatiable",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_glut_stam_regen_insatiable (def. 1.2)"
  })

end)

CreateConVar("ttt2_rav_hurt", 5, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- damage per 2 seconds on Ravenous
CreateConVar("ttt2_rav_devour_dmg", 101, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- devour damage for ravenous
CreateConVar("ttt2_rav_speed_bonus", 2.0, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- ravenous speed bonus
CreateConVar("ttt2_rav_stam_regen", 2.0, {FCVAR_ARCHIVE, FCVAR_NOTIFY}) -- ravenous sprint regen

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_rav_convars", function(tbl)
  tbl[ROLE_RAVENOUS] = tbl[ROLE_RAVENOUS] or {}

  table.insert(tbl[ROLE_RAVENOUS], {
    cvar = "ttt2_rav_hurt",
    slider = true,
    min = 0,
    max = 20,
    decimal = 0,
    desc = "ttt2_rav_hurt (def. 5)"
  })

  table.insert(tbl[ROLE_RAVENOUS], {
    cvar = "ttt2_rav_devour_dmg",
    slider = true,
    min = 0,
    max = 200,
    decimal = 0,
    desc = "ttt2_rav_devour_dmg (def. 101)"
  })

  table.insert(tbl[ROLE_RAVENOUS], {
    cvar = "ttt2_rav_speed_bonus",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_rav_speed_bonus (def. 2.0)"
  })

  table.insert(tbl[ROLE_RAVENOUS], {
    cvar = "ttt2_rav_stam_regen",
    slider = true,
    min = 0.1,
    max = 2.0,
    decimal = 1,
    desc = "ttt2_rav_stam_regen (def. 2.0)"
  })

end)
