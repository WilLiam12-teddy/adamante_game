local modpath = minetest.get_modpath("nice_doors").. DIR_DELIM

nice_doors = {}

dofile(modpath.."metal.lua")
dofile(modpath.."wood.lua")
dofile(modpath.."glass.lua")
dofile(modpath.."wood_crafts.lua")
dofile(modpath.."glass_crafts.lua")
dofile(modpath.."metal_crafts.lua")
