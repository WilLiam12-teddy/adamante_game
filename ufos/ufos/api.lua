minetest.register_privilege(
	"parkingman",  {
		description=modUFO.translate("Control the UFOs of other players."), 
		give_to_singleplayer=false,
	}
)

modUFO.floor_pos = function(pos)
	return {
		x=math.floor(pos.x),
		y=math.floor(pos.y),
		z=math.floor(pos.z)
	}
end

modUFO.play_fail = function(object)
	minetest.sound_play(
		"sfx_falha", 
		{object = object, gain = 0.3, max_hear_distance = 1}
	)
end

modUFO.send_message = function(self, playername, message, sound)
	if self.upgrades.artif_intel~="false" and self.enabled_ai=="true" then
		--core.colorize(color, message)
		--core.get_background_escape_sequence("#00ff00")
		--core.get_color_escape_sequence("#ff0000")
		if self and self.shipname~="" then
			message=core.get_background_escape_sequence("#FFFFFF")..
			core.colorize("#00FF00", "["..self.shipname:upper().."]").." "..message
		else
			message=core.get_background_escape_sequence("#FFFFFF")..
			core.colorize("#00FF00", "["..modUFO.translate("ufo"):upper().."]").." "..message
		end
		minetest.chat_send_player(playername, message)
		if sound and type(sound)=="string" and sound~="" then
			local player = minetest.get_player_by_name(playername)
			if player and player:is_player() then
				if self.soundHandles.speaker~=nil then 
					minetest.sound_stop(self.soundHandles.speaker)
				end
				self.soundHandles.speaker=minetest.sound_play(
					sound, {
						player = player, 
						gain = 1.0, 
						max_hear_distance = 1
					}
				)
			end
		end
	end
end

modUFO.addDrops = function(drop_id, drop_rarity, to_node)
	--FONTE: https://dev.minetest.net/minetest.register_node#More_on_drop
	local newDropList = {}
	local props = minetest.registered_items[to_node]
	if props.drop then 
		newDropList=props.drop.items 
		table.insert(newDropList, {items = {drop_id},rarity = drop_rarity})
		minetest.override_item(
			to_node, {
				drop = {
					max_items=#newDropList,
					items=newDropList
				}
			}
		)
	else
		--[[ --]]
		newDropList={
			max_items=2, 
			items={
				{items = {drop_id},rarity = drop_rarity}
			}
		}
		minetest.override_item(
			to_node, {
				drop = newDropList
			}
		)
		--[[ --]]
	end
end

modUFO.getItemImage = function (objFuel)
	local props = minetest.registered_items[objFuel]
	if props == nil or props.inventory_image == nil then 
		return "" 
	end
	return props.inventory_image
end

modUFO.getItemName = function(objFuel)
	local props = minetest.registered_items[objFuel]
	if props == nil or props.description == nil then 
		return "???????" 
	end
	return props.description
end

modUFO.getFomTheme = function()
	return "bgcolor[#636D76FF;false]"
		..default.gui_bg_img
		..default.gui_slots
	--..default.gui_bg
end

modUFO.doFiveTones = function(self, player)
	--S Key + 'Run Key'(R or Ctrl) = Sound effect of 'five tones' of film 'close encounters of the third kind'.
	if self.soundHandles.engine~=nil then minetest.sound_stop(self.soundHandles.engine) end
	self.soundHandles.engine = minetest.sound_play(
		"sfx_five_tones",	{
			object = player
			,gain = 2.0
			,max_hear_distance = 5 --super near only to not boring other players.
		}
	)
end

modUFO.doButtonFail = function(self, playername, modname)
	modUFO.send_message(
		self, playername, 
		modUFO.translate("This function only work if admin install mod '%s'!"):
		format(
			core.get_color_escape_sequence("#00FF00")
			..modname
			..core.get_color_escape_sequence("#FFFFFF")
			)
	)
	modUFO.play_fail(self.object)
end

