local modpath = minetest.get_modpath(minetest.get_current_modname())
local modname = minetest.get_current_modname()
local S

if(minetest.get_modpath("intllib")) then
    S = dofile(modpath .."/intllib.lua")
    print("[MOD] " .. modname .. ": translating in intllib-mode.")

else
    S = minetest.get_translator("food_extend")
    print("[MOD] " .. modname .. ": translating in minetest-mode.")

end -- if(minetest.get_modpath(

if minetest.get_modpath("food_sweet") then
    
    -- Ice
    food.module("ice_bowl", function()
        minetest.register_craftitem(":food_sweet:ice_bowl",{
            description = S("Ice-Bowl"),
            inventory_image = "food_ice_ice_bowl.png",
            groups = {food_bowl=1, food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_bowl",
            recipe = {
                {"default:clay_lump","default:snow","default:clay_lump"},
                {"","default:clay_lump",""}
            }
        })
    end)

    food.module("food_wafer", function()
        minetest.register_craftitem(":food:food_wafer", {
            description = S("Wafer"),
            inventory_image = "food_ice_ice_wafer.png",
            on_use = food.item_eat(2),
            groups = {food_wafer=1, food_ice=1}
        })
        food.craft({
            output = "food:food_wafer",
            recipe = {
                {"group:food_flour","group:food_sugar","group:food_flour"},
                {"","group:food_flour",""},
            }
        })
    end)

    food.module("ice_ball_chocolate",function()
        minetest.register_craftitem(":food_sweet:ice_ball_chocolate", {
            description = S("Iceball Chocolate"),
            inventory_image = "food_ice_ice_ball_chocolate.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_ball_chocolate",
            recipe = {
                {"default:snow"},
                {"group:food_milk_chocolate"}
            }
        })
    end)

    food.module("ice_ball_blueberry",function()
        minetest.register_craftitem(":food_sweet:ice_ball_blueberry", {
            description = S("Iceball Blueberry"),
            inventory_image = "food_ice_ice_ball_blueberry.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_ball_blueberry",
            recipe = {
                {"default:snow"},
                {"group:food_blueberry"}
            }
        })
    end)

    food.module("ice_ball_blackberry",function()
        minetest.register_craftitem(":food_sweet:ice_ball_blackberry", {
            description = S("Iceball Blackberry"),
            inventory_image = "food_ice_ice_ball_blackberry.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_ball_blackberry",
            recipe = {
                {"default:snow"},
                {"group:food_blackberry"}
            }
        })
    end)

    food.module("ice_ball_strawberry",function()
        minetest.register_craftitem(":food_sweet:ice_ball_strawberry", {
            description = S("Iceball Strawberry"),
            inventory_image = "food_ice_ice_ball_strawberry.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_ball_strawberry",
            recipe = {
                {"default:snow"},
                {"group:food_strawberry"}
            }
        })
    end)

    food.module("ice_ball_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_ball_vanilla", {
            description = S("Iceball Vanilla"),
            inventory_image = "food_ice_ice_ball_vanilla.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_ball_vanilla",
            recipe = {
                {"default:snow","",""},
                {"group:food_milk","group:food_butter",""},
                {"group:food_sugar","",""}
            }
        })
    end)

    food.module("ice_ball_pistachio",function()
        minetest.register_craftitem(":food_sweet:ice_ball_pistachio", {
            description = S("Iceball Pistachio"),
            inventory_image = "food_ice_ice_ball_pistachio.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_ball_pistachio",
            recipe = {
                {"default:snow"},
                {"default:papyrus"}
            }
        })
    end)

    food.module("ice_cream_pistachio_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_cream_pistachio_vanilla", {
            description = S("Icecream Pistachio Vanilla"),
            inventory_image = "food_ice_ice_cream_pistachio_vanilla.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cream_pistachio_vanilla",
            recipe = {
                {"default:snow","group:food_milk"},
                {"default:papyrus","group:food_butter"}
            }
        })
    end)

    food.module("ice_cream_strawberry_raspberry",function()
        minetest.register_craftitem(":food_sweet:ice_cream_strawberry_raspberry", {
            description = S("Icecream Strawberry Raspberry"),
            inventory_image = "food_ice_ice_cream_strawberry_raspberry.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cream_strawberry_raspberry",
            recipe = {
                {"default:snow","group:food_milk"},
                {"group:food_strawberry","group:food_raspberry"}
            }
        })
    end)

    food.module("ice_cream_blueberry_raspberry",function()
        minetest.register_craftitem(":food_sweet:ice_cream_blueberry_raspberry", {
            description = S("Icecream Blueberry Raspberry"),
            inventory_image = "food_ice_ice_cream_blueberry_raspberry.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cream_blueberry_raspberry",
            recipe = {
                {"default:snow","group:food_milk"},
                {"group:food_blueberry","group:food_raspberry"}
            }
        })
    end)

    food.module("ice_cream_blueberry_lemon",function()
        minetest.register_craftitem(":food_sweet:ice_cream_blueberry_lemon", {
            description = S("Icecream Blueberry Lemon"),
            inventory_image = "food_ice_ice_cream_blueberry_lemon.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cream_blueberry_lemon",
            recipe = {
                {"default:snow","group:food_milk"},
                {"group:food_blueberry","group:food_lemon"}
            }
        })
    end)

    food.module("ice_cream_blackberry_lemon",function()
        minetest.register_craftitem(":food_sweet:ice_cream_blackberry_lemon", {
            description = S("Icecream Blackberry Lemon"),
            inventory_image = "food_ice_ice_cream_blackberry_lemon.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cream_blackberry_lemon",
            recipe = {
                {"default:snow","group:food_milk"},
                {"group:food_blackberry","group:food_lemon"}
            }
        })
    end)

    food.module("ice_cream_walnut_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_cream_walnut_vanilla", {
            description = S("Icecream Walnut Vanilla"),
            inventory_image = "food_ice_ice_cream_walnut_vanilla.png",
            on_use = food.item_eat(1),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cream_walnut_vanilla",
            recipe = {
                {"default:snow","group:food_milk"},
                {"group:food_walnut","group:food_butter"}
            }
        })
    end)

    food.module("ice_wafer_blackberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_blackberry", {
            description = S("Icewafer Blackberry"),
            inventory_image = "food_ice_ice_wafer_blackberry.png",
            on_use = food.item_eat(2),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_blackberry",
            recipe = {
                {"food_sweet:ice_ball_blackberry"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafer_blueberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_blueberry", {
            description = S("Icewafer Blueberry"),
            inventory_image = "food_ice_ice_wafer_blueberry.png",
            on_use = food.item_eat(2),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_blueberry",
            recipe = {
                {"food_sweet:ice_ball_blueberry"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafer_chocolate",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_chocolate", {
            description = S("Icewafer Chocolate"),
            inventory_image = "food_ice_ice_wafer_chocolate.png",
            on_use = food.item_eat(2),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_chocolate",
            recipe = {
                {"food_sweet:ice_ball_chocolate"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafer_strawberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_strawberry", {
            description = S("Icewafer Strawberry"),
            inventory_image = "food_ice_ice_wafer_strawberry.png",
            on_use = food.item_eat(2),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_strawberry",
            recipe = {
                {"food_sweet:ice_ball_strawberry"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafer_pistachio",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_pistachio", {
            description = S("Icewafer Pistachio"),
            inventory_image = "food_ice_ice_wafer_pistachio.png",
            on_use = food.item_eat(2),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_pistachio",
            recipe = {
                {"food_sweet:ice_ball_pistachio"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafer_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_vanilla", {
            description = S("Icewafer Vanilla"),
            inventory_image = "food_ice_ice_wafer_vanilla.png",
            on_use = food.item_eat(2),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_vanilla",
            recipe = {
                {"food_sweet:ice_ball_vanilla"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafer_blackberry_pistachio",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_blackberry_pistachio", {
            description = S("Icewafer Blackberry Pistachio"),
            inventory_image = "food_ice_ice_wafer_blackberry_pistachio.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_blackberry_pistachio",
            recipe = {
                {"food_sweet:ice_ball_blackberry","food_sweet:ice_ball_pistachio"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_blackberry_strawberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_blackberry_strawberry", {
            description = S("Icewafer Blackberry Strawberry"),
            inventory_image = "food_ice_ice_wafer_blackberry_strawberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_blackberry_strawberry",
            recipe = {
                {"food_sweet:ice_ball_blackberry","food_sweet:ice_ball_strawberry"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_blueberry_chocolate",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_blueberry_chocolate", {
            description = S("Icewafer Blueberry Chocolate"),
            inventory_image = "food_ice_ice_wafer_blueberry_chocolate.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_blueberry_chocolate",
            recipe = {
                {"food_sweet:ice_ball_blueberry","food_sweet:ice_ball_chocolate"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_blueberry_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_blueberry_vanilla", {
            description = S("Icewafer Blueberry Vanilla"),
            inventory_image = "food_ice_ice_wafer_blueberry_vanilla.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_blueberry_vanilla",
            recipe = {
                {"food_sweet:ice_ball_blueberry","food_sweet:ice_ball_vanilla"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_chocolate_strawberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_chocolate_strawberry", {
            description = S("Icewafer Chocolate Strawberry"),
            inventory_image = "food_ice_ice_wafer_chocolate_strawberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_chocolate_strawberry",
            recipe = {
                {"food_sweet:ice_ball_chocolate","food_sweet:ice_ball_strawberry"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_pistachio_blackberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_pistachio_blackberry", {
            description = S("Icewafer Pistachio Blackberry"),
            inventory_image = "food_ice_ice_wafer_pistachio_blackberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_pistachio_blackberry",
            recipe = {
                {"food_sweet:ice_ball_pistachio","food_sweet:ice_ball_blackberry"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_pistachio_blueberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_pistachio_blueberry", {
            description = S("Icewafer Pistachio Blueberry"),
            inventory_image = "food_ice_ice_wafer_pistachio_blueberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_pistachio_blueberry",
            recipe = {
                {"food_sweet:ice_ball_pistachio","food_sweet:ice_ball_blueberry"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_strawberry_blueberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_strawberry_blueberry", {
            description = S("Icewafer Strawberry Blueberry"),
            inventory_image = "food_ice_ice_wafer_strawberry_blueberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_strawberry_blueberry",
            recipe = {
                {"food_sweet:ice_ball_strawberry","food_sweet:ice_ball_blueberry"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_strawberry_pistachio",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_strawberry_pistachio", {
            description = S("Icewafer Strawberry Pistachio"),
            inventory_image = "food_ice_ice_wafer_strawberry_pistachio.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_strawberry_pistachio",
            recipe = {
                {"food_sweet:ice_ball_strawberry","food_sweet:ice_ball_pistachio"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_strawberry_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_strawberry_vanilla", {
            description = S("Icewafer Strawberry Vanilla"),
            inventory_image = "food_ice_ice_wafer_strawberry_vanilla.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_strawberry_vanilla",
            recipe = {
                {"food_sweet:ice_ball_strawberry","food_sweet:ice_ball_vanilla"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_vanilla_blackberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_vanilla_blackberry", {
            description = S("Icewafer Vanilla Blackberry"),
            inventory_image = "food_ice_ice_wafer_vanilla_blackberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_vanilla_blackberry",
            recipe = {
                {"food_sweet:ice_ball_vanilla","food_sweet:ice_ball_blackberry"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafer_vanilla_pistachio",function()
        minetest.register_craftitem(":food_sweet:ice_wafer_vanilla_pistachio", {
            description = S("Icewafer Vanilla Pistachio"),
            inventory_image = "food_ice_ice_wafer_vanilla_pistachio.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafer_vanilla_pistachio",
            recipe = {
                {"food_sweet:ice_ball_vanilla","food_sweet:ice_ball_pistachio"},
                {"group:food_wafer",""}
            }
        })
    end)

    food.module("ice_wafercream_blackberry_lemon",function()
        minetest.register_craftitem(":food_sweet:ice_wafercream_blackberry_lemon", {
            description = S("Icewafercream Blackberry Lemon"),
            inventory_image = "food_ice_ice_wafercream_blackberry_lemon.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafercream_blackberry_lemon",
            recipe = {
                {"food_sweet:ice_cream_blackberry_lemon"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafercream_blueberry_raspberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafercream_blueberry_raspberry", {
            description = S("Icewafercream Blueberry Raspberry"),
            inventory_image = "food_ice_ice_wafercream_blueberry_raspberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafercream_blueberry_raspberry",
            recipe = {
                {"food_sweet:ice_cream_blueberry_raspberry"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafercream_pistachio_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_wafercream_pistachio_vanilla", {
            description = S("Icewafercream Pistachio Vanilla"),
            inventory_image = "food_ice_ice_wafercream_pistachio_vanilla.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafercream_pistachio_vanilla",
            recipe = {
                {"food_sweet:ice_cream_pistachio_vanilla"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafercream_strawberry_raspberry",function()
        minetest.register_craftitem(":food_sweet:ice_wafercream_strawberry_raspberry", {
            description = S("Icewafercream Strawberry Raspberry"),
            inventory_image = "food_ice_ice_wafercream_strawberry_raspberry.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafercream_strawberry_raspberry",
            recipe = {
                {"food_sweet:ice_cream_strawberry_raspberry"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafercream_walnut_vanilla",function()
        minetest.register_craftitem(":food_sweet:ice_wafercream_walnut_vanilla", {
            description = S("Icewafercream Walnut Vanilla"),
            inventory_image = "food_ice_ice_wafercream_walnut_vanilla.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafercream_walnut_vanilla",
            recipe = {
                {"food_sweet:ice_cream_walnut_vanilla"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_wafercream_blueberry_lemon",function()
        minetest.register_craftitem(":food_sweet:ice_wafercream_blueberry_lemon", {
            description = S("Icewafercream Blueberry Lemon"),
            inventory_image = "food_ice_ice_wafercream_blueberry_lemon.png",
            on_use = food.item_eat(3),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_wafercream_blueberry_lemon",
            recipe = {
                {"food_sweet:ice_cream_blueberry_lemon"},
                {"group:food_wafer"}
            }
        })
    end)

    food.module("ice_cup_french",function()
        minetest.register_craftitem(":food_sweet:ice_cup_french", {
            description = S("Icecup French"),
            inventory_image = "food_ice_ice_cup_french.png",
            on_use = food.item_eat(4),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cup_french",
            recipe = {
                {"food_sweet:ice_cream_blackberry_lemon","food_sweet:ice_cream_walnut_vanilla","food_sweet:ice_cream_blueberry_raspberry"},
                {"","group:food_bowl",""}
            }
        })
    end)

    food.module("ice_cup_america",function()
        minetest.register_craftitem(":food_sweet:ice_cup_america", {
            description = S("Icecup America"),
            inventory_image = "food_ice_ice_cup_america.png",
            on_use = food.item_eat(4),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cup_america",
            recipe = {
                {"food_sweet:ice_cream_blackberry_lemon","food_sweet:ice_cream_blueberry_raspberry","food_sweet:ice_cream_pistachio_vanilla"},
                {"","group:food_bowl",""}
            }
        })
    end)

    food.module("ice_cup_german",function()
        minetest.register_craftitem(":food_sweet:ice_cup_german", {
            description = S("Icecup German"),
            inventory_image = "food_ice_ice_cup_german.png",
            on_use = food.item_eat(4),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cup_german",
            recipe = {
                {"food_sweet:ice_cream_walnut_vanilla","food_sweet:ice_cream_blueberry_lemon","food_sweet:ice_cream_blackberry_lemon"},
                {"","group:food_bowl",""}
            }
        })
    end)

    food.module("ice_cup_new_zealand",function()
        minetest.register_craftitem(":food_sweet:ice_cup_new_zealand", {
            description = S("Icecup New Zealand"),
            inventory_image = "food_ice_ice_cup_new_zealand.png",
            on_use = food.item_eat(4),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cup_new_zealand",
            recipe = {
                {"food_sweet:ice_cream_pistachio_vanilla","food_sweet:ice_cream_strawberry_raspberry","food_sweet:ice_cream_blueberry_lemon"},
                {"","group:food_bowl",""}
            }
        })
    end)

    food.module("ice_cup_england",function()
        minetest.register_craftitem(":food_sweet:ice_cup_england", {
            description = S("Icecup England"),
            inventory_image = "food_ice_ice_cup_england.png",
            on_use = food.item_eat(4),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cup_england",
            recipe = {
                {"food_sweet:ice_cream_blueberry_raspberry","food_sweet:ice_cream_blackberry_lemon","food_sweet:ice_cream_strawberry_raspberry"},
                {"","group:food_bowl",""}
            }
        })
    end)

    food.module("ice_cup_japan",function()
        minetest.register_craftitem(":food_sweet:ice_cup_japan", {
            description = S("Icecup Japan"),
            inventory_image = "food_ice_ice_cup_japan.png",
            on_use = food.item_eat(4),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cup_japan",
            recipe = {
                {"food_sweet:ice_cream_blueberry_lemon","food_sweet:ice_cream_strawberry_raspberry","food_sweet:ice_cream_walnut_vanilla"},
                {"","group:food_bowl",""}
            }
        })
    end)

    food.module("ice_cup_zaire",function()
        minetest.register_craftitem(":food_sweet:ice_cup_zaire", {
            description = S("Icecup Zaire"),
            inventory_image = "food_ice_ice_cup_zaire.png",
            on_use = food.item_eat(4),
            groups = {food_ice = 1}
        })
        food.craft({
            output = "food_sweet:ice_cup_zaire",
            recipe = {
                {"food_sweet:ice_cream_strawberry_raspberry","food_sweet:ice_cream_pistachio_vanilla","food_sweet:ice_cream_blueberry_lemon"},
                {"","group:food_bowl",""}
            }
        })
    end)
    
    print("[MOD] " .. minetest.get_current_modname() .. "successfully loaded.")
    
else -- if(minetest.get_modpath
           
    print("[MOD] " .. minetest.get_current_modname() .. "not loaded. Missing mod food_sweet!")

end
          
    
