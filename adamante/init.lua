minetest.register_privilege("ismod", { description = "Allows one to promote players" })
minetest.register_privilege("isplayer", { description = "Allows one to keep your creations on the server" })
minetest.register_privilege("jail", { description = "Allows one to send/release prisoners" })
minetest.register_privilege("setjail", { description = "Allows one to set the jail position and the release position" })

minetest.register_node("adamante:will", {
description="Will e Agatha",
         drawtype = "nodebox",
         node_box = {
             type = "wallmounted",
             wall_top    = {-0.4875, 0.4875, -0.4875, 0.4875, 0.5, 0.4875},
             wall_bottom = {-0.4875, -0.5, -0.4875, 0.4875, -0.4875, 0.4875},
             wall_side   = {-0.5, -0.4875, -0.4875, -0.4875, 0.4875, 0.4875},
         },
     	paramtype = "light",
     	paramtype2 = "wallmounted",
         wield_image = "will.png",
         sunlight_propagates = true,
         tiles = { "will.png" },
 		light_source = 14,
         inventory_image = "will.png",
		groups = {cracky=3, choppy=3},
		sounds = default.node_sound_stone_defaults(),
	})

minetest.register_chatcommand("rbc", {
    description = "who built it?",
    privs = {ismod = true},
    func = function( name, param)
        local cmd_def = minetest.chatcommands["rollback_check"]
        if cmd_def then
            minetest.chat_send_player(name, "Punch a node to ID builder...")
            cmd_def.func(name, "rollback_check 1 100000000")
        end
        return false
    end,
    })


minetest.register_chatcommand("roll", {
    description = "Demote & rollback Player",
    privs = {ismod = true},
    func = function( name, param)
        minetest.chat_send_all("Player "..param.." has privs removed, and all their work is being removed from the game.")
        local privs = {}
        --minetest.get_player_privs(param)
        privs.shout = 1
        minetest.set_player_privs(param, privs)
        minetest.rollback_revert_actions_by("player:"..param, 100000000)
        return false
    end,
    })

minetest.register_chatcommand("afk", {
    description = "Tell everyone you are afk.",
	privs = {interact=true},
    func = function ( name, param )
        local player = minetest.get_player_by_name(name)
        minetest.chat_send_all(name.." está AFK! "..param)
        return true
    end,
})

minetest.register_chatcommand("r", {
    description = "Reset the server.",
    privs = {server=true},
    func = function ( name, param )
    --boop.boom(bob)
    minetest.request_shutdown("   !!!!!  SERVER RESTART... COUNT TO 10 THEN PRESS RECONNECT !!!", true)
    end,
})

local disable_sounds = minetest.settings:get_bool("shields_disable_sounds")

local function play_sound_effect(player, name)
	if not disable_sounds and player then
		local pos = player:getpos()
		if pos then
			minetest.sound_play(name, {
				pos = pos,
				max_hear_distance = 10,
				gain = 0.5,
			})
		end
	end
end

armor:register_armor("adamante:helmet", {
	description = "Moderator Helmet",
	inventory_image = "adamante_inv_helmet.png",
	groups = {armor_head=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=15},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("adamante:chestplate", {
	description = "Moderator Chestplate",
	inventory_image = "adamante_inv_chestplate.png",
	groups = {armor_torso=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=20},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("adamante:leggings", {
	description = "Moderator Leggings",
	inventory_image = "adamante_inv_leggings.png",
	groups = {armor_legs=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=20},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("adamante:boots", {
	description = "Moderator Boots",
	inventory_image = "adamante_inv_boots.png",
	groups = {armor_feet=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=15},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("adamante:shield", {
	description = "Moderator Shield",
	inventory_image = "adamante_inv_shield.png",
	groups = {armor_shield=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=15},
	damage_groups = {cracky=2, snappy=1, level=3},
	reciprocate_damage = true,
	on_damage = function(player, index, stack)
		play_sound_effect(player, "default_glass_footstep")
	end,
	on_destroy = function(player, index, stack)
		play_sound_effect(player, "default_break_glass")
	end,
})

print("[OK] Moderator armor")

local spawn_spawnpos = minetest.setting_get_pos("static_spawnpoint")

minetest.register_chatcommand("spawn", {
	params = "",
	description = "Teleport to the spawn point",
        privs = { fly=true },
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end
		if spawn_spawnpos then
			player:setpos(spawn_spawnpos)
			return true, "Teleporting to spawn..."
		else
			return false, "The spawn point is not set!"
		end
	end,
})

minetest.register_chatcommand("setspawn", {
	params = "",
	description = "Sets the spawn point to your current position",
	privs = { server=true },
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end
		local pos = player:getpos()
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local pos_string = x..","..y..","..z
		local pos_string_2 = "Setting spawn point to ("..x..", "..y..", "..z..")"
		minetest.setting_set("static_spawnpoint",pos_string)
		spawn_spawnpos = pos
		minetest.setting_save()
		return true, pos_string_2
	end,
})

minetest.register_node("adamante:pequenogamer", {
    description = "PequenoGamer",
    tiles = {"yay_pequenogamer.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})

minetest.register_tool("adamante:killer_tool", {
	description = ("Killer Tool - Movimento Anti mcfoxyotuber"),
	range = 12,
	inventory_image = "tool_anti_mcfoxyoutuber.png",
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level = 3,
		groups = {cracky = 3},
		groupcaps= {
			unbreakable = {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			fleshy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			choppy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			bendy =       {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			cracky =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			crumbly =     {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			snappy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
		},
		damage_groups = {fleshy = 1000},
	},
})