if not mobs.mod == "redo" then return end

mobs:register_mob("mobs_better_rat:rat", {
	type = "animal",
	visual = "mesh",
	mesh = "rat.b3d",
	rotate = 180,
	collisionbox = {-0.1, -0.01, -0.1, 0.1, 0.1, 0.1},
	textures = {
		{"rat_black.png"},
		{"rat_brown.png"},
		{"rat_gray.png"},
		{"rat_white.png"}
	},
	stepheight = 1.1,
	runaway = true,
	jump_height = 2,
	fly = false,
	walk_chance = 60,
	walk_velocity = 2,
	run_velocity = 4,
	view_range = 8,
	passive = true,
	attack_type = "dogfight",
	damage = 1,
	reach = 1,
	pathfinding = false,
	group_attack = true,
	hp_min= 2,
	hp_max = 5,
	armor = 80,
	lava_damage = 2,
	fall_damage = 0,
	water_damage = 1,
	recovery_time = 0.25,
	blood_amount = 1,
	drops = {
		{name = "mobs:cheese", chance = 1, min = 1, max = 2},
	},
	replace_what = {
		"mobs:cheese",
		"mobs:cheeseblock",
		"mobs_mr_goat:goatcheese",
		"mobs_mr_goat:goatcheeseblock",
		"farming:barley_5",
		"farming:barley_6",
		"farming:barley_7",
		"farming_corn_7.png",
		"farming_corn_8.png",
		"farming:wheat_5",
		"farming:wheat_6",
		"farming:wheat_7",
		"farming:wheat_8"
	},
	replace_with = "air",
	replace_rate = 10,
	follow = {"mobs:cheese", "mobs_mr_goat:goatcheese"},
	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 25, 80, 0, true, "mobs_better_rat:rat")
	end
})

--name, nodes, neighbors, min_light, max_light, interval, chance, active_object_count, min_height, max_height
mobs:spawn_specific("mobs_better_rat:rat",
	{"default:stone"},
	{"air"},
	0, 14, 30, 300000, 2, -25000, 5000
)
mobs:register_egg("mobs_better_rat:rat", "Mouse", "wool_brown.png", 1)