modUFO.onForgeStep = function(self)
	if self.forge.upgrade_temperature~=os.time() then
		self.forge.upgrade_temperature=os.time()
		if self.forge.enabled and modUFO.get_fuel(self) > 0 then
			if self.forge.inventory then
				local srcList = self.forge.inventory:get_list("src")
				local dstList = self.forge.inventory:get_list("dst")
				local endPoint = (modUFO.forge.sizeSrc.width * modUFO.forge.sizeSrc.height)
				--modUFO.send_message(self, self.owner_name, "endPoint="..endPoint)
				if not self.forge.inventory:is_empty("src") and srcList[endPoint]:is_empty() then
					while srcList[endPoint]:is_empty() do
						for i=endPoint, 1, -1 do
							--modUFO.send_message(self, self.owner_name, "srcList["..i.."]:get_name()="..srcList[i]:get_name())
							if i < endPoint and not srcList[i]:is_empty() then
								self.forge.inventory:set_stack(
									"src", i+1, 
									self.forge.inventory:get_stack("src", i)
								)
								self.forge.inventory:set_stack("src", i, {})
							end
						end
						srcList = self.forge.inventory:get_list("src")
					end
				end

				local cooked, aftercooked = minetest.get_craft_result({
					method="cooking", width=1,  items={ srcList[endPoint] }
				})
				local cookable = cooked.time ~= 0
				if cookable then
					if not srcList[endPoint]:is_empty() then
						self.forge.cook_time_end = cooked.time
						self.forge.cook_time_count = self.forge.cook_time_count + (1 * self.forge.temperature/100)
						if self.forge.cook_time_count >= cooked.time then
							if self.forge.inventory:room_for_item("dst", cooked.item) then
								self.forge.cook_time_count = 0
								self.forge.inventory:add_item("dst", cooked.item)
								self.forge.inventory:set_stack("src", endPoint, aftercooked.items[1])
							else
								self.forge.enabled = false
								self.forge.cook_time_count = 0
								if self.owner_name~="" then
									local owner = minetest.get_player_by_name(self.owner_name)
									if owner and owner:is_player() then
										modUFO.send_message(
											self,
											self.owner_name, 
											modUFO.translate("The forge was turned off for lack of space for cooked items.")
										)
										modUFO.play_fail(self.object)
									end
								end
							end
						end
					end
				else
					self.forge.enabled = false
					self.forge.cook_time_count = 0
					if self.owner_name~="" then
						local owner = minetest.get_player_by_name(self.owner_name)
						if owner and owner:is_player() then
							modUFO.send_message(
								self,
								self.owner_name, 
								modUFO.translate("The forge was turned off for lack of cookable items.")
							)
							modUFO.play_fail(self.object)
						end
					end
				end
			end --if self.forge.inventory then
			if self.forge.enabled == true then
				if self.forge.temperature < 100 then
					self.forge.temperature = self.forge.temperature + 10
					if self.forge.temperature > 100 then self.forge.temperature = 100 end
				end
				modUFO.set_fuel(self, modUFO.get_fuel(self) - modUFO.forge.fuel_use)
			end
		elseif 
			(not self.forge.enabled or modUFO.get_fuel(self) <= 0) 
			and self.forge.temperature > 0 
		then
			self.forge.temperature = self.forge.temperature - 5
			if self.forge.temperature < 0 then 
				self.forge.temperature = 0 
			end			
			if self.forge.enabled then
				self.forge.cook_time_count = 0
				self.forge.enabled = false
				if self.owner_name~="" then
					local owner = minetest.get_player_by_name(self.owner_name)
					if owner and owner:is_player() then
						modUFO.send_message(
							self,
							self.owner_name, 
							modUFO.translate("The forge was turned off for empty fuel.")
						)
						modUFO.play_fail(self.object)
					end
				end
			end

		end
	end
end

modUFO.getForgeInventory = function(self, playername)
	return minetest.create_detached_inventory("frmForge", {
		-- Called when a player wants to move items inside the inventory
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player) 
			local stack = inv:get_stack(from_list, from_index)
			if to_list == "src" then
				return stack:get_count()
			elseif to_list == "dst" then
				return 0
			end
		end,
		-- Called when a player wants to put items into the inventory
		allow_put = function(inv, listname, index, stack, player) 
			if listname == "src" then
				return stack:get_count()
			elseif listname == "dst" then
				return 0
			end
		end,
		-- Called when a player wants to take items out of the inventory
		allow_take = function(inv, listname, index, stack, player) 
			return stack:get_count()
		end,
		-- on_* - no return value
		-- Called after the actual action has happened, according to what was allowed.
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player) 
		end,
		on_put = function(inv, listname, index, stack, player) 
			--modUFO.setSafeInventory(player:get_player_name(), inv:get_list("safe"))
			minetest.log('action',
				modUFO.translate("The Captain '%s' has placed %02d '%s' in UFO Eletric Forge!"):
				format(playername, stack:get_count(), stack:get_name())
			)
		end,
		on_take = function(inv, listname, index, stack, player) 
			--modUFO.setSafeInventory(player:get_player_name(), inv:get_list("safe"))
			minetest.log('action',
				modUFO.translate("The Captain '%s' has removed %02d '%s' in UFO Eletric Forge!"):
				format(playername, stack:get_count(), stack:get_name())
			)
		end,
	})
end

