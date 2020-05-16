local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_tree = minetest.get_content_id("love_mod:tree")
local c_ltree = minetest.get_content_id("love_mod:tree_heart")
local c_fruit = minetest.get_content_id("love_mod:heart_food")

function love_mod.grow_tree(data, a, pos, c_leaves)

        local th = math.random(4, 6)
        local x, y, z = pos.x, pos.y, pos.z
        for yy = y, y+th-1 do
                local vi = a:index(x, yy, z)
                if a:contains(x, yy, z) and (data[vi] == c_air or yy == y) then
                        data[vi] = c_tree
                end
        end

        local vil = a:index(x, y+1, z)
        if a:contains(x, y+1, z) and (data[vil] == c_tree ) then
                data[vil] = c_ltree
        end


        y = y+th-1 -- (x, y, z) is now last piece of trunk
        local leaves_a = VoxelArea:new{MinEdge={x=-2, y=-1, z=-2}, MaxEdge={x=2, y=2, z=2}}
        local leaves_buffer = {}
        
        -- Force leaves near the trunk
        local d = 1
        for xi = -d, d do
        for yi = -d, d do
        for zi = -d, d do
                leaves_buffer[leaves_a:index(xi, yi, zi)] = true
        end
        end
        end
        
        -- Add leaves randomly
        for iii = 1, 12 do
                local d = 1
                local xx = math.random(leaves_a.MinEdge.x, leaves_a.MaxEdge.x - d)
                local yy = math.random(leaves_a.MinEdge.y, leaves_a.MaxEdge.y - d)
                local zz = math.random(leaves_a.MinEdge.z, leaves_a.MaxEdge.z - d)
                
                for xi = 0, d do
                for yi = 0, d do
                for zi = 0, d do
                        leaves_buffer[leaves_a:index(xx+xi, yy+yi, zz+zi)] = true
                end
                end
                end
        end
        
        -- Add the leaves
        for xi = leaves_a.MinEdge.x, leaves_a.MaxEdge.x do
        for yi = leaves_a.MinEdge.y, leaves_a.MaxEdge.y do
        for zi = leaves_a.MinEdge.z, leaves_a.MaxEdge.z do
                if a:contains(x+xi, y+yi, z+zi) then
                        local vi = a:index(x+xi, y+yi, z+zi)
                        if data[vi] == c_air or data[vi] == c_ignore then
                                if leaves_buffer[leaves_a:index(xi, yi, zi)] then
                                        if math.random(1, 100) <=  35 then
                                                data[vi] = c_fruit
                                        else
                                                data[vi] = c_leaves
                                        end
                                end
                        end
                end
        end
        end
        end
end

minetest.register_abm({
        nodenames = {"love_mod:sapling"},
        interval = 5,
        chance = 10,
        action = function(pos, node)
                local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
                local is_soil = minetest.get_item_group(nu, "soil")
                local is_sand = minetest.get_item_group(nu, "sand")
                if is_soil ~= 0 then
                        minetest.log("action", "A Love tree grows @"..minetest.pos_to_string(pos))
                        local vm = minetest.get_voxel_manip()
                        local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
                        local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
                        local data = vm:get_data()
                        love_mod.grow_tree(data, a, pos, minetest.get_content_id("love_mod:leaves"))
                        vm:set_data(data)
                        vm:write_to_map(data)
                        vm:update_map()
                elseif is_sand ~= 0 then
                        minetest.log("action", "A Love tree grows @"..minetest.pos_to_string(pos))
                        local vm = minetest.get_voxel_manip()
                        local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
                        local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
                        local data = vm:get_data()
                        love_mod.grow_tree(data, a, pos, minetest.get_content_id("love_mod:jungleleaves"))
                        vm:set_data(data)
                        vm:write_to_map(data)
                        vm:update_map()
                end

        end
})