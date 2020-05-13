-- chat commands
-- uses extras.crash
--      extras.nospawn

if extras.rollback~=0 then
    print("[extras] rollback commands - ACTIVE")
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
end

-- minetest.register_chatcommand("priv0", {
--     description = "Clear privs, ADD shout.",
--     privs = {server = true},
--     func = function( name, param)
--         if param==""  or name=="" then
--             minetest.chat_send_player(name, "I need a name...")
--             return false
--         end
--         extras.setprivs_jailed( param)
--     end,
--     })
--
-- minetest.register_chatcommand("priv1", {
--     description = "Clear privs, ADD default_privs",
--     privs = {server = true},
--     func = function( name, param)
--         if param==""  or name=="" then
--             minetest.chat_send_player(name, "I need a name...")
--             return false
--         end
--         extras.setprivs_released( param)
--     end,
--     })
--
-- minetest.register_chatcommand("p", {
--     description = "Promote to Player",
--     privs = {ismod = true},
--     func = function( name, param)
--         minetest.chat_send_all("Player "..param.." is promoted to PLAYER, They can now build beyond the wall.")
--         local privs = minetest.get_player_privs(param)
--         privs.spill = true
--         privs.outlander = true
--         privs.noclip = true
--         minetest.set_player_privs(param, privs)
--         return false
--     end,
--     })

if extras.nospawn==0 then

    minetest.register_chatcommand("spawn", {
        description = "Teleport player to spawn point.",
        privs = {interact=true},
        func = function ( name, param )
            local spawnpoint = extras.spawnpoint
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
end

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

if extras.adminreset~=0 then
    minetest.register_chatcommand("r", {
        description = "Reset the server.",
        privs = {server=true},
        func = function ( name, param )
        --boop.boom(bob)
        minetest.request_shutdown("   !!!!!  SERVER RESTART... COUNT TO 10 THEN PRESS RECONNECT !!!", true)
        end,
    })
end

if extras.jail~=0 then
    minetest.register_chatcommand("setjail", {
        description = "Set the position of the Jail to where you are now.",
        privs = {setjail=true},
        func = function ( name, param )
            extras.jail_data.jailpos = vector.round(minetest.get_player_by_name(name):getpos())
            extras.save_jail(extras.jail_data)
            return true, "Jail position set."
        end,
    })

    minetest.register_chatcommand("setrelease", {
        description = "Set the release position to where you are now.",
        privs = {setjail=true},
        func = function ( name, param )
            extras.jail_data.releasepos = vector.round(minetest.get_player_by_name(name):getpos())
            extras.save_jail(extras.jail_data)
            return true, "Release position Set."
        end,
    })

    minetest.register_chatcommand("jail", {
        params = "<player>",
        description = "Sends a player to Jail",
        privs = {jail=true},
        func = function ( name, param )
            local player = minetest.get_player_by_name(param)
            if (player) then
--                print("go for jailing "..param)
                extras.players_in_jail[param] = player;
                player:setpos(vector.round(extras.jail_data.jailpos))
                minetest.chat_send_all(""..param.." has been sent to jail by "..name.."")
                extras.setprivs_jailed(param)
            end
        end,
    })

    minetest.register_chatcommand("release", {
        params = "<player>",
        description = "Releases a player from Jail",
        privs = {jail=true},
        func = function ( name, param )
            if (param == "") then return end
            local player = minetest.get_player_by_name(param)
            extras.players_in_jail[param] = nil;
            if (player) then
                extras.setpos(extras.jail_data.releasepos,player)
                minetest.chat_send_all(""..param.." has been released from jail by "..name.."")
                extras.setprivs_released(param)
            end
        end,
    })
end
