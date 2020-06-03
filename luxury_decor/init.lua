cabs_table = {}

rgb_colors = {
    ["black"] = "#000000",
    ["red"] = "#FF0000",
    ["green"] = "#00FF00",
    ["white"] = "#FFFFFF",
    ["blue"] = "#0000FF",
    ["yellow"] = "#FFFF00",
    ["magenta"] = "#FF00FF",
    ["cyan"] = "#00FFFF",
    ["dark_green"] = "#008000",
    ["dark_grey"] = "#808080",
    ["grey"] = "#C0C0C0",
    ["brown"] = "#A52A2A",
    ["orange"] = "#FF4500",
    ["pink"] = "#F08080",
    ["violet"] = "#4B0082"
}

local modpath = minetest.get_modpath("luxury_decor")

dofile(modpath.."/api/sitting.lua")
dofile(modpath.."/materials.lua")
dofile(modpath.."/kitchen_furniture.lua")
dofile(modpath.."/lighting.lua")