modUFO.doButtonForge = function(self, driver)
	self.forge.upgrade_formspec=os.time()
	local drivername = driver:get_player_name()
	if self.forge.inventory == nil then
		--modUFO.send_message(self, drivername, "modUFO.get_fuel(self)"..modUFO.get_fuel(self))
		self.forge.inventory = modUFO.getForgeInventory(self, drivername)
		self.forge.inventory:set_size("src", modUFO.forge.sizeSrc.width*modUFO.forge.sizeSrc.height)
		self.forge.inventory:set_size("dst", modUFO.forge.sizeDst.width*modUFO.forge.sizeDst.height)
	end
	--[[
	if self.forge.enabled and modUFO.get_fuel(self) > 0 and self.forge.temperature < 100 then
		self.forge.temperature = self.forge.temperature + 20
	elseif (not self.forge.enabled or modUFO.get_fuel(self) <= 0) and self.forge.temperature > 0 then
		self.forge.temperature = self.forge.temperature - 20
	end
	--]]
	local end_item = 0
	if self.forge.cook_time_end > 0 then
		end_item = math.floor(self.forge.cook_time_count / self.forge.cook_time_end * 100)
	end
	minetest.show_formspec(
		drivername,
		"frmForge",
		--modUFO.getFormSpecs.forge(self, driver, fuel_percent, item_percent)
		modUFO.getFormSpecs.forge(
			self, driver, 
			self.forge.temperature, 
			end_item
		)
	)
end

modUFO.doButtonLeave = function(self, driver)
	local drivername = driver:get_player_name()
	local vel = self.object:getvelocity()
	if vel~=nil and vel.x and vel.y and vel.z then --Avoid BUG
		local velAverage = math.sqrt((vel.x^2)+(vel.y^2)+(vel.z^2))
		if velAverage<=0.01 then -- 0.01 m/s = (1cm/s) = 0.01 blocks per second
			local floorPos = self.object:getpos()
			floorPos.y = floorPos.y-1
			local nodename = minetest.env:get_node(floorPos).name
			--modUFO.send_message(self, drivername, "nodename="..nodename)
			if nodename == "air" then
				minetest.show_formspec(
					drivername,
					"frmUFO",
					modUFO.getFormSpecs.confirm_eject
				)				
			else
				driver:set_detach()
				self.driver = nil
				if self.soundHandles.engine~=nil then 
					minetest.sound_stop(self.soundHandles.engine) 
				end
			end
		else
			modUFO.send_message(
				self,
				drivername, 
				modUFO.translate("You have to brake that UFO before you leave!")..
				core.get_color_escape_sequence("#FFFFFF").." ("..
				core.get_color_escape_sequence("#FF0000")..
				string.format("%.3f", velAverage).." m/s"..
				core.get_color_escape_sequence("#FFFFFF")..")"
			)
			modUFO.play_fail(self.object)
		end
	end --FINAL OF if vel~=nil then
end

