local id = terumet.id
local tex = terumet.tex

terumet.alloys = {}

function terumet.reg_alloy(name, alloy_id, block_level, repairmat_value)
    local ingot_id = 'ingot_' .. alloy_id
    local block_id = 'block_' .. alloy_id

    minetest.register_craftitem( id(ingot_id), {
        description = name .. ' Ingot',
        inventory_image = tex(ingot_id),
        groups = {ingot=1}
    })

    minetest.register_node( id(block_id), {
        description = name .. ' Block',
        tiles = {tex(block_id)},
        is_ground_content = false,
        groups = {cracky=1, level=block_level},
        sounds = default.node_sound_metal_defaults()
    })

    minetest.register_craft{ output = id(block_id),
        recipe = terumet.recipe_3x3(id(ingot_id))
    }

    minetest.register_craft{ type = 'shapeless', output = id(ingot_id, 9),
        recipe = {id(block_id)}
    }

    terumet.alloys[alloy_id] = {ingot=id(ingot_id), block=id(block_id)}

    terumet.register_repair_material(id(ingot_id), repairmat_value)
end