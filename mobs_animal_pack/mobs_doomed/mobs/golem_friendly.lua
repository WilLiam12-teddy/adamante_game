minetest.register_node("mobs_doomed:golemstone", {
	description = "golem stone",
	tiles = {"mobs_doomed_golem_stone.png",},
	groups = {cracky=1},
	on_construct = function(pos, node, _)
		local node1 = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local node2 = minetest.get_node({x=pos.x, y=pos.y-2, z=pos.z}).name
		local node3 = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		if node1 == "default:stone" and node2 == "default:stone" and node3 == "air" then
		minetest.add_entity(pos, "mobs_doomed:golem_friendly")
		minetest.remove_node({x=pos.x, y=pos.y-1, z=pos.z})
		minetest.remove_node({x=pos.x, y=pos.y-2, z=pos.z})
		minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
		end
	end,
})

mobs:register_mob("mobs_doomed:golem_friendly", {
	type = "npc",
	reach = 3,
	damage = 2,
	attack_type = "dogfight",
	attacks_monsters = true,
	hp_min = 62,
	hp_max = 72,
	armor = 100,
	collisionbox = {-0.4, 0, -0.4, 0.4, 2.5, 0.4},
	visual = "mesh",
	mesh = "golem.b3d",
	textures = {
		{"mobs_doomed_golem.png"},
	},
	follow = "default:cobble",
	blood_texture = "default_stone.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2.5,
	jump = true,
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 0,
	fear_height = 10,
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 14,
		walk_start = 46,
		walk_end = 66,
		stand_start = 1,
		stand_end = 20,
		run_start = 46,
		run_end = 66,
		punch_start = 20,
		punch_end = 45,
	},
})

mobs:register_egg("mobs_doomed:golem_friendly", "Stone Golem (friendly)", "default_stone.png", 1)