modUFO.getFormSpecs = {
	mainmenu = function(insecure)
		local myFormSpec =
		"size[8,5.80]"
		..modUFO.getFomTheme()
		.."label[0,0;"..minetest.formspec_escape(core.get_color_escape_sequence("#00FF00")..modUFO.translate("UFO SYSTEM CONTROL")..":").."]"
		.."button[0,0.50;4,1;btnControlHelp;"..minetest.formspec_escape(modUFO.translate("UFO MANUAL")).."]"
		.."button[4,0.50;4,1;btnShowFiveTones;"..minetest.formspec_escape(modUFO.translate("FIVE TONES")).."]"
		.."button[0,1.35;4,1;btnShowMailBox;"..minetest.formspec_escape(modUFO.translate("MAILBOX")).."]"
		.."button[4,1.35;4,1;btnShowTrunk;"..minetest.formspec_escape(modUFO.translate("CARRIER TRUNK")).."]"
		.."button[0,2.15;4,1;btnShowSettings;"..minetest.formspec_escape(modUFO.translate("UFO SETTINGS")).."]"
		.."button[4,2.15;4,1;btnShowForge;"..minetest.formspec_escape(modUFO.translate("ELETRIC FORGE")).."]"
		.."button[0,3.00;4,1;btnShowNavegation;"..minetest.formspec_escape(modUFO.translate("NAVEGATION")).."]"
		.."button[4,3.00;4,1;btnShowUpgrade;"..minetest.formspec_escape(modUFO.translate("UPGRADES")).."]"
		.."button[0,3.85;4,1;btnShowTeleport;"..minetest.formspec_escape(modUFO.translate("TELEPORT")).."]"
		.."button[4,3.85;4,1;btnShowAbduct;"..minetest.formspec_escape(modUFO.translate("ABDUCT")).."]"
				
		if insecure then
			myFormSpec = myFormSpec.."button[1,5.05;6,1;btnLeave;"..minetest.formspec_escape(modUFO.translate("EMERGENCY EJECTION")).."]"
		else
			myFormSpec = myFormSpec.."button_exit[1,5.05;6,1;btnLeave;"..minetest.formspec_escape(modUFO.translate("LEAVE UFO")).."]"
		end
		
		return myFormSpec
	end,
	upgrades = function(self, driver)
		--http://dev.minetest.net/texture
		local altura = 0
		local image = ""
		local color_on = "#FFFFFF"
		local color_off = "#886666"
		local formspec = "size[5,3.5]"
			..modUFO.getFomTheme()
			.."label[0,0;"..minetest.formspec_escape(core.get_color_escape_sequence("#00FF00")..modUFO.translate("UPGRADES")..":").."]"
			
			--altura = 5.00
			--formspec=formspec.."list[current_player;main;0,"..altura.."; 8,1;]"
			--formspec=formspec..default.get_hotbar_bg(0, altura)
			--formspec=formspec.."list[current_player;main;0,"..(altura+1.25).."; 8,3;8]"
			
			dimensions="0.75,0.75"

			if minetest.get_modpath("minertrade") then
				altura = 0.75
				formspec=formspec.."image[0,"..altura..";"..dimensions..";([inventorycube{safe_side.png{safe_front.png{safe_side.png)"
				if self.upgrades.trunk ~= "true" then
					formspec=formspec.."^[brighten:0^[colorize:black:160"
				end
				formspec=formspec.."]"
				formspec=formspec.."label[0.75,"..(altura+0.15)..";"
				if self.upgrades.trunk == "true" then
					formspec=formspec..core.get_color_escape_sequence(color_on)
				else
					formspec=formspec..core.get_color_escape_sequence(color_off)
				end
				formspec=formspec..minetest.formspec_escape(modUFO.translate("CARRIER TRUNK")).."]"
			end
			if minetest.get_modpath("correio") then
				altura = 1.5
				formspec=formspec.."image[0,"..altura..";"..dimensions..";obj_mailbox.png"
				if self.upgrades.mailbox ~= "true" then
					formspec=formspec.."^[brighten:0^[colorize:black:160"
				end
				formspec=formspec.."]"
				formspec=formspec.."label[0.75,"..(altura+0.15)..";"
				if self.upgrades.mailbox == "true" then
					formspec=formspec..core.get_color_escape_sequence(color_on)
				else
					formspec=formspec..core.get_color_escape_sequence(color_off)
				end
				formspec=formspec..minetest.formspec_escape(modUFO.translate("MAILBOX")).."]"
			end

			altura = 2.25
			image = "([inventorycube{default_furnace_top.png{default_furnace_front.png{default_furnace_side.png)"
			formspec=formspec.."image[0,"..altura..";"..dimensions..";"..image
			if self.upgrades.forge ~= "true" then
				formspec=formspec.."^[brighten:0^[colorize:black:160"
			end
			formspec=formspec.."]"
			formspec=formspec.."label[0.75,"..(altura+0.15)..";"
			if self.upgrades.forge == "true" then
				formspec=formspec..core.get_color_escape_sequence(color_on)
			else
				formspec=formspec..core.get_color_escape_sequence(color_off)
			end
			formspec=formspec..minetest.formspec_escape(modUFO.translate("ELETRIC FORGE")).."]"

			--[[
			altura = 2.25
			--formspec=formspec.."list[detached:frmUpgrades;forge;0,"..altura..";"..dimensions..";]"
			formspec=formspec.."image[0,"..altura..";"..dimensions..";([inventorycube{default_furnace_top.png{default_furnace_front.png{default_furnace_side.png)]"
			formspec=formspec.."label[0.75,"..(altura+0.15)..";"
			..core.get_color_escape_sequence("#FFFFFF")
			..minetest.formspec_escape(modUFO.translate("ELETRIC FORGE")).."]"
			--]]
			
			altura = 3.0
			image = "navegation2_64.png"
			formspec=formspec.."image[0,"..altura..";"..dimensions..";"..image
			if self.upgrades.navegation ~= "true" then
				formspec=formspec.."^[brighten:0^[colorize:black:160"
			end
			formspec=formspec.."]"
			formspec=formspec.."label[0.75,"..(altura+0.15)..";"
			if self.upgrades.navegation == "true" then
				formspec=formspec..core.get_color_escape_sequence(color_on)
			else
				formspec=formspec..core.get_color_escape_sequence(color_off)
			end
			formspec=formspec..minetest.formspec_escape(modUFO.translate("NAVEGATION")).."]"

			
			--[[
			altura = 3.0
			--formspec=formspec.."list[detached:frmUpgrades;navegation;0,"..altura..";"..dimensions..";]"
			formspec=formspec.."image[0,"..altura..";"..dimensions..";navegation2_64.png^[brighten:0^[colorize:black:160]"
			formspec=formspec.."label[0.75,"..(altura+0.15)..";"
			..core.get_color_escape_sequence("#666666")
			..minetest.formspec_escape(modUFO.translate("NAVEGATION")).."]"
			--]]
		return formspec
	end,
	controlhelp = "size[8.5,6.50]"
		..modUFO.getFomTheme()
		.."label[0,0.00;"..minetest.formspec_escape(core.get_color_escape_sequence("#00FF00")..modUFO.translate("UFO MANUAL - CONTROLS")..":").."]"
		.."label[0,0.75;"..minetest.formspec_escape(modUFO.translate("Key W (UP) ← Accelerator")).."]"
		.."label[0,1.25;"..minetest.formspec_escape(modUFO.translate("Key S (DOWN) ← Brake")).."]"
		.."label[0,1.75;"..minetest.formspec_escape(modUFO.translate("Key A (LEFT) ← Turn Lett")).."]"
		.."label[0,2.25;"..minetest.formspec_escape(modUFO.translate("Key D (RIGHT) ← Turn Right")).."]"
		.."label[0,2.75;"..minetest.formspec_escape(modUFO.translate("Key Spacebar (JUMP) ← To lift")).."]"
		.."label[0,3.25;"..minetest.formspec_escape(modUFO.translate("Key Shift (SNAKE) ← To down")).."]"
		.."label[0,4.00;"..minetest.formspec_escape(modUFO.translate("Key S (Brake) + Run Key (R or Ctrl) ← Five Tones")).."]"
		.."label[0,4.50;"..minetest.formspec_escape(modUFO.translate("Key Shift (SNAKE) + Run Key (R or Ctrl) ← Emergency Ejection")).."]"
		.."label[0,5.00;"..minetest.formspec_escape(modUFO.translate("Key Sides (A or D) + Key Run (R or Ctrl) ← Walks to the side")).."]"

		.."button[2.25,5.75; 4.00,1"..";btnMainMenu;"..minetest.formspec_escape(modUFO.translate("MENU BACK")).."]"
		.."button[6.25,5.75; 2.00,1"..";btnControlHelp2;"..minetest.formspec_escape(modUFO.translate("NEXT")).."]"
		.."",
	controlhelp2 = "size[8.5,6.50]"
		..modUFO.getFomTheme()
		.."label[0,0.00;"..minetest.formspec_escape(core.get_color_escape_sequence("#00FF00")..modUFO.translate("UFO MANUAL - MAINTENANCE")..":").."]"
		.."label[0,0.75;"..minetest.formspec_escape(modUFO.translate(
			"Do not forget your UFO in the garage. Your UFO can be deleted \nfrom the server when admin applies maintenance procedures on \nthe server. Save your UFO as an item."
		)).."]"

		.."button[0.25,5.75; 2.00,1"..";btnControlHelp;"..minetest.formspec_escape(modUFO.translate("PREVIOUS")).."]"
		.."button[2.25,5.75; 4.00,1"..";btnMainMenu;"..minetest.formspec_escape(modUFO.translate("MENU BACK")).."]"
		.."",
	confirm_eject = 
		"size[8,3.25]"
		..modUFO.getFomTheme()
		.."label[1.5,0;"..
			minetest.formspec_escape(
				core.get_color_escape_sequence("#00FF00").."--== "..modUFO.translate("EMERGENCY EJECTION").." ==--"
			).."]"
		.."label[0,1.0;"..minetest.formspec_escape(
			modUFO.translate(
				"The UFO recommends that you land on a flat ground."
			)
		).."]"
		.."label[0,1.5;"..minetest.formspec_escape(
			modUFO.translate(
				"Do you really want to leave the UFO on this ground?"
			)
		).."]"
		.."button_exit[2,2.5;2,1;btnEjectOk;"..minetest.formspec_escape(modUFO.translate("YES")).."]"
		.."button[4,2.5;2,1;btnEjectCancel;"..minetest.formspec_escape(modUFO.translate("NOT")).."]"
		.."",
	settings = function(self)
		local myFormSpec ="size[8,5.25]"
		..modUFO.getFomTheme()
		.."label[0,0;"..minetest.formspec_escape(core.get_color_escape_sequence("#00FF00")..modUFO.translate("UFO SETTINGS")..":").."]"
		--field[X,Y;W,H;name;label;default]
		.."field[0.25,1.5;7.75,1;txtShipName;"
			..minetest.formspec_escape(modUFO.translate("Ship Name")..":")
			..";"..minetest.formspec_escape(self.shipname)
		.."]"
		--checkbox[X,Y;name;label;selected]
		.."checkbox[0,2.0;chkLocationSign;"
			..minetest.formspec_escape(modUFO.translate("Location Sign"))..";"
			..self.location_sign
		.."]"
		.."checkbox[0,2.75;chkInertiaCancel;"
			..minetest.formspec_escape(
				modUFO.translate("Inertia Cancel.").." ( "..core.colorize("#FFFF00", modUFO.translate("Spend fuel constantly if off")).." )"
			)..";"
			..self.inertia_cancel
		.."]"
		
		if self.upgrades.artif_intel~="false" then
			myFormSpec = myFormSpec..
			"checkbox[0,3.50;chkArtifIntel;"..minetest.formspec_escape(modUFO.translate("Artificial Inteligency"))..";"..self.enabled_ai.."]"
		end

		myFormSpec = myFormSpec.."button[3.0,4.50;2,1;btnSaveSettings;"..minetest.formspec_escape(modUFO.translate("OK")).."]"
		
		return myFormSpec
	end,
	forge = function(self, driver, temperature_perc, item_percent)
		local formspec = "size[8,9.0]"
			..modUFO.getFomTheme()
			.."label[0,0;"..minetest.formspec_escape(core.get_color_escape_sequence("#00FF00")..modUFO.translate("ELETRIC FORGE")..":").."]"
			.."list[detached:frmForge;src;0.75,1.0;"..modUFO.forge.sizeSrc.width..","..modUFO.forge.sizeSrc.height..";]"
			.."image[2.75,2.0;1,1;default_furnace_fire_bg.png^[lowpart:"..(temperature_perc)..":default_furnace_fire_fg.png]"
			.."image[3.75,2.0;1,1;gui_forge_arrow_bg.png^[lowpart:"..(item_percent)..":gui_forge_arrow_fg.png^[transformR270]"			
			if self.forge.enabled then
				formspec=formspec.."button[0.75,3.10;3,1;btnForgeOff;"..minetest.formspec_escape(modUFO.translate("DISABLE")).."]"
			else
				formspec=formspec.."button[0.75,3.10;3,1;btnForgeOn;"..minetest.formspec_escape(modUFO.translate("ENABLE")).."]"
			end
			formspec=formspec.."list[detached:frmForge;dst;4.75,1.46;"..modUFO.forge.sizeDst.width..","..modUFO.forge.sizeDst.height..";]"
			.."list[current_player;main;0,4.75; 8,1;]"
			..default.get_hotbar_bg(0, 4.75)
			.."list[current_player;main;0,6.00; 8,3;8]"
			.."listring[detached:frmForge;dst]"
			.."listring[current_player;main]"
			.."listring[detached:frmForge;src]"
			.."listring[current_player;main]"
		return formspec
	end,
	furnace = function()
		local formspec = "size[8,6.5]"
			..modUFO.getFomTheme()
			.."list[current_name;fuel;0,0.25;1,1;]"
			.."image[1.0,0.2;0.8,0.8;"..minetest.formspec_escape(modUFO.getItemImage(modUFO.fuel_type)).."]"
			.."label[1.65,0.2;"..
				minetest.formspec_escape(
					"← "..modUFO.translate("Fuel: %s"):format(modUFO.getItemName(modUFO.fuel_type))
				) .." ]"
			.."label[0  ,1.4; "..minetest.formspec_escape(modUFO.translate("1º ← You need to park your UFO next to this!")).."]"
			.."label[0  ,1.8; "..minetest.formspec_escape(modUFO.translate("2º ← Press 'run key'(Key E) in your UFO to reload!")).."]"
			.."list[current_player;main;0,2.5;8,4;]"
			.."listring[current_name;fuel]"
			.."listring[current_player;main]"
		..""
		return formspec
	end,
}

