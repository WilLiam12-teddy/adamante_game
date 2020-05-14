if not mobs.mod == "redo" then return end

mobs:register_mob("mobs_deer:deer", {
	type = "animal",
	visual = "mesh",
	mesh = "mobs_deer2.x",
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	animation = {
		speed_normal = 15,	speed_run = 24,
		stand_start = 25,	stand_end = 75,
		walk_start = 75,	walk_end = 100,
		run_start = 75,		run_end = 100
	},
	textures = {
		{"mobs_deer.png"},
	},
	stepheight = 1.1,
	fear_height = 2,
	jump = true,
	fly = false,
	walk_chance = 75,
	run_velocity = 3,
	view_range = 14,
	passive = true,
	attack_type = "dogfight",
	damage = 10,
	reach = 3,
	runaway = true,
	pathfinding = false,
	hp_min = 4,
	hp_max = 8,
	armor = 200,
	knock_back = 1,
	lava_damage = 5,
	fall_damage = 5,
	water_damage = 1,
	makes_footstep_sound = true,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 2},
		{name = "mobs:leather", chance = 1, min = 1, max = 3}
	},

	replace_what = {
		"group:grass",
		"group:plant",
		"group:flora",
		"default:apple",
	},
	replace_with = "air",
	replace_rate = 20,
	follow = {
		"group:flora",
		"group:grass",
		"farming:wheat",
		"default:apple",
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 80, false, nil) then return end
	end
})

local l_spawn_elevation_min = minetest.setting_get("water_level")
if l_spawn_elevation_min then
	l_spawn_elevation_min = l_spawn_elevation_min + 1
else
	l_spawn_elevation_min = 1
end
mobs:spawn({
	name = "mobs_deer:deer",
	nodes = {
		"default:dirt_with_grass",
		"default:dirt_with_coniferous_litter",
		"ethereal:green_dirt_top"
	},
	min_light = 10,
	chance = 300000,
	min_height = l_spawn_elevation_min,
	max_height = 5000,
	day_toggle = true,
})
mobs:register_egg("mobs_deer:deer", "Deer", "wool_violet.png", 1)
