minetest.register_tool("adamante:tool", {
    description = "Adamante Tool",
    inventory_image = "adamante_tool.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = { [1]=0.00, [2]=0.00, [3]=0.00 }
            },
        },
        damage_groups = {fleshy=20},
    },
})

minetest.register_tool("adamante:little_tool", {
    description = "Little Tool",
    inventory_image = "adamante_little_tool.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = { [1]=1.60, [2]=1.20, [3]=0.80 }
            },
        },
        damage_groups = {fleshy=2},
    },
})

minetest.register_tool("adamante:shovel", {
    description = "Adamante Shovel",
    inventory_image = "adamante_shovel.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = { [1]=0.00, [2]=0.00, [3]=0.00 }
            },
        },
        damage_groups = {fleshy=20},
    },
})

minetest.register_craftitem("adamante:superapple", {
    description = "Adamante Super Apple",
    inventory_image = "adamante_superapple.png",
    on_use = minetest.item_eat(30),
})

minetest.register_craft({
    type = "shaped",
    output = "adamante:superapple 9",
    recipe = {
        {"default:diamondblock", "",                         ""},
        {"default:diamondblock", "default:diamondblock",  ""},
        {"default:diamondblock", "default:apple",  ""}
    }
})


minetest.register_craftitem("adamante:pizza", {
    description = "Pizza",
    inventory_image = "adamante_pizza.png",
    on_use = minetest.item_eat(7),
})

minetest.register_craft({
    type = "shaped",
    output = "adamante:pizza 3",
    recipe = {
        {"farming:chili", "",                         ""},
        {"farming:tomato", "farming:carrot",  ""},
        {"farming:chili_pepper", "farming:bread",  ""}
    }
})

minetest.register_node("adamante:lgbt", {
    description = "LGBT Block",
    tiles = {"adamante_lgbt.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})

minetest.register_craft({
    type = "shaped",
    output = "adamante:lgbt 18",
    recipe = {
        {"dye:red", "",                         ""},
        {"dye:blue", "default:obsidian",  ""},
        {"dye:yellow", "dye:green",  ""}
    }
})


minetest.register_node("adamante:unknown", {
    description = "Unknown Block",
    tiles = {"adamante_unknown.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
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


minetest.register_node("adamante:wood", {
    description = "Adamante Wood",
    tiles = {"adamante_wood.png"},
    is_ground_content = true,
    groups = {cracky=3, stone=1}
})


minetest.register_chatcommand("spawn", {
    description = "Teleport player to spawn point.",
    privs = {interact=true},
    func = function ( name, param )
        local spawnpoint = spawnpoint
--            local spawnpoint = {490.0, 27.5, 144.0}
        local player = minetest.get_player_by_name(name)
        if minetest.get_modpath("xp_redo") then
            if xp_redo.get_xp(player:get_player_name()) < 50 then
                minetest.chat_send_player(player:get_player_name(), "Not enough XP to Teleport to spawn... DO THE MISSION!!!")
                return false
            end
        end
        minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
        return true
    end,
})