--function modUFO.ufo:on_player_receive_fields(sender, formname, fields)
modUFO.on_player_receive_fields = function(self, sender, formname, fields)

	local sendername = sender:get_player_name()
	--modUFO.send_message(self, sendername, dump(sendername)..">>"..dump(formname)..">>"..dump(fields))
	if formname == "frmUFO" then -- This is your form name
		if fields.btnMainMenu then
			minetest.show_formspec(
				sender:get_player_name(),
				"frmUFO",
				modUFO.getFormSpecs.mainmenu()
			)
		elseif fields.btnLeave then
			modUFO.doButtonLeave(self, sender)
		elseif fields.btnEjectOk then
			sender:set_detach()
			self.driver = nil
			if self.soundHandles.engine~=nil then 
				minetest.sound_stop(self.soundHandles.engine) 
			end
		elseif fields.btnEjectCancel then
			minetest.show_formspec(
				sender:get_player_name(true),
				"frmUFO",
				modUFO.getFormSpecs.mainmenu(true)
			)
		elseif fields.btnControlHelp then
			minetest.show_formspec(
				sender:get_player_name(),
				"frmUFO",
				modUFO.getFormSpecs.controlhelp
			)
		elseif fields.btnControlHelp2 then
			minetest.show_formspec(
				sender:get_player_name(),
				"frmUFO",
				modUFO.getFormSpecs.controlhelp2
			)
		elseif fields.btnShowFiveTones then
			modUFO.doFiveTones(self, sender)
		elseif fields.btnShowForge then
			self.forge.visibled = true
			--modUFO.doButtonForge(self, sender)
		elseif fields.btnShowUpgrade then
			local newInv = minetest.create_detached_inventory_raw("frmUpgrades")
			newInv:set_size("trunk", 1)
			newInv:set_size("mailbox", 1)
			newInv:set_size("forge", 1)
			newInv:set_size("navegation", 1)
			minetest.show_formspec(
				sender:get_player_name(),
				"frmUpgrades",
				modUFO.getFormSpecs.upgrades(self, self.driver)
			)
		elseif fields.btnShowMailBox then
			if self.driver then
				if minetest.get_modpath("correio") and modCorreio~=nil then
					modCorreio.openinbox(sendername)
				else
					modUFO.doButtonFail(self, sendername, "correio")
				end
			end
		elseif fields.btnShowTrunk then
			if self.driver then
				if minetest.get_modpath("minertrade") and modMinerTrade~=nil then
					local drivername = self.driver:get_player_name()
					local inv = modMinerTrade.getDetachedInventory(self.owner_name)
					minetest.show_formspec(
						drivername,
						"safe_"..self.owner_name,
						modMinerTrade.getFormspec(
							self.owner_name, 
							modUFO.translate("CARRIER TRUNK owned by '%s':"):format(self.owner_name)
						)
					)
				else
					modUFO.doButtonFail(self, sendername, "minertrade")
				end
			end
		elseif fields.btnShowSettings then
			minetest.show_formspec(
				sender:get_player_name(),
				"frmSettings",
				modUFO.getFormSpecs.settings(self)
			)
		end
	elseif formname == "frmForge" then
		if fields.btnForgeOn then
			self.forge.enabled = true
		elseif fields.btnForgeOff then
			self.forge.enabled = false
		elseif fields.quit then
			self.forge.visibled = false
		end
	elseif formname == "frmSettings" then
		--filling fields
		if fields.txtShipName then
			self.shipname = fields.txtShipName or ""
			self.waypoint_position = nil --this line exit to update the waypoint
		end
		if fields.chkLocationSign then
			self.location_sign = fields.chkLocationSign
		end
		if fields.chkInertiaCancel then
			self.inertia_cancel = fields.chkInertiaCancel
			if self.driver then
				if self.inertia_cancel == "false" then
					modUFO.send_message(self, self.driver:get_player_name(), 
						modUFO.translate("Disabled 'Inertia Cancel' of this UFO!")
					,"sfx_falha")
				elseif self.inertia_cancel == "true" then
					modUFO.send_message(self, self.driver:get_player_name(), 
						modUFO.translate("Enabled 'Inertia Cancel' of this UFO!")
					,"sfx_falha")			
				end
			end
		end
		if fields.chkArtifIntel then
			if self.driver then
				--if self.enabled_ai == "false" then --Not exit this line because without AI cant speaker.
				if self.enabled_ai == "true" then
					--modUFO.play_fail(owner)
					modUFO.send_message(self, self.driver:get_player_name(), 
						modUFO.translate("Disabled 'Artificial Inteligency' of this UFO!")
					,"sfx_falha")
				end
			end
			self.enabled_ai = fields.chkArtifIntel
			--minetest.chat_send_all("self.enabled_ai="..self.enabled_ai)
		end
		if fields.btnSaveSettings	 then
			minetest.show_formspec(
				sender:get_player_name(true),
				"frmUFO",
				modUFO.getFormSpecs.mainmenu()
			)
		end
		
	end
