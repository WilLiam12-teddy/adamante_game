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

minetest.register_chatcommand("spawn", {
	description = "Teleport to spawn",
	privs = {interact=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if param ~= "" then
			local pplayer = minetest.get_player_by_name(param)
			if pplayer and minetest.check_player_privs(pplayer, {bring=true}) then
				player = pplayer
			else
				return false, "Cannot teleport another player to spawn without bring privilege"
			end
		end

		if not spawnpoint.pos then
			return false, "No spawnpoint set!"
		end

		spawnpoint.begin(player)
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