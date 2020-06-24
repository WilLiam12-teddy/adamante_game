local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local strategie = nil

-- Strategies
-- strategie = "fast.lua"
-- strategie = "slow.lua"


if(strategie ~= nil) then
    print("[".. modname .. "] starts now " .. moddir .. "/" .. strategie)
    -- Now start the Remover
    dofile(modpath .. "/" .. strategie)

end -- if(strategie

local S

if(minetest.get_modpath("intllib")) then
    S = dofile(modpath .."/intllib.lua")
    print("[MOD] " .. modname .. ": translating in intllib-mode.")
    
else
    S = minetest.get_translator(modname)
    print("[MOD] " .. modname .. ": translating in minetest-mode.")
    
end -- if(minetest.get_modpath(

    
local remover = {}

remover.green = '#00FF00'
remover.red = '#FF0000'
remover.orange = '#FF6700'
remover.blue = '#0000FF'
remover.yellow = '#FFFF00'
remover.purple = '#FF00FF'
remover.pink = '#FFAAFF'
remover.white = '#FFFFFF'
remover.black = '#000000'
remover.grey = '#888888'
remover.light_blue = '#8888FF'
remover.light_green = '#88FF88'
remover.light_red = '#FF8888'
remover.none = 99

-- magnifier

minetest.register_craftitem(modname .. ":magnifier", {
	description = S("Magnifying Glass"),
	inventory_image = "remover_magnifier.png",
	stack_max = 1,
	liquids_pointable = true,

	on_use = function(itemstack, user, pointed_thing)
	
		local pos = minetest.get_pointed_thing_position(pointed_thing)
		local name = user:get_player_name()
		
		remover.show_node(name, pos)
	    
	end,
})

minetest.register_craft({
	output = modname .. ":magnifier",
	recipe = {
		{"default:glass", "default:mese_crystal_fragment"},
		{"default:stick", ""}
	}
})

-- Moving from Chathelp to Remover
minetest.register_alias("chathelp:magnifier", modname .. ":magnifier")

-- Shows Information about an Item you point on it
function remover.show_node(name, pos)

	if pos then
	
		local node = minetest.get_node(pos)
		local light = minetest.get_node_light(pos)
		local dlight = minetest.get_node_light({x=pos.x, y=pos.y -1, z=pos.z})
		local ulight = minetest.get_node_light({x=pos.x, y=pos.y +1, z=pos.z})
		local nodepos = minetest.pos_to_string(pos)
		local protected = minetest.is_protected(pos, name)
		
		remover.print(name, S("Name of the Node: "), remover.purple)
		remover.print(name, node.name, remover.green)
		remover.print(name, S("Located at: ") .. nodepos, remover.green)
		remover.print(name, S("Light on the Node: ") .. light .. ".", remover.yellow)
		remover.print(name, S("Light above: ") .. ulight .. ".", remover.yellow)
		remover.print(name, S("Light under: ") .. dlight .. ".", remover.yellow)
		
		if(protected) then
			remover.print(name, S("Is protected? Yes."), remover.white)
		else
			remover.print(name, S("Is protected: No."), remover.white)
		end
		
		if(minetest.registered_nodes[node.name] ~= nil) then
			if(minetest.registered_nodes[node.name].diggable) then
				remover.print(name, S("Is diggable."), remover.orange)
			end

			if(minetest.registered_nodes[node.name].walkable) then
				remover.print(name, S("Is walkable."), remover.orange)
			end

			if(minetest.registered_nodes[node.name].climbable) then
				remover.print(name, S("Is climbable."), remover.orange)
			end

			if(minetest.registered_nodes[node.name].buildable_to) then
				remover.print(name, S("Is replaceable."), remover.orange)
			end

			if(minetest.registered_nodes[node.name].liquid_renewable) then
				remover.print(name, S("Is regenerateable."), remover.orange)
			end
		
			if(minetest.registered_nodes[node.name].use_texture_alpha) then
				remover.print(name, S("Has an alpha-channel."), remover.orange)
				remover.print(name, S("With a transparency of ") .. 255 - minetest.registered_nodes[node.name].alpha .. " / 255.", remover.light_blue)
			end

			if(minetest.registered_nodes[node.name].sunlight_propagates) then
				remover.print(name, S("Light shines trough."), remover.orange)
			end
		
			if(minetest.registered_nodes[node.name].light_source > 0) then
				remover.print(name, S("Shines with Lightlevel ") .. minetest.registered_nodes[node.name].light_source .. " / 15.", remover.light_blue)
			end
		
			if(minetest.registered_nodes[node.name].damage_per_second > 0) then
				remover.print(name, S("Deals with ") .. minetest.registered_nodes[node.name].damage_per_second .. S(" Points Damage per Second."), remover.light_green)
			end
		
			remover.print(name, S("Stacks with ") .. minetest.registered_nodes[node.name].stack_max .. S(" Items / Stack."), remover.light_red)
		else
			remover.print(name, S("Node unknown!"), remover.red)
		end
		
	else
	
		remover.print(name, S("Pointed on no Node."), remover.red)
	
	end

end -- remover.show_me()

-- Writes a Message in a specific color or Logs it
function remover.print(name, message, color)

    if(color ~= remover.none) then
        minetest.chat_send_player(name, core.colorize(color, message))
        return
		
    else 
        minetest.chat_send_player(name,  message)
        return
    end
			
end -- print_message()

print("["..modname .. "] loaded.")
