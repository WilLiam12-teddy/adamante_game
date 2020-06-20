--[[
	Mod Tp_Item para Minetest
	
  ]]

local spawn_pos = minetest.setting_get_pos("static_spawnpoint")

minetest.register_craftitem("tp_item:tp_spawn", {
	description = "Bebida Magica de teleporte para Spawn",
	inventory_image = "tp_item_tp_spawn.png",
	groups = {},
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if spawn_pos then
			user:setpos(spawn_pos)
			itemstack:set_name("vessels:glass_bottle")
			minetest.chat_send_player(user:get_player_name(), "Teleportado para Spawn")
			minetest.sound_play("tp_item_tp_spawn", {
				to_player = user:get_player_name(),
				gain = 1,
			})
			return itemstack
		else
			minetest.chat_send_player(user:get_player_name(), "O spawn ainda nao foi definido no servidor")
		end
	end
})

-- Receita
minetest.register_craft( {
	output = "tp_item:tp_spawn",
	recipe = {
		{"", "default:mese_crystal_fragment", ""},
		{"default:apple", "default:mese_crystal_fragment", "default:apple"},
		{"", "vessels:glass_bottle", ""}
	}
})
