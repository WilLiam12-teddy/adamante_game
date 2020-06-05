modUFO.ufo = {
	shipname="",
	waypoint_handler = nil,
	waypoint_position = nil;
	location_sign = "false",
	inertia_cancel = "true",
	enabled_ai = "false",
	soundHandles = {
		engine = nil,
		speaker = nil,
	},
	upgrades={
		trunk = "true",
		mailbox = "true",
		forge = "true",
		navegation = "false",
		artif_intel = "false",
	},
	forge = {
		inventory = nil,
		temperature = 0, --0 to 100%
		enabled = false,
		visibled = false,
		upgrade_formspec = 0,
		upgrade_temperature = 0,
		cook_time_count = 0,
		cook_time_end = 0,
	},
	physical = true,
	collisionbox = {-1.5,-0.5,-1.5	 ,1.5,1.0,1.5}, --top retracted to use sword as it flies.
	visual = "mesh",
	mesh = "ufo.x",
	textures = {"ufo.png^fuel_0.png"},
	
	driver = nil,
	owner_name = "",
	v = 0,
	fuel = 0,
	fueli = 0, -- ← Fuel Image
}


function modUFO.ufo:on_rightclick (clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	
	if self.upgrades.artif_intel~="true" then
		if clicker:get_wielded_item():get_name()=="ufos:artif_inteligency" then
			self.upgrades.artif_intel="true"
			self.enabled_ai="true"
			clicker:get_inventory():remove_item("main", ItemStack("ufos:artif_inteligency 1"))
			modUFO.send_message(self, clicker:get_player_name(), 
				modUFO.translate("I am alive! Thank you, '%s'!"):format(clicker:get_player_name())
			,"sfx_falha")
			return
		end
	end
	
	
	if self.driver and clicker == self.driver then
		local floorPos = self.object:getpos()
		floorPos.y = floorPos.y-1
		local nodename = minetest.env:get_node(floorPos).name
		--[[
		local vel = self.object:getvelocity()
		local velAverage = math.sqrt((vel.x^2)+(vel.y^2)+(vel.z^2))
		local ctrl = self.driver:get_player_control()
		--]]
		
		--[[
		minetest.register_on_player_receive_fields(function(sender, formname, fields)
			--self:on_player_receive_fields(sender, formname, fields)
			modUFO.on_player_receive_fields(self, sender, formname, fields)
		end)
		--]]

		minetest.show_formspec(
			clicker:get_player_name(),
			"frmUFO",
			modUFO.getFormSpecs.mainmenu(nodename=="air")
		)
	elseif not self.driver then
		if modUFO.check_owner(self,clicker) then
			self.driver = clicker
			clicker:set_attach(self.object, "", {x=0,y=7.5,z=0}, {x=0,y=0,z=0})
			if clicker:get_player_name() == self.owner_name then
				modUFO.send_message(self, clicker:get_player_name(), 
					modUFO.translate("Welcome to your ship, Captain %s!"):format(self.owner_name)
				,modUFO.translate("welcome_en"))
				--[[
				minetest.sound_play(
					modUFO.translate("welcome_en"), 
					{object = self.object, gain = 2.0, max_hear_distance = 5}
				)
				--]]
			end
			self.soundHandles.engine=minetest.sound_play(
				"sfx_ufo",
				{object = self.object, gain = 2.0, max_hear_distance = 5, loop = true,}
			)
		end
	end
end

function modUFO.ufo:on_activate (staticdata, dtime_s)
	if modUFO.next_owner ~= "" then
		self.owner_name = modUFO.next_owner
		modUFO.next_owner = ""
	else
		local tmpDatabase = minetest.deserialize(staticdata)
		--minetest.chat_send_all("chat_send_all: tmpDatabase="..dump(tmpDatabase))
		if tmpDatabase then
			self.shipname = tmpDatabase.shipname or modUFO.ufo.shipname
			self.owner_name = tmpDatabase.ownername or ""
			self.fuel = tonumber(tmpDatabase.fuel or 0)
			self.location_sign = tmpDatabase.location_sign or modUFO.ufo.location_sign
			self.inertia_cancel = tmpDatabase.inertia_cancel or modUFO.ufo.inertia_cancel
			self.upgrades.artif_intel = tmpDatabase.upgrades_artif_intel or modUFO.ufo.upgrades.artif_intel
			self.enabled_ai = tmpDatabase.enabled_ai or modUFO.ufo.enabled_ai
			
			if self.owner_name~="" then
				self.forge.inventory = modUFO.getForgeInventory(self, self.owner_name)
				self.forge.inventory:set_size("src", modUFO.forge.sizeSrc.width*modUFO.forge.sizeSrc.height)
				self.forge.inventory:set_size("dst", modUFO.forge.sizeDst.width*modUFO.forge.sizeDst.height)
			
				for i=1,self.forge.inventory:get_size("src") do
					if 
						tmpDatabase.forge 
						and tmpDatabase.forge.listSrc 
						and tmpDatabase.forge.listSrc[i] 
					then
						self.forge.inventory:set_stack("src", i, ItemStack(tmpDatabase.forge.listSrc[i]))
					else
						self.forge.inventory:set_stack("src", i, nil)
					end
				end
				for i=1,self.forge.inventory:get_size("dst") do
					if 
						tmpDatabase.forge 
						and tmpDatabase.forge.listDst 
						and tmpDatabase.forge.listDst[i] 
					then
						self.forge.inventory:set_stack("dst", i, ItemStack(tmpDatabase.forge.listDst[i]))
					else
						self.forge.inventory:set_stack("dst", i, nil)
					end
				end
			end
		end
	end
	if self.waypoint_handler and self.owner_name~="" then
		local owner = minetest.get_player_by_name(self.owner_name)
		if owner:is_player() then
			owner:hud_remove(self.waypoint_handler)
			self.waypoint_handler = nil
		end
	end
	minetest.register_on_player_receive_fields(function(sender, formname, fields)
		--self:on_player_receive_fields(sender, formname, fields)
		modUFO.on_player_receive_fields(self, sender, formname, fields)
	end)
	self.object:set_armor_groups({immortal=1})	
end

function modUFO.ufo:on_punch (puncher, time_from_last_punch, tool_capabilities, direction)
	if puncher and puncher:is_player() then
		if modUFO.check_owner(self,puncher) then
			if not self.driver then
				if self.soundHandles.engine~=nil then 
					minetest.sound_stop(self.soundHandles.engine) 
				end
				puncher:get_inventory():add_item("main", modUFO.ufo_to_item(self, puncher:get_player_name()))
				if self.waypoint_handler then
					puncher:hud_remove(self.waypoint_handler)
					self.waypoint_handler = nil
				end
				self.object:remove()
			else
				modUFO.send_message(self, puncher:get_player_name(), 
					modUFO.translate(
						"It is not possible to shrink this vehicle before the pilot '%s' comes out of it!"
					):format(self.owner_name)
				)
				modUFO.play_fail(self.object)
			end
		end
	end
end

function modUFO.ufo:on_step (dtime)
	local fuel = modUFO.get_fuel(self)
	if self.driver then
		self.driver:set_breath(11)
		local ctrl = self.driver:get_player_control()
		local vel = self.object:getvelocity()
		if fuel == nil then fuel = 0 end
		
		if fuel > 0 and ctrl.up then
			if ctrl.aux1 and self.inertia_cancel~="false" then
				self.inertia_cancel="false"
				modUFO.play_fail(self.driver)
				modUFO.send_message(self, self.driver:get_player_name(), 
					modUFO.translate("Disabled 'Inertia Cancel' of this UFO!")
				)
			elseif not ctrl.aux1 and self.inertia_cancel~="true" then
				self.inertia_cancel="true"
				modUFO.play_fail(self.driver)
				modUFO.send_message(self, self.driver:get_player_name(), 
					modUFO.translate("Enabled 'Inertia Cancel' of this UFO!")
				)
			end
			vel.x = vel.x + math.cos(self.object:getyaw()+math.pi/2)*modUFO.ship_acceleration
			vel.z = vel.z + math.sin(self.object:getyaw()+math.pi/2)*modUFO.ship_acceleration
			fuel = fuel - modUFO.ship_fuel_use
		elseif self.inertia_cancel=="true" or fuel <= 0 then
			if not ctrl.aux1 or fuel <= 0 then
				vel.x = vel.x*.99
				vel.z = vel.z*.99
			end
		else --Spend fuel constantly if you disable the 'Inertia Override'.
			fuel = fuel - (modUFO.ship_fuel_use / 2) -- Constant fuel expense will less in 50%.
		end
		if fuel > 0 and ctrl.left then
			if not ctrl.aux1 then
				self.object:setyaw(self.object:getyaw()+math.pi/120*modUFO.ship_turn_speed)
			else
				vel.x = vel.x + (math.cos(self.object:getyaw()-math.pi)*modUFO.ship_acceleration)
				vel.z = vel.z + (math.sin(self.object:getyaw()+math.pi)*modUFO.ship_acceleration)
				fuel = fuel - modUFO.ship_fuel_use
			end
		elseif fuel > 0 and ctrl.right then
			if not ctrl.aux1 then
				self.object:setyaw(self.object:getyaw()-math.pi/120*modUFO.ship_turn_speed)
			else
				vel.x = vel.x - (math.cos(self.object:getyaw()-math.pi)*modUFO.ship_acceleration)
				vel.z = vel.z - (math.sin(self.object:getyaw()+math.pi)*modUFO.ship_acceleration)
				fuel = fuel - modUFO.ship_fuel_use
			end
		end
		if ctrl.down then --The brake not waste fuel.
			vel.x = vel.x * modUFO.ship_brake
			vel.y = vel.y * modUFO.ship_brake
			vel.z = vel.z * modUFO.ship_brake
		end
		if fuel > 0 and ctrl.jump then
			vel.y = vel.y + modUFO.ship_acceleration
			fuel = fuel - modUFO.ship_fuel_use
		elseif ctrl.sneak then --landing does not waste fuel.
			vel.y = vel.y - modUFO.ship_acceleration
		else --No disable 'Inertia Override' to up or down the UFO.
			vel.y = vel.y * 0.9
		end
		
		if vel.x > modUFO.ship_max_speed then vel.x = modUFO.ship_max_speed end
		if vel.x < -modUFO.ship_max_speed then vel.x = -modUFO.ship_max_speed end
		if vel.y > modUFO.ship_max_speed then vel.y = modUFO.ship_max_speed end
		if vel.y < -modUFO.ship_max_speed then vel.y = -modUFO.ship_max_speed end
		if vel.z > modUFO.ship_max_speed then vel.z = modUFO.ship_max_speed end
		if vel.z < -modUFO.ship_max_speed then vel.z = -modUFO.ship_max_speed end
		self.object:setvelocity(vel)
		
		if ctrl.down and ctrl.aux1 then 
			--S Key + 'Run Key'(R or Ctrl) = Sound effect of 'five tones' of film 'close encounters of the third kind'.
			if self.soundHandles.engine~=nil then minetest.sound_stop(self.soundHandles.engine) end
			self.soundHandles.engine=minetest.sound_play(
				"sfx_five_tones",
				{object = self.object, gain = 2.0, max_hear_distance = 50}
			)
		end
		if ctrl.sneak and ctrl.aux1 then --emergency eject
			self.driver:set_detach()
			self.driver = nil
			if self.soundHandles.engine~=nil then 
				minetest.sound_stop(self.soundHandles.engine) 
			end
		end
		if ctrl.aux1 then --recharge fuel
			local pos = self.object:getpos()
			local t = {{x=2,z=0},{x=-2,z=0},{x=0,z=2},{x=0,z=-2}}
			for _, i in ipairs(t) do
				pos.x = pos.x + i.x; pos.z = pos.z + i.z;
				if minetest.env:get_node(pos).name == "ufos:furnace" then
					meta = minetest.env:get_meta(pos)
					if fuel < 100 and meta:get_int("charge") > 0 then
						fuel = fuel + 1
						meta:set_int("charge",meta:get_int("charge")-1)
						meta:set_string("formspec", 
							modUFO.getFormSpecs.furnace()
							--.. "label[0,0;Charge: "..meta:get_int("charge"))
							.. "label[1.95,0.6; "..modUFO.translate("Charge: %02d GWh (Gigawatts Hour)"):format(meta:get_int("charge")).. "]"
						)
					end
				end
				pos.x = pos.x - i.x; pos.z = pos.z - i.z;
			end
		end
		if self.waypoint_handler then
			self.driver:hud_remove(self.waypoint_handler)
			self.waypoint_handler = nil
		end
		if self.forge.visibled and self.forge.upgrade_formspec~=os.time() then
			modUFO.doButtonForge(self, self.driver)
		end
	else --if self.driver then
		local vel = self.object:getvelocity()
		vel.y = vel.y - 0.5
		self.object:setvelocity(vel)
		
		if self.owner_name~="" then
			local owner = minetest.get_player_by_name(self.owner_name)
			if owner and owner:is_player() then
				if self.location_sign=="true"	then
					if self.waypoint_position ~= self.object:getpos() then
						self.waypoint_position = self.object:getpos()
						if self.waypoint_handler then
							--owner:hud_remove(self.waypoint_handler)
							owner:hud_change(self.waypoint_handler, "name", self.shipname:upper())
							owner:hud_change(self.waypoint_handler, "world_pos", self.object:getpos())
						else
							self.waypoint_handler = owner:hud_add({
								hud_elem_type = "waypoint",
								name = self.shipname:upper(),
								--number = modbeacon2.huds.doRgb2hex(thisBeacon.color),
								number = "0x00FF00",  
								world_pos = self.object:getpos()
							})
							--modUFO.play_fail(owner)
							modUFO.send_message(self, self.owner_name, 
								modUFO.translate("Showing the location_signal of your UFO!")
								.." "
								..core.get_color_escape_sequence("#00FF00")
								..minetest.pos_to_string(modUFO.floor_pos(self.object:getpos()))
								..core.get_color_escape_sequence("#FFFFFF")
							,"sfx_falha")
						end
					end
				elseif self.waypoint_handler then
					owner:hud_remove(self.waypoint_handler)
					self.waypoint_handler = nil
				end
			end
		end
	end --if self.driver then
	
	if fuel < 0 then 
		fuel = 0 
		local vel = self.object:getvelocity()
		vel.y = vel.y - 0.5
		self.object:setvelocity(vel)
	elseif fuel > 100 then 
		fuel = 100 
	end
	
	if self.fueli ~= math.ceil(fuel*8/100) then
		self.fueli = math.ceil(fuel*8/100)
		--print(self.fueli)
		self.textures = {"ufo.png^fuel_"..self.fueli..".png"}
		self.object:set_properties(self)
	end

	modUFO.set_fuel(self,fuel)	
	
	modUFO.onForgeStep(self)	
	
	

