
minetest.debug("[ds_rowboat] Mod loading")

--
-- Helper functions
--

local function is_water(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "water") ~= 0
end

local function get_velocity(v, yaw, y)
	local x = -math.sin(yaw)*v
	local z = math.cos(yaw)*v
	return {x=x, y=y, z=z}
end

--
-- ds_rowboat entity
--

local ds_rowboat = {
	physical = true,
	collisionbox = {-1,-0.5,-1, 1,0.5,1},
	visual = "mesh",
	mesh = "rowboat.x",
	textures = {"default_wood.png"},

	driver = nil,
	v = 0,
	stepcount = 0,
	unattended = 0
}

function ds_rowboat.on_rightclick(self, clicker)

	local name = clicker:get_player_name()
	
	minetest.debug("[ds_rowboat] "..name.." & "..dump(default.player_attached[name]))
	
	if clicker == self.driver then
		-- dismount the driver
		clicker:set_detach()
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand" , 30)
		self.driver = nil
	elseif not default.player_attached[name] then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=11,z=-3}, {x=0,y=0,z=0})
		default.player_attached[name] = true
		minetest.after(0.25, function()
			default.player_set_animation(clicker, "sit" , 30)
		end)
		self.object:setyaw(clicker:get_look_yaw()-math.pi/2)
	end
	
end

function ds_rowboat.on_activate(self, staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function ds_rowboat.get_staticdata()
	return tostring(v)
end

function ds_rowboat.on_punch(self, puncher, time_from_last_punch, tool_capabilities, direction)

	 -- if the ds_rowboat occupied?
	 if self.driver then
	 
		-- dismount the driver
		self.driver:set_detach()
		default.player_attached[self.driver:get_player_name()] = false
		default.player_set_animation(self.driver, "stand" , 30)
		self.driver = nil
		
	-- remove the ds_rowboat
	else

		ds_rowboat.schedule_removal(self)
		if not minetest.setting_getbool("creative_mode") then
			puncher:get_inventory():add_item("main", "ds_rowboat:ds_rowboat")
		end
	
	end
end

function ds_rowboat.on_step(self, dtime)

	self.stepcount=self.stepcount+1

	if self.stepcount>9 then
	
		self.stepcount=0
		
		if self.driver then

			self.unattended=0
		
			-- self.object:setyaw(self.driver:get_look_yaw()-math.pi/2)
		
			local kbd = self.driver:get_player_control()
			local yaw = self.object:getyaw()

			if kbd.up and self.v<3 then
				self.v = self.v + 1
			end
			
			if kbd.down and self.v>=-1 then
				self.v = self.v - 1
			end	
			
			if kbd.left then
				if kbd.down then
					self.object:setyaw(yaw-math.pi/12-dtime*math.pi/12)
				else
					self.object:setyaw(yaw+math.pi/12+dtime*math.pi/12)
				end
			end
			if kbd.right then
				if kbd.down then
					self.object:setyaw(yaw+math.pi/12+dtime*math.pi/12)
				else
					self.object:setyaw(yaw-math.pi/12-dtime*math.pi/12)
				end
			end
		else
			-- remove unattended ds_rowboats after 20 counts
			self.unattended=self.unattended+1
			if self.unattended>20 then
				ds_rowboat.schedule_removal(self)
			end
		end

		local tmp_velocity = get_velocity(self.v, self.object:getyaw(), 0)

		local tmp_pos = self.object:getpos()

		tmp_velocity.y=0

		if is_water(tmp_pos) then
			tmp_velocity.y=1
		end

		tmp_pos.y=tmp_pos.y-0.5

		if minetest.get_node(tmp_pos).name=="air" then
			tmp_velocity.y=-2
		end

		self.object:setvelocity(tmp_velocity)

	end
	
end

function ds_rowboat.schedule_removal(self)

	minetest.after(0.25,function()
		self.object:remove()
	end)

end


minetest.register_entity("ds_rowboat:ds_rowboat", ds_rowboat)

minetest.register_craftitem("ds_rowboat:ds_rowboat", {
	description = "Row Boat",
	inventory_image = "rowboat_inventory.png",
	wield_image = "rowboat_wield.png",
	wield_scale = {x=2, y=2, z=1},
	liquids_pointable = true,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		if not is_water(pointed_thing.under) then
			return
		end
		pointed_thing.under.y = pointed_thing.under.y+0.5
		minetest.add_entity(pointed_thing.under, "ds_rowboat:ds_rowboat")
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = "ds_rowboat:ds_rowboat",
	recipe = {
		{"", "", ""},
		{"", "", ""},
		{"boats:boat", "boats:boat", ""},
	},
})

minetest.debug("[ds_rowboat] Mod loaded")