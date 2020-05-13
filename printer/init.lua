local function eject_item(pos,dir,item,speed)
	if not speed then speed = 3 end
	local spawnpos = vector.add(pos,vector.multiply(dir,-0.6))
	local velocity = vector.multiply(dir,speed*-1)
	local item = minetest.add_item(spawnpos,item)
	item:set_velocity(velocity)
end

minetest.register_craftitem("printer:document",{
	description = "Printed Document",
	inventory_image = "printer_document.png",
	stack_max = 1,
	groups = {
		not_in_creative_inventory = 1,
	},
	on_place = function(itemstack,placer)
		if not placer then return end
		local contents = itemstack:get_meta():get_string("contents")
		local fs = string.format("size[4,6]textarea[0.25,1;4,6;text;;%s]button_exit[0,0;2,1;exit;Exit]",minetest.formspec_escape(contents))
		minetest.show_formspec(placer:get_player_name(),"printer:document_text",fs)
	end,
})

minetest.register_node("printer:printer",{
	description = "Digilines Printer",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	is_ground_content = false,
	tiles = {
		"printer_top.png",
		"printer_sides.png",
		"printer_sides.png",
		"printer_sides.png",
		"printer_sides.png",
		"printer_sides.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,-0.2,0.3,-0.2,0.2},
			{-0.2,-0.5,-0.5,0.2,-0.4,-0.2},
		},
	},
	groups = {
		dig_immediate = 2,
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:get_inventory():set_size("paper",1)
		meta:set_string("formspec","size[8,6]label[1,0;Paper Tray]list[context;paper;1,0.5;1,1]list[current_player;main;0,2;8,4]listring[]field[3,0.75;2,1;channel;Channel;${channel}]button_exit[5,0.5;2,1;set;Set]")
	end,
	can_dig = function(pos,player)
		local name = player:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return false
		end
		return minetest.get_meta(pos):get_inventory():is_empty("paper")
	end,
	on_receive_fields = function(pos,_,fields,sender)
		local name = sender:get_player_name()
		if not fields.set then return end
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		minetest.get_meta(pos):set_string("channel",fields.channel)
	end,
	allow_metadata_inventory_put = function(pos,_,_,stack,player)
		local name = player:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return 0
		end
		if stack:get_name() ~= "default:paper" then
			minetest.chat_send_player(name,"Only paper can be inserted here.")
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos,_,_,stack,player)
		local name = player:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return 0
		end
		return stack:get_count()
	end,
	digiline = {
		wire = {
			rules = {
				{x =  1,y =  0,z =  0,},
				{x = -1,y =  0,z =  0,},
				{x =  0,y =  1,z =  0,},
				{x =  0,y = -1,z =  0,},
				{x =  0,y =  0,z =  1,},
				{x =  0,y =  0,z = -1,},
				{x =  0,y = -2,z =  0,},
			},
		},
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
				local meta = minetest.get_meta(pos)
				if channel ~= meta:get_string("channel") or type(msg) ~= "table" or not msg.command then return end
				local paperstack = meta:get_inventory():get_stack("paper",1)
				local facedir = minetest.facedir_to_dir(node.param2)
				if msg.command == "get_status" then
					if paperstack:get_count() > 0 then
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "OK",paper_left = paperstack:get_count(),})
					else
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "no_paper",paper_left = paperstack:get_count(),})
					end
				elseif msg.command == "formfeed" then
					if paperstack:get_count() > 0 then
						eject_item(pos,facedir,ItemStack("default:paper"))
						paperstack:take_item(1)
						minetest.sound_play("printer_feed",{pos=pos})
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "OK",paper_left = paperstack:get_count(),})
					else
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "no_paper",paper_left = paperstack:get_count(),})
					end
				elseif msg.command == "print" then
					if paperstack:get_count() > 0 then
						local document = ItemStack("printer:document")
						local stackmeta = document:get_meta()
						if type(msg.title) ~= "string" then msg.title = "(no title)" end
						if type(msg.contents) ~= "string" then msg.contents = "" end
						stackmeta:set_string("description","Printed Document: "..msg.title)
						stackmeta:set_string("contents",msg.contents)
						eject_item(pos,facedir,document)
						paperstack:take_item(1)
						minetest.sound_play("printer_print",{pos=pos})
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "OK",paper_left = paperstack:get_count(),})
					else
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "no_paper",paper_left = paperstack:get_count(),})
					end
				end
				meta:get_inventory():set_stack("paper",1,paperstack)
			end,
		},
	},
})

minetest.register_craftitem("printer:receipt",{
	description = "Receipt",
	inventory_image = "printer_receipt.png",
	stack_max = 1,
	groups = {
		not_in_creative_inventory = 1,
	},
	on_place = function(itemstack,placer)
		if not placer then return end
		local contents = itemstack:get_meta():get_string("contents")
		local fs = string.format("size[3,8]textarea[0.25,1;3,8;text;;%s]button_exit[0,0;2,1;exit;Exit]",minetest.formspec_escape(contents))
		minetest.show_formspec(placer:get_player_name(),"printer:document_text",fs)
	end,
})