end

function modUFO.ufo:get_staticdata()
	--[[if self.waypoint_handler and self.owner_name~="" then
		local owner = minetest.get_player_by_name(self.owner_name)
		if owner and owner:is_player() then
			owner:hud_remove(self.waypoint_handler)
			self.waypoint_handler = nil
		end
	end
	--]]
	
	local tmpDatabase = {
		shipname = self.shipname,
		ownername = self.owner_name,
		fuel = self.fuel,
		location_sign = self.location_sign,
		inertia_cancel = self.inertia_cancel,
		upgrades_artif_intel = self.upgrades.artif_intel,
		enabled_ai = self.enabled_ai,
		forge={
			listSrc = { },
			listDst = { },
		},
	}
	if self.forge.inventory then
		for i=1,self.forge.inventory:get_size("src") do
			tmpDatabase.forge.listSrc[i] = self.forge.inventory:get_stack("src", i):to_table()
		end
		for i=1,self.forge.inventory:get_size("dst") do
			tmpDatabase.forge.listDst[i] = self.forge.inventory:get_stack("dst", i):to_table()
		end
	end

	return minetest.serialize(tmpDatabase)
	--[[
	return 
		tostring(self.owner_name)
		..";"..tostring(self.fuel)
		..";"..tostring(self.shipname)
		..";"..tostring(self.location_sign)
		..";"..tostring(self.inertia_cancel)
	--]]