end

modUFO.fuel_from_wear = function(wear)
	local fuel
	if wear == 0 then
		fuel = 0
	else
		fuel = (65535-(wear-1))*100/65535
	end
	return fuel
end

modUFO.wear_from_fuel = function(fuel)
	local wear = (100-(fuel))*65535/100+1
	if wear > 65535 then wear = 0 end
	return wear
end

modUFO.get_fuel = function(self)
	return self.fuel
end

modUFO.set_fuel = function(self,fuel,object)
	self.fuel = fuel
end

modUFO.ufo_to_item = function(self, takername)
	local wear = modUFO.wear_from_fuel(modUFO.get_fuel(self))
	local itemstack = ItemStack("ufos:ship")
	itemstack:set_wear(wear)
	
	local tmpDatabase = { --Unfortunately can only variables string and number.
		shipname = self.shipname,
		location_sign = self.location_sign,
		inertia_cancel = self.inertia_cancel,
		upgrades_artif_intel = self.upgrades.artif_intel,
		enabled_ai = self.enabled_ai,
		forgeListSrc = "",
		forgeListDst = "",
	}
	if not self.forge.inventory then
		self.forge.inventory = modUFO.getForgeInventory(self, takername)
		self.forge.inventory:set_size("src", modUFO.forge.sizeSrc.width*modUFO.forge.sizeSrc.height)
		self.forge.inventory:set_size("dst", modUFO.forge.sizeDst.width*modUFO.forge.sizeDst.height)
	end
	for i=1,self.forge.inventory:get_size("src") do
		local thisStack = self.forge.inventory:get_stack("src", i)
		if thisStack:get_name()~="" then
			if tmpDatabase.forgeListSrc~="" then tmpDatabase.forgeListSrc = tmpDatabase.forgeListSrc ..";" end
			tmpDatabase.forgeListSrc = tmpDatabase.forgeListSrc..thisStack:to_string()
		end
	end
	for i=1,self.forge.inventory:get_size("dst") do
		local thisStack = self.forge.inventory:get_stack("dst", i)
		if thisStack:get_name()~="" then
			if tmpDatabase.forgeListDst~="" then tmpDatabase.forgeListDst = tmpDatabase.forgeListDst ..";" end
			tmpDatabase.forgeListDst = tmpDatabase.forgeListDst..thisStack:to_string()
		end
	end
	--modUFO.send_message(self, takername, "tmpDatabase="..dump(tmpDatabase))
	itemstack:get_meta():from_table({fields = tmpDatabase})
	
	return itemstack
