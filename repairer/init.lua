local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/config.lua")
dofile(modpath.."/translate.lua")
dofile(modpath.."/api.lua")
dofile(modpath.."/find_nodes.lua")
dofile(modpath.."/repairer_bench.lua")


repairer.urlTabela = minetest.get_worldpath().."/repairer.tbl"
--repairer.replace.nodes =  {{"lunodecor:lamp", "lamps:lamp"}, {"moreblocks:glow_glass", "default:obsidian_glass"}, {"moreblocks:panel_obsidian_glass_12", "default:obsidian_glass"}, {"moreblocks:slab_obsidian_glass", "default:obsidian_glass"}, {"moreblocks:slab_obsidian_glass_1", "default:obsidian_glass"}, {"moreblocks:slab_obsidian_glass_2", "default:obsidian_glass"}, {"moreblocks:super_glow_glass", "lamps:lamp"}, {"moreblocks:slab_super_glow_glass", "lamps:lamp"}, {"moreblocks:slab_super_glow_glass_1", "lamps:lamp"}, {"moreblocks:slab_super_glow_glass_2", "lamps:lamp"}, {"moreblocks:slab_glass", "default:glass"}, {"moreblocks:slab_glass_1", "default:glass"}, {"moreblocks:slab_glass_2", "default:glass"}, {"moreblocks:wood_tile_full", "default:wood"}, {"moreblocks:stair_glass", "air"}, {"moreblocks:stair_stone_tile", "air"}, {"moreblocks:stair_cobble_half", "default:cobble"}, {"moreblocks:stair_cobble_right_half", "default:cobble"}, {"moreblocks:slab_cobble_1", "default:cobble"}, {"moreblocks:micro_cobble_15", "default:cobble"}, {"moreblocks:panel_cobble_15", "default:cobble"}, {"moreblocks:split_stone_tile", "default:stonebrick"}, {"moreblocks:split_stone_tile_alt", "default:sandstonebrick"}, {"moreblocks:panel_split_stone_tile_alt_14", "default:sandstonebrick"}, {"moreblocks:slab_stone_tile", "default:sandstonebrick"}, {"moreblocks:stone_tile", "default:sandstonebrick"}, {"moreblocks:iron_stone_bricks", "default:sandstonebrick"}, {"moreblocks:panel_cobble", "default:cobble"}, {"moreblocks:coal_checker", "ceramicas:preta"}, {"moreblocks:slab_goldblock_1", "ceramicas:folha_amarela"}, {"fake_fire:smokeless_ice_fire", "air"}, {"lunodecor:lightsensitive", "sensitiveblocks:lightsensitive"}, {"lunodecor:shieldblock_stone", "sensitiveblocks:shieldblock_stone"}, {"lunodecor:ghostblock_stone", "sensitiveblocks:ghostblock_stone"}, {"lunodecor:ghostblock_stonebrick", "sensitiveblocks:ghostblock_stonebrick"}, {"lunodecor:frame_lunovox", "default:goldblock"}, {"lunodecor:doorbell", "doorbells:doorbell"}, {"moreblocks:fence_jungle_wood", "default:fence_wood"}, {"moreblocks:fence_pine_wood", "default:fence_wood"}}
--repairer.doSave()
repairer.doLoad()
repairer.doFindNodes()

minetest.log('action',"["..modname:upper().."] Carregado!")
