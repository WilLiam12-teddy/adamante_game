if not mobs.mod == "redo" then return end

mobs:register_mob("mobs_bear:medved", {
	type = "animal",
	visual = "mesh",
	visual_size = {x=1.5, y=1.5},
	mesh = "mobs_medved.x",
	rotate = 0,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	animation = {
		speed_normal = 15,	speed_run = 30,
		stand_start = 0,	stand_end = 30,
		walk_start = 35,	walk_end = 65,
		run_start = 105,	run_end = 135,
		punch_start = 70,	punch_end = 100,
	},
	textures = {
		{"mobs_medved.png"},
		{"mobs_medved_dark.png"}
	},
	fear_height = 2,
	runaway = false,
	jump = true,
	fly = false,
	walk_chance = 75,
	run_velocity = 3,
	view_range = 12,

	passive = false,
	attack_type = "dogfight",
	damage = 10,
	reach = 3,
	attacks_monsters = true,
	specific_attack = {
		"mobs_doomed:hedgehog",
		"mobs_bugslive:bug",
		"mobs_better_rat:rat",
		"mobs_animal:rat",
	},
	pathfinding = true,
	hp_min = 10,
	hp_max = 25,
	armor = 100,
	knock_back = 1,
	lava_damage = 10,
	fall_damage = 5,
	water_damage = 1,
	makes_footstep_sound = true,
	drops = {
		{name="mobs:meat_raw", chance=1, min=1, max=2},
		{name="mobs:leather", chance=1, min=1, max=2}
	},

	replace_what = {
		"mobs:beehive",
		"mobs:honey_block",
		"mobs_bugslive:bug",
		"farming:blueberry_4",
		"farming:raspberry_4"
	},
	replace_with = "air",
	replace_rate = 20,

	follow = {
		"mobs:honey",
		"xdecor:honey",
		"farming:blueberries",
		"farming:raspberries",
		"mobs_fish:clownfish",
		"mobs_fish:tropical",
		"extra:ground_meat",
		"extra:meat_patty",
		"mobs:meat_raw",
		"mobs:mutton_raw",
		"mobs:pork_raw",
		"mobs:rabbit_raw",
	},
	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 10, true, true) then return end
		if mobs:protect(self, clicker) then return end
		if mobs:capture_mob(self, clicker, 0, 0, 80, false, nil) then return end

		if clicker:get_wielded_item():is_empty() and clicker:get_player_name() == self.owner then
			if clicker:get_player_control().sneak then
				self.order = ""
				self.state = "walk"
				self.walk_velocity = 1
			else
				if self.order == "follow" then
					self.order = "stand"
					self.state = "stand"
					self.walk_velocity = 1
				else
					self.order = "follow"
					self.state = "walk"
					self.walk_velocity = 3
				end
			end
			return
		end
	end
})

local l_spawn_elevation_min = (minetest.setting_get("water_level") or 0) - 10
mobs:spawn({
	name = "mobs_bear:medved",
	nodes = {"default:dirt_with_grass", "ethereal:green_dirt_top"},
	min_light = 10,
	chance = 300000,
	min_height = l_spawn_elevation_min,
	max_height = 5000,
	day_toggle = true,
})
mobs:register_egg("mobs_bear:medved", "Bear", "wool_brown.png", 1)
