
spawnpoint       = minetest.setting_get_pos("static_spawnpoint") or {490.0, 27.5, 144.0}

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

minetest.register_chatcommand("spawn", {
    description = "Teleport player to spawn point.",
    privs = {interact=true},
    func = function ( name, param )
        local spawnpoint = spawnpoint
--            local spawnpoint = {x=13,y=138,z=0}
        local player = minetest.get_player_by_name(name)
        if minetest.get_modpath("xp_redo") then
            if xp_redo.get_xp(player:get_player_name()) < 50 then
                minetest.chat_send_player(player:get_player_name(), "Not enough XP to Teleport to spawn... DO THE MISSION!!!")
                return false
            end
        end
        minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
        extras.setpos( spawnpoint , player)
        return true
    end,
})

minetest.register_chatcommand("afk", {
    description = "Tell everyone you are afk.",
	privs = {interact=true},
    func = function ( name, param )
        local player = minetest.get_player_by_name(name)
        minetest.chat_send_all(name.." is AFK! "..param)
        return true
    end,
})

minetest.register_chatcommand("ping", {
    privs = {server = true},
    params = "",
    description = "Get ip & ping of players",
    func = function(player_name, param)
		for i, player in pairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			if name then
				local ping = minetest.get_player_information(name).avg_rtt / 2
				ping = math.floor(ping * 1000)
				minetest.chat_send_player(player_name, "     "..name.." IP:"..minetest.get_player_information(name).address.."  Ping: "..ping.."ms")
			end
		end
	end
})

minetest.register_chatcommand("wit", {
    privs = {server = true},
    params = "",
    description = "Get itemstring of wielded item",
    func = function(player_name, param)
	local player = minetest.get_player_by_name(player_name)
	minetest.chat_send_player(player_name, player:get_wielded_item():to_string())
	return
    end
})

minetest.register_chatcommand("eday", {
    privs = {settime = true},
    params = "<player_name>",
    description = "Eternal Day (It never gets dark.)",
    func = function(player_name, param)
        minetest.set_timeofday(0.5)
        minetest.setting_set("time_speed","0")
    end
})

minetest.register_chatcommand("r", {
    description = "Reset the server.",
    privs = {server=true},
    func = function ( name, param )
    --boop.boom(bob)
    minetest.request_shutdown("   !!!!!  SERVER RESTART... COUNT TO 10 THEN PRESS RECONNECT !!!", true)
    end,
})
