minetest.register_entity("homefans:mesh_desk_fan", {
	collisionbox = homefans.nodebox.null,
	visual = "mesh",
	mesh = "desk_fan.b3d",
	textures = {"desk_fan.png"},
	visual_size = {x=10, y=10},
})

homefans.register("desk_fan", {
	description = "Desk Fan",
	legacy_facedir_simple = true,
	groups = {snappy=3, dig_immediate=2, attached_node=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875}, -- NodeBox1
		}
	},
	--[[
	recipe = {
		{"default:steel_ingot", "homedecor:fan_blades", "homedecor:motor"},
		{"", "default:steel_ingot", ""}
	},
	--]]
	recipe = {
		{"default:steel_ingot"	, ""								, "default:steel_ingot"},
		{""							, "default:mese_crystal"	, ""},
		{"default:steel_ingot"	, "default:steelblock"		, "default:steel_ingot"},
	},
	alias = {
		"desk_fan", "fan_desk", "deskfan", "fandesk", 
		"ventilador_de_mesa", "ventilador_torre", "ventiladordemesa", "ventiladortorre" 
	},
	tiles = {"desk_fan_body.png"},
	inventory_image = "desk_fan_inv.png",
	wield_image = "desk_fan_inv.png",
	walkable = false,
	selection_box = homefans.nodebox.desk_fan,
	on_construct = function(pos)
		local entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
		local meta = minetest.get_meta(pos)
		meta:set_string("active", "no")
		print (meta:get_string("active"))
		if entity_remove[1] == nil then
			minetest.add_entity({x=pos.x, y=pos.y, z=pos.z}, "homefans:mesh_desk_fan") --+(0.0625*10)
			entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
			if minetest.get_node(pos).param2 == 0 then --list of rad to 90 degree: 3.142/2 = 90; 3.142 = 180; 3*3.142 = 270
				entity_remove[1]:setyaw(3.142)
			elseif minetest.get_node(pos).param2 == 1 then
				entity_remove[1]:setyaw(3.142/2)
			elseif minetest.get_node(pos).param2 == 3 then
				entity_remove[1]:setyaw((-3.142/2))
			else
				entity_remove[1]:setyaw(0)
			end
		end
	end,
	on_punch = function(pos)
		local entity_anim = minetest.get_objects_inside_radius(pos, 0.1)
		local speedy_meta = minetest.get_meta(pos)
		if speedy_meta:get_string("active") == "no" then
			speedy_meta:set_string("active", "yes")
			print (speedy_meta:get_string("active"))
		elseif speedy_meta:get_string("active") == "yes" then
			speedy_meta:set_string("active", "no")
			print (speedy_meta:get_string("active"))
		end

		if entity_anim[1] == nil then
			minetest.add_entity({x=pos.x, y=pos.y, z=pos.z}, "homefans:mesh_desk_fan") --+(0.0625*10)
			local entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
			if minetest.get_node(pos).param2 == 0 then --list of rad to 90 degree: 3.142/2 = 90; 3.142 = 180; 3*3.142 = 270
				entity_remove[1]:setyaw(3.142)
			elseif minetest.get_node(pos).param2 == 1 then
				entity_remove[1]:setyaw(3.142/2)
			elseif minetest.get_node(pos).param2 == 3 then
				entity_remove[1]:setyaw((-3.142/2))
			else
				entity_remove[1]:setyaw(0)
			end
		end
		local entity_anim = minetest.get_objects_inside_radius(pos, 0.1)
		if minetest.get_meta(pos):get_string("active") == "no" then
			entity_anim[1]:set_animation({x=0,y=0}, 1, 0)
		elseif minetest.get_meta(pos):get_string("active") == "yes" then
			entity_anim[1]:set_animation({x=0,y=96}, 24, 0)
		end
	end,
	after_dig_node = function(pos)
		local entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
		entity_remove[1]:remove()
	end,
})
