if not mobs.mod == "redo" then return end

mobs:register_mob("mobs_giraffe:jeraf", {
	type = "animal",
	visual = "mesh",
	mesh = "mobs_jeraf.x",
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	animation = {
		speed_normal = 15,	speed_run = 24,
		stand_start = 0,	stand_end = 30,
		walk_start = 70,	walk_end = 100,
		run_start = 70,		run_end = 100
	},
	textures = {
		{"mobs_jeraf.png"},
	},
	stepheight = 2.1,
	fear_height = 3,
	jump = false,
	jump_height = 4,
	fly = false,
	walk_chance = 75,
	walk_velocity = 2,
	run_velocity = 4,
	view_range = 16,
	passive = true,
	attack_type = "dogfight",
	damage = 10,
	reach = 3,
	runaway = true,
	pathfinding = false,
	hp_min = 8,
	hp_max = 12,
	armor = 200,
	knock_back = 1,
	lava_damage = 5,
	fall_damage = 10,
	water_damage = 1,
	makes_footstep_sound = true,
	knock_back = 1,
	drops = {
		{name = "mobs:meat_raw", chance = 1, min = 1, max = 3},
		{name = "mobs:leather", chance = 1, min = 1, max = 4}
	},
	replace_what = {
		"default:acacia_leaves",
		"default:acacia_sapling",
		"default:acacia_bush_leaves",
		"default:acacia_bush_sapling"
	},
	replace_with = "air",
	replace_rate = 20,
	follow = {
		"default:acacia_leaves",
		"default:acacia_sapling",
		"default:acacia_bush_leaves",
		"default:acacia_bush_sapling"
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 10, true, true) then return end
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
	name = "mobs_giraffe:jeraf",
	nodes = {"default:sand", "default:desert_sand", "default:dirt_with_dry_grass"},
	min_light = 10,
	chance = 300000,
	min_height = l_spawn_elevation_min,
	max_height = 5000,
	day_toggle = true,
})
mobs:register_egg("mobs_giraffe:jeraf", "Giraffe", "wool_yellow.png", 1)
