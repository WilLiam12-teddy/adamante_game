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

minetest.register_craftitem( "adamante:potato_chips", {
	description = "Batata Chips",
	inventory_image = "potato_chips.png",
	wield_image = "potato_chips.png",
	on_use = minetest.item_eat(3),
})
