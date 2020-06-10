modHomeChair={}

modHomeChair.getBoxColision=function()
	return {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, 0.1875, -0.1875, 0.5, 0.3125},
			{0.1875, -0.5, 0.1875, 0.3125, 0.5, 0.3125},
			{-0.3125, -0.5, -0.3125, -0.1875, 0, -0.1875},
			{0.1875, -0.5, -0.3125, 0.3125, 0, -0.1875},
			{-0.3125, -0.125, -0.3125, 0.3125, 0, 0.3125},
			{-0.25, 0.0625, 0.25, 0.25, 0.4375, 0.25},
		},
	}
end

modHomeChair.getTilesetInColor=function(color)
	if type(color)=="string" and color~="" and color~="wood" then
		return {
				"chair_top_"..color..".png",
				"chair_wood.png",
				"chair_sides_"..color..".png",
				"chair_sides_"..color..".png^[transformFX",
				"chair_back_"..color..".png",
				"chair_front_"..color..".png",
		}
	else
		return { "chair_wood.png" }
	end
end

modHomeChair.canInteract = function(pos, playername)
	if pos and pos.x  and pos.y  and pos.z then
		local meta = minetest.get_meta(pos)
		if playername == meta:get_string("owner") 
			or minetest.get_player_privs(playername).server
			or (minetest.get_modpath("tradelands") and modTradeLands.canInteract(pos, playername))
		then
			return true
		end
	end
	return false
end

modHomeChair.doSit = function (pos, node, clicker) -- don't move these functions inside sit()
	modHomeChair.goPosSit = function(pos, node, clicker)
		local name = clicker:get_player_name()
		local meta = minetest:get_meta(pos)
		local param2 = node.param2
		if clicker:get_player_name() == meta:get_string("player") then
			meta:set_string("player", "")
			pos.y = pos.y-0.5
			clicker:setpos(pos)
			clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
			clicker:set_physics_override(1, 1, 1)
			default.player_attached[name] = false
			default.player_set_animation(clicker, "stand", 30)
		else
			meta:set_string("player", clicker:get_player_name())
			clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
			clicker:set_physics_override(0, 0, 0)
			default.player_attached[name] = true
			if param2 == 1 then
				clicker:set_look_yaw(7.9)
			elseif param2 == 3 then
				clicker:set_look_yaw(4.75)
			elseif param2 == 0 then
				clicker:set_look_yaw(3.15)
			else
				clicker:set_look_yaw(6.28)
			end
		end
	end
	if not clicker or not clicker:is_player()
		or clicker:get_player_control().up == true or clicker:get_player_control().down == true
		or clicker:get_player_control().left == true or clicker:get_player_control().right == true
		or clicker:get_player_control().jump == true then  -- make sure that the player is immobile.
	return end
	modHomeChair.goPosSit(pos, node, clicker)
	clicker:setpos(pos)
	default.player_set_animation(clicker, "sit", 30)
end

modHomeChair.register_chair = function(color, description, summonercolors)
	if type(color)~="string" or color=="" then color="wood" end
	
	minetest.register_node("homechair:chair_"..color, {
		description = description,
		--inventory_image = "safe_front.png",
		paramtype = "light",
		paramtype2 = "facedir",
		drawtype = "nodebox",
		tiles = modHomeChair.getTilesetInColor(color),
		node_box = modHomeChair.getBoxColision(),
		selection_box = modHomeChair.getBoxColision(),
		groups = {snappy=3},
		after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name() or "")
			meta:set_string("infotext", description.." (de "..meta:get_string("owner")..")")
		end,
		can_dig = function(pos,player)
			return modHomeChair.canInteract(pos, player:get_player_name())
		end,
		on_rightclick = function(pos, node, clicker)
			pos.y = pos.y-0 -- player's sit position.
			modHomeChair.doSit(pos, node, clicker)
		end,
	})
	
	if color=="wood" then
		minetest.register_craft({
			output = "homechair:chair_wood",
			recipe = {
				{ ""					,"default:stick"},
				{ "default:wood"	,"default:wood" },
				{ "default:stick"	,"default:stick" },
			},
		})
		
		minetest.register_craft({
			output = "homechair:chair_wood",
			recipe = {
				{ "group:stick"	,""},
				{ "group:wood"		,"group:wood" },
				{ "group:stick"	,"group:stick" },
			},
		})
		
		minetest.register_craft({
			output = "homechair:chair_wood",
			recipe = {
				{ ""					,"group:stick"},
				{ "group:wood"		,"group:wood" },
				{ "group:stick"	,"group:stick" },
			},
		})
		
		minetest.register_alias("chair"					,"homechair:chair_wood")
		minetest.register_alias("chairwood"				,"homechair:chair_wood")
		minetest.register_alias("cadeira"				,"homechair:chair_wood")
		minetest.register_alias("cadeirademadeira"	,"homechair:chair_wood")
	else
		minetest.register_craft({
			type = "shapeless",
			output = "homechair:chair_"..color,
			recipe = {
				"homechair:chair_wood",
				"wool:white",
				"dye:"..color
			},
		})
		
		minetest.register_craft({
			type = "shapeless",
			output = "homechair:chair_"..color,
			recipe = {
				"homechair:chair_wood",
				"group:wool",
				"dye:"..color
			},
		})
		
		minetest.register_craft({
			type = "shapeless",
			output = "homechair:chair_"..color,
			recipe = {
				"homechair:chair_wood",
				"wool:"..color
			},
		})

		minetest.register_alias("chair"..color					,"homechair:chair_"..color)
		for i, scor in ipairs(summonercolors) do
			minetest.register_alias("cadeira"..scor	,"homechair:chair_"..color)
		end
	end
	
	minetest.register_craft({
		type = "fuel",
		recipe = "homechair:chair_"..color,
		burntime = 15,
	})
end


