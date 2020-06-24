-- Adds a lbm (load block modifer) to all found blocks,
-- to replace themself to air:air.

minetest.register_lbm({
    name = ":lbm2",
    nodenames = { 
            
            --- farming_plus:strawberry
            "farming_plus:strawberry", 
            "farming_plus:strawberry_1", 
            "farming_plus:strawberry_2", 
            "farming_plus:strawberry_3", 
            "farming_plus:strawberry_4", 
            "farming_plus:strawberry_5", 
            "farming_plus:strawberry_6",
				
            --- farming_plus:raspberry
            "farming_plus:raspberry", 
            "farming_plus:raspberry_1", 
            "farming_plus:raspberry_2", 
            "farming_plus:raspberry_3", 
            "farming_plus:raspberry_4", 
            "farming_plus:raspberry_5", 
            "farming_plus:raspberry_6",

            --- farming:blueberry
            "farming:blueberry",
            "farming:blueberry_1", 
            "farming:blueberry_2",
            "farming:blueberry_3",
            "farming:blueberry_4",

            --- farming_plus:strawberry
            "farming:strawberry", 
            "farming:strawberry_1", 
            "farming:strawberry_2", 
            "farming:strawberry_3", 
            "farming:strawberry_4", 
            "farming:strawberry_5", 
            "farming:strawberry_6",
				
            --- farming_plus:raspberry
            "farming:raspberry", 
            "farming:raspberry_1", 
            "farming:raspberry_2", 
            "farming:raspberry_3", 
            "farming:raspberry_4", 
            "farming:raspberry_5", 
            "farming:raspberry_6",
				
            -- Bees
            --"bees:hive_wild",

            -- vines
            "vines:side_middle",
            "vines:side_end",
            "vines:willow_middle",
            "vines:willow_end",
            "vines:jungle_middle",
            "vines:jungle_end",
            "vines:vine_middle",
            "vines:vine_end",
            "vines:root_middle",
            "vines:root_end",

            -- bamboo
            "bamboo:bamboo"
                    
	},
       -- you can add as many entries you need
       action = function(pos)
          minetest.set_node(pos, {name = "air:air"}) -- replacer node name
       end,
})

