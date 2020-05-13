minetest.register_privilege("spill", {description = "You can spill...", give_to_singleplayer=false})



local nothing = minetest.registered_items["bucket:bucket_lava"].on_place
minetest.override_item("bucket:bucket_lava", {
	on_place = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
            minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
			return itemstack
		else
			return nothing(itemstack, placer, pointed_thing)
		end
	end,
})

local nothing = minetest.registered_items["bucket:bucket_river_water"].on_place
minetest.override_item("bucket:bucket_river_water", {
	on_place = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
            minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
			return itemstack
		else
			return nothing(itemstack, placer, pointed_thing)
		end
	end,
})

local nothing = minetest.registered_items["bucket:bucket_water"].on_place
minetest.override_item("bucket:bucket_water", {
	on_place = function(itemstack, placer, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
            minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
			return itemstack
		else
			return nothing(itemstack, placer, pointed_thing)
		end
	end,
})

if minetest.get_modpath("at_candy") then
    local nothing = minetest.registered_items["at_candy:chocolate_source"].on_place
    minetest.override_item("at_candy:chocolate_source", {
        on_place = function(itemstack, placer, pointed_thing)
            if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
                return itemstack
            else
                return nothing(itemstack, placer, pointed_thing)
            end
        end,
    })
end

if minetest.get_modpath("at_breakfast") then
    local nothing = minetest.registered_items["at_breakfast:coffee_source"].on_place
    minetest.override_item("at_breakfast:coffee_source", {
        on_place = function(itemstack, placer, pointed_thing)
            if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
                return itemstack
            else
                return nothing(itemstack, placer, pointed_thing)
            end
        end,
    })
end

if minetest.get_modpath("technic") then
    local nothing = minetest.registered_items["technic:lava_can"].on_place
	minetest.override_item("technic:lava_can", {
		on_place = function(itemstack, placer, pointed_thing)
			if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
				return itemstack
			else
				return nothing(itemstack, placer, pointed_thing)
			end
		end,
	})
    local nothing = minetest.registered_items["technic:water_can"].on_place
	minetest.override_item("technic:water_can", {
		on_place = function(itemstack, placer, pointed_thing)
			if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
				return itemstack
			else
				return nothing(itemstack, placer, pointed_thing)
			end
		end,
	})
    local nothing = minetest.registered_items["technic:bucket_corium"].on_place
	minetest.override_item("technic:bucket_corium", {
		on_place = function(itemstack, placer, pointed_thing)
			if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
				return itemstack
			else
				return nothing(itemstack, placer, pointed_thing)
			end
		end,
	})
    minetest.override_item("technic:corium_source", {
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.remove_node(pos)
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
            end
        end,
    })
end

if minetest.get_modpath("at_candy") then
    minetest.override_item("at_candy:chocolate_source", {
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.remove_node(pos)
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
            end
        end,
    })
end

if minetest.get_modpath("at_breakfast") then
    minetest.override_item("at_breakfast:coffee_source", {
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.remove_node(pos)
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
            end
        end,
    })
end

if minetest.get_modpath("riventest") then
    minetest.override_item("riventest:water_source", {
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
                minetest.remove_node(pos)
                minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
            end
        end,
    })
end

minetest.override_item("default:lava_source", {
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
			minetest.remove_node(pos)
            minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
		end
	end,
})

minetest.override_item("default:water_source", {
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
			minetest.remove_node(pos)
            minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
		end
	end,
})

minetest.override_item("default:river_water_source", {
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if not minetest.check_player_privs(placer:get_player_name(),{spill = true}) then
			minetest.remove_node(pos)
            minetest.chat_send_player(placer:get_player_name(), "You need the SPILL priv to use liquids here")
		end
	end,
})



local function check_protection(pos, name, text)
	if minetest.is_protected(pos, name) then
		minetest.log("action", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a bucket")
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

minetest.override_item("bucket:bucket_empty", {
	description = "Empty Bucket",
	inventory_image = "bucket.png",
	stack_max = 99,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		-- Must be pointing to node
		if pointed_thing.type ~= "node" then
			return
		end
		-- Check if pointing to a liquid source
		local node = minetest.get_node(pointed_thing.under)
		local liquiddef = bucket.liquids[node.name]
		local item_count = user:get_wielded_item():get_count()

		-- lava check
		if node.name == "default:lava_source"  and not minetest.check_player_privs(user:get_player_name(), {spill = true}) then
            minetest.chat_send_player(user:get_player_name(), "You need the SPILL priv to use liquids here")
			return
		end

		-- water check
		if node.name == "default:water_source"  and not minetest.check_player_privs(user:get_player_name(), {spill = true}) then
            minetest.chat_send_player(user:get_player_name(), "You need the SPILL priv to use liquids here")
			return
		end

		-- river_water check
		if node.name == "default:river_water_source"  and not minetest.check_player_privs(user:get_player_name(), {spill = true}) then
            minetest.chat_send_player(user:get_player_name(), "You need the SPILL priv to use liquids here")
			return
		end

		-- river_water check
		if node.name == "at_breakfast:coffee_source"  and not minetest.check_player_privs(user:get_player_name(), {spill = true}) then
            minetest.chat_send_player(user:get_player_name(), "You need the SPILL priv to use liquids here")
			return
		end

		-- river_water check
		if node.name == "at_candy:chocolate_source"  and not minetest.check_player_privs(user:get_player_name(), {spill = true}) then
            minetest.chat_send_player(user:get_player_name(), "You need the SPILL priv to use liquids here")
			return
		end

		if liquiddef ~= nil
		and liquiddef.itemname ~= nil
		and node.name == liquiddef.source then
			if check_protection(pointed_thing.under,
					user:get_player_name(),
					"take ".. node.name) then
				return
			end
			-- default set to return filled bucket
			local giving_back = liquiddef.itemname

			-- check if holding more than 1 empty bucket
			if item_count > 1 then

				-- if space in inventory add filled bucked, otherwise drop as item
				local inv = user:get_inventory()
				if inv:room_for_item("main", {name=liquiddef.itemname}) then
					inv:add_item("main", liquiddef.itemname)
				else
					local pos = user:getpos()
					pos.y = math.floor(pos.y + 0.5)
					core.add_item(pos, liquiddef.itemname)
				end

				-- set to return empty buckets minus 1
				giving_back = "bucket:bucket_empty "..tostring(item_count-1)

			end

			minetest.add_node(pointed_thing.under, {name="air"})

			return ItemStack(giving_back)
		end
	end,
})
