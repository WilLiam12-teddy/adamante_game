-- List of Nodes to remove
local old_nodes = { --- farming_plus:strawberry
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
				
				--- Dmobs
				--"dmobs:hive",
				
				-- Bees
				"bees:hive_wild",

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

                -- Bamboo
                "bamboo:bamboo"
}

-- List of Entities (like mobs)
local old_entities = {
				"dmobs:dragon",
				"dmobs:pig",
				"dmobs:wasp",
				"dmobs:panda",
				"dmobs:nyan",
				"dmobs:treeman"
}

-- Mark all found Nodes to remove with the Group old.
for _,node_name in ipairs(old_nodes) do
    minetest.register_node(":"..node_name, {
        groups = {old=1},
    })
end

-- Set the active block modifier to give the nodes with
-- the group old in it, the command to remove himself.
minetest.register_abm({
    nodenames = {"group:old"},
    interval = 2,
    chance = 2,
    action = function(pos, node)
        minetest.env:remove_node(pos)
    end,
})

-- Remove all found Entities
for _,entity_name in ipairs(old_entities) do
    minetest.register_entity(":"..entity_name, {
        on_activate = function(self, staticdata)
            self.object:remove()
        end,
    })
end
