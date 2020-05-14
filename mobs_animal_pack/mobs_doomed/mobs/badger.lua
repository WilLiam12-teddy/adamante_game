mobs:register_mob("mobs_doomed:badger", {
	type = "animal",
	passive = false,
	reach = 1,
	damage = 2,
	attack_type = "dogfight",
	specific_attack = {
		"mobs_doomed:hedgehog",
		"mobs_bugslive:bug",
		"mobs_better_rat:rat",
		"mobs_animal:rat",
	},

	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.3, -0.15, -0.3, 0.3, 0.4, 0.3},
	visual = "mesh",
	mesh = "badger.b3d",
	textures = {
		{"mobs_doomed_badger.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2, y=2},
	makes_footstep_sound = true,
	walk_velocity = 0.7,
	run_velocity = 1,
	jump = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -8,
	fear_height = 4,
	view_range = 14,
	animation = {
		speed_normal = 12,
		speed_run = 18,
		walk_start = 34,
		walk_end = 58,
		stand_start = 1,
		stand_end = 30,
		run_start = 34,
		run_end = 58,
		punch_start = 60,
		punch_end = 80,
	},
	follow = {
		"mobs_doomed:hedgehog",
		"mobs_bugslive:bug",
		"mobs_better_rat:rat",
		"mobs_animal:rat",
		"mobs:egg",
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 5, 50, false, nil) then return end
	end,
})

mobs:register_egg("mobs_doomed:badger", "Badger", "default_obsidian.png", 1)

mobs:spawn_specific("mobs_doomed:badger",
				    {
						"default:dirt_with_grass",
						"default:dirt",
						"default:dirt_with_coniferous_litter"
					},
				    {"air"},
                    0, 14, 30, 300000, 2, 0, 5000)
