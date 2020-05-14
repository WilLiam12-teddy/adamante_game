mobs:register_mob("mobs_doomed:owl", {
	type = "animal",
	passive = true,
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.3, -0.5, -0.3, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "owl.b3d",
	textures = {
		{"mobs_doomed_owl.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2, y=2},
	makes_footstep_sound = false,
	walk_velocity = 0,
	run_velocity = 0,
	jump = false,
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	view_range = 1,
	do_custom = function(self)
		local daytime = minetest.get_timeofday()*24000
		if daytime <=6000 then
		self.object:set_properties({
							textures = {"mobs_doomed_owl_awake.png"},
							mesh = "owl.b3d",
						})
		elseif daytime >=6000 then
		self.object:set_properties({
							textures = {"mobs_doomed_owl.png"},
							mesh = "owl.b3d",
						})
		end
	end,
	animation = {
		speed_normal = 1,
		walk_start = 1,
		walk_end = 50,
	},
	drops = {
		{name="mobs:meat_raw", chance=1, min=0, max=2},
		{name="mobs:chicken_feather", chance=1, min=0, max=2}
	},
})

mobs:register_egg("mobs_doomed:owl", "Owl", "default_tree.png", 1)

mobs:spawn_specific("mobs_doomed:owl",
					{"group:leaves"},
					{"air"},
                    0, 14, 30, 300000, 2, 0, 5000, false)
