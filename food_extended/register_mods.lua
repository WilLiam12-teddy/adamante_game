local food_items = {}

    food_items = {
                --                    Name                          Saturation      Replace with                Poison  Heal    Sound
                {'food_extend:rujak',                               6,              'cucina_vegana:bowl',       nil,    nil,    nil},
                {'food_extend:gingerbread_sam',                     4,              nil,                        nil,    nil,    nil},
                {'food_extend:tofufruitcreme',                      3,              'cucina_vegana:bowl',       nil,    nil,    nil},
                {'food_extend:rice_grapes_plate',                   6,              'cucina_vegana:plate',      nil,    nil,    nil},
                {'food_extend:fruitcoleslaw',                       5,              'cucina_vegana:bowl',       nil,    nil,    nil},
                {'food_extend:tofu_cutlet',                         7,              'cucina_vegana:plate',      nil,    2,      nil},
                {'food_extend:cucumber_noodles_with_peanutbutter',  8,              'cucina_vegana:bowl',       nil,    2,      nil},
                {'food_extend:apple_peanutbutter_muffin',           5,              nil,                        nil,    nil,    nil},        
        } -- food_items

--   *******************************************
--   *****           Technic-Support       ***** 
--   *******************************************

if(minetest.get_modpath("technic")) then


end -- if(minetest.get_modpath("technic"

--   *******************************************
--   *****           Hunger-Support        ***** 
--   *******************************************

if(minetest.get_modpath("hunger")) then
    for key, item in pairs(food_items) do
        hunger.register_food(item)
        
    end -- for key, data
    
end -- hunger

--   *******************************************
--   *****           Diet-Support          ***** 
--   *******************************************

if(minetest.get_modpath("diet")) then
    
    local function overwrite(name, hunger_change, replace_with_item, poisen, heal)
        local tab = minetest.registered_items[name]
        if not tab then
            return
        end
        tab.on_use = diet.item_eat(hunger_change, replace_with_item, poisen, heal)
    end -- local function overwrite
    
    for key,item in pairs(food_items) do
        overwrite(item[1], item[2], item[3], item[4], item[5])
        
    end -- for key,item
        
end -- if(minetest.get_modpath("diet

--   **********************************************
--   *****           Hunger_ng-Support        *****
--   **********************************************

if(minetest.get_modpath("hunger_ng")) then
    local add = hunger_ng.add_hunger_data

    for key, item in pairs(food_items) do
        add(item[1], {satiates = item[2], returns = item[3], heals = math.floor((item[5] or 0)), timeout = 0})

    end -- for key, data

end -- hunger_ng