minetest.register_craftitem("printer:receiptpaper_core",{
	description = "Empty Receipt Paper Roll",
	inventory_image = "printer_receiptpaper_core.png",
})

minetest.register_tool("printer:receiptpaper_roll",{
	description = "Roll of Receipt Paper",
	inventory_image = "printer_receiptpaper_roll.png",
})

minetest.register_node("printer:receipt_printer",{
	description = "Digilines Receipt Printer",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	is_ground_content = false,
	tiles = {
		"printer_receipt_top.png",
		"printer_sides.png",
		"printer_sides.png",
		"printer_sides.png",
		"printer_sides.png",
		"printer_sides.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,-0.5,-0.2,0.15,-0.2,0.2},
		},
	},
	groups = {
		dig_immediate = 2,
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:get_inventory():set_size("paper",1)
		meta:set_string("formspec","size[8,6]label[1,0;Paper Compartment]list[context;paper;1,0.5;1,1]list[current_player;main;0,2;8,4]listring[]field[3,0.75;2,1;channel;Channel;${channel}]button_exit[5,0.5;2,1;set;Set]")
	end,
	can_dig = function(pos,player)
		local name = player:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return false
		end
		return minetest.get_meta(pos):get_inventory():is_empty("paper")
	end,
	on_receive_fields = function(pos,_,fields,sender)
		local name = sender:get_player_name()
		if not fields.set then return end
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		minetest.get_meta(pos):set_string("channel",fields.channel)
	end,
	allow_metadata_inventory_put = function(pos,_,_,stack,player)
		local name = player:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return 0
		end
		if stack:get_name() ~= "printer:receiptpaper_roll" then
			minetest.chat_send_player(name,"Only receipt paper rolls can be inserted here.")
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos,_,_,stack,player)
		local name = player:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return 0
		end
		return stack:get_count()
	end,
	digiline = {
		wire = {
			rules = {
				{x =  1,y =  0,z =  0,},
				{x = -1,y =  0,z =  0,},
				{x =  0,y =  1,z =  0,},
				{x =  0,y = -1,z =  0,},
				{x =  0,y =  0,z =  1,},
				{x =  0,y =  0,z = -1,},
				{x =  0,y = -2,z =  0,},
			},
		},
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
				local meta = minetest.get_meta(pos)
				if channel ~= meta:get_string("channel") or type(msg) ~= "table" or not msg.command then return end
				local paperstack = meta:get_inventory():get_stack("paper",1)
				local facedir = minetest.facedir_to_dir(node.param2)
				if msg.command == "get_status" then
					if paperstack:get_count() > 0 and paperstack:get_name() == "printer:receiptpaper_roll" then
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "OK",paper_left = 65535-paperstack:get_wear(),})
					else
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "no_paper",paper_left = 0,})
					end
				elseif msg.command == "print" then
					if paperstack:get_count() > 0 and paperstack:get_name() == "printer:receiptpaper_roll" then
						local document = ItemStack("printer:receipt")
						local stackmeta = document:get_meta()
						if type(msg.origin) ~= "string" then msg.origin = "somewhere" end
						if type(msg.contents) ~= "string" then msg.contents = "" end
						stackmeta:set_string("description","Receipt from "..msg.origin)
						stackmeta:set_string("contents",msg.contents)
						eject_item(pos,facedir,document)
						minetest.sound_play("printer_print_receipt",{pos=pos})
						local newwear = paperstack:get_wear()+math.floor(string.len(msg.contents)/10)
						if newwear >= 65535 then
							paperstack = ItemStack("printer:receiptpaper_core")
						else
							paperstack:set_wear(newwear)
						end
						meta:get_inventory():set_stack("paper",1,paperstack)
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "OK",paper_left = math.max(0,65535-newwear),})
					else
						digiline:receptor_send(pos,digiline.rules.default,channel,{status = "no_paper",paper_left = 0,})
					end
				end
			end,
		},
	},
})

minetest.register_craft({
	output = "printer:printer",
	recipe =  {{"","basic_materials:plastic_sheet","basic_materials:ic"},
			{"homedecor:motor","default:steel_ingot","basic_materials:steel_bar"},
			{"","basic_materials:plastic_sheet","homedecor:motor"}},
})

minetest.register_craft({
	output = "printer:receipt_printer",
	recipe =  {{"","basic_materials:plastic_sheet","basic_materials:ic"},
			{"","basic_materials:heating_element",""},
			{"","basic_materials:plastic_sheet","homedecor:motor"}},
})

minetest.register_craft({
	output = "printer:receiptpaper_core",
	recipe =  {{"","basic_materials:plastic_sheet",""},
			{"basic_materials:plastic_sheet","dye:black","basic_materials:plastic_sheet"},
			{"","basic_materials:plastic_sheet",""}},
})

minetest.register_craft({
	output = "printer:receiptpaper_roll",
	recipe =  {{"default:paper","default:paper","default:paper"},
			{"default:paper","printer:receiptpaper_core","default:paper"},
			{"default:paper","default:paper","default:paper"}},
})