end

minetest.register_entity("ufos:ship", modUFO.ufo)


minetest.register_tool("ufos:ship", {
	description = modUFO.translate("ufo"):upper(),
	inventory_image = "ufos_inventory.png",
	wield_image = "ufos_inventory.png",
	tool_capabilities = {load=0,max_drop_level=0, groupcaps={fleshy={times={}, uses=100, maxlevel=0}}},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		if placer and not placer:get_player_control().sneak then -- Call on_rightclick if the pointed node defines it
			local n = minetest.get_node(pointed_thing.under)
			local nn = n.name
			if minetest.registered_nodes[nn] and minetest.registered_nodes[nn].on_rightclick then
				return minetest.registered_nodes[nn].on_rightclick(pointed_thing.under, n, placer, itemstack) or itemstack
			end
		end
		
		modUFO.ufo_from_item(itemstack,placer,pointed_thing)
		return itemstack
	end,
})

--[[
minetest.register_craft( {
	output = 'ufos:ship',
	recipe = {
		{ "", "default:glass", ""},
		{ "default:mese_crystal_fragment", "", "default:mese_crystal_fragment"},
		{ "default:steelblock", "default:mese", "default:steelblock"},
	},
})
--]]

--[[
-- ufos box kept for compatibility only
minetest.register_node("ufos:box", {
	description = "UFO BOX (you hacker you!)",
	tiles = {"ufos_box.png"},
	groups = {not_in_creative_inventory=1},
	on_rightclick = function(pos, node, clicker, itemstack)
		meta = minetest.env:get_meta(pos)
		if meta:get_string("owner") == clicker:get_player_name() then
			-- set owner
			modUFO.next_owner = meta:get_string("owner")
			-- restore the fuel inside the node
			modUFO.set_fuel(modUFO.ufo,meta:get_int("fuel"))
			-- add the entity
			e = minetest.env:add_entity(pos, "ufos:ship")
			-- remove the node
			minetest.env:remove_node(pos)
			-- reset owner for next ufo
			modUFO.next_owner = ""
		end
	end,
})
--]]

minetest.register_alias("ufo","ufos:ship")
minetest.register_alias(modUFO.translate("ufo"),"ufos:ship")
minetest.register_alias(modUFO.translate("ship"),"ufos:ship")