end

modUFO.ufo_from_item = function(itemstack, placer, pointed_thing)
	-- set owner
	modUFO.next_owner = placer:get_player_name()
	-- restore the fuel inside the item
	local wear = itemstack:get_wear()
	modUFO.set_fuel(
		modUFO.ufo, 
		modUFO.fuel_from_wear(wear)
	)

	-- add the entity
	--ship = minetest.env:add_entity(pointed_thing.above, "ufos:ship")
	local ship = minetest.add_entity(pointed_thing.above, "ufos:ship")
	if ship then
		ship:setyaw(placer:get_look_yaw() - math.pi / 2)

		local meta = itemstack:get_meta()
		local old_data = minetest.deserialize(itemstack:get_metadata())
		if old_data then
			meta:from_table({ fields = old_data })
		end
		local tmpDatabase = meta:to_table().fields
		if tmpDatabase then
			ship:get_luaentity().shipname = tmpDatabase.shipname
			ship:get_luaentity().location_sign = tmpDatabase.location_sign
			ship:get_luaentity().inertia_cancel = tmpDatabase.inertia_cancel			
			ship:get_luaentity().upgrades.artif_intel = tmpDatabase.upgrades_artif_intel
			ship:get_luaentity().enabled_ai = tmpDatabase.enabled_ai
			
			ship:get_luaentity().forge.inventory = modUFO.getForgeInventory(ship:get_luaentity(), placer:get_player_name())
			ship:get_luaentity().forge.inventory:set_size("src", modUFO.forge.sizeSrc.width*modUFO.forge.sizeSrc.height)
			ship:get_luaentity().forge.inventory:set_size("dst", modUFO.forge.sizeDst.width*modUFO.forge.sizeDst.height)

			if tmpDatabase.forgeListSrc then
				local ListSrc = tmpDatabase.forgeListSrc:split(";")
				for i=1, #ListSrc do
					if ListSrc[i]~="" then
						ship:get_luaentity().forge.inventory:set_stack("src", i, ItemStack(ListSrc[i]))
					end
				end 
			end
			if tmpDatabase.forgeListDst then
				local ListDst = tmpDatabase.forgeListDst:split(";")
				for i=1, #ListDst do
					if ListDst[i]~="" then
						ship:get_luaentity().forge.inventory:set_stack("dst", i, ItemStack(ListDst[i]))
					end
				end 
			end
		end --if tmpDatabase then
	end --if ship then
	-- remove the item
	itemstack:take_item()
	
	-- reset owner for next ufo
	modUFO.next_owner = ""
end

modUFO.check_owner = function(self, player)
	local playername = player:get_player_name()	
	if self.owner_name == "" then
		modUFO.send_message(self, playername, 
			modUFO.translate("This UFO was not protected, you are now its owner!")
		)
		modUFO.play_fail(self.object)
		self.owner_name = playername
		return true
	elseif playername == self.owner_name then
		return true
	elseif minetest.get_player_privs(playername).parkingman then
		if player:get_player_control().aux1 then
			return true
		else
			modUFO.send_message(self, playername, 
				modUFO.translate("Hold 'Run Key'(R or Ctrl) and Click to control the UFO owned by '%s'!"):format(self.owner_name)
			)
			modUFO.play_fail(self.object)
			return false
		end
	else
		modUFO.send_message(self, playername, 
			modUFO.translate("You can not interact with a UFO owned by '%s'!"):format(self.owner_name)
		)
		modUFO.play_fail(self.object)
	end
end

modUFO.next_owner = ""


