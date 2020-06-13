--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Seller node
  ]]

local S = cidades.S

-- Get value to text
local to_text = cidades.exchange.get_value_to_text

-- Access
local seller_access = function(player, pos)
	-- Set pos
	player:set_attribute("cidades:seller_pos", minetest.serialize(pos))
	
	local name = player:get_player_name()
	
	local data = cidades.property.get_data({x=pos.x, y=pos.y-3, z=pos.z})
	local width = (data.radius * 2) + 1
	
	-- Button status
	local text = S("Make sure you can pay.")
	if cidades.db.check_property(name) == true then
		text = minetest.colorize("#ff0707", S("You already own land. Sell it to buy that one."))
	end
	
	minetest.show_formspec(name, "cidades:seller", 
		"size[5,3.5]"
		.."label[0,-0.15;"..S("Land for sale")
		.."\n"..S("Height: @1", data.height)
		.."\n"..S("Width: @1", width)
		.."\n"..S("Total buildable area: @1 blocks", (width*width*(data.height)))
		.."\n"..S("Price: @1", to_text(data.cost))
		.."\n"..S("Sale price: @1", to_text(cidades.get_sale_price(data.cost)))
		.."\n"..text.."]"
		.."button_exit[0,2.85;5,1;buy;"..S("Buy").."]"
	)
	
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "cidades:seller" then
		local name = player:get_player_name()
		local pos = minetest.deserialize(player:get_attribute("cidades:seller_pos"))
		local data = cidades.property.get_data({x=pos.x, y=pos.y-3, z=pos.z})
		
		if fields.buy then
			-- Check property
			if cidades.db.check_property(name) == true then
				return minetest.chat_send_player(name, S("You already own land. Sell it to buy that one."))
			end
			
			-- Check payment
			if cidades.exchange.has_payment(player, data.cost) == false then
				minetest.chat_send_player(name, S("Insufficient payment."))
				return 
			end
			
			-- Get payment
			cidades.exchange.take(player, data.cost)
			minetest.remove_node(pos)
			
			cidades.set_owner(player, {x=pos.x, y=pos.y-3, z=pos.z}, data)
			
			minetest.chat_send_player(name, S("Land purchased."))
		end
	end
end)


-- Cleaning Cycle
local cleaning_cycle = cidades.db.ms:get_float("cleaning_cycle") or 0
-- Execute 'on_clear_objects'
local old_clear = minetest.clear_objects
minetest.clear_objects = function(...)
	cleaning_cycle = cleaning_cycle + 1
	cidades.db.ms:set_float("cleaning_cycle", cleaning_cycle)
	return old_clear(...)
end

-- Seller icon
minetest.register_craftitem("cidades:seller_icon", {
	description = "Seller Icon",
	inventory_image = "cidades_seller_icon.png",
	groups = {not_in_creative_inventory = 1},
})

-- Seller entity
minetest.register_entity("cidades:seller", {
	visual = "wielditem",
	visual_size = {x=1*0.5,y=3*0.5},
	textures = {"cidades:seller_icon"},
	collisionbox = {0,0,0, 0,0,0},
	automatic_rotate = 1,
	on_activate = function(self)
		local pos = self.object:get_pos()
		if minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ~= "cidades:seller" then
			self.object:remove()
		end
	end,
})
minetest.register_abm{
        label = "check seller icon",
	nodenames = {"cidades:seller"},
	interval = 300,
	chance = 1,
	action = function(pos)
		if minetest.get_meta(pos):get_float("cleaning_cycle") ~= cleaning_cycle then
			minetest.get_meta(pos):set_float("cleaning_cycle", cleaning_cycle)
			minetest.add_entity({x=pos.x, y=pos.y+1, z=pos.z}, "cidades:seller")
		end
	end,
}


-- Seller node
minetest.register_node("cidades:seller", {
	description = "Seller",
	drawtype = "airlike",
	collisionbox = {-0.4,-0.4,-0.4, 0.4,0.4,0.4},
	is_ground_content = false,
	drop = "",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
	
	on_construct = function(pos)
		minetest.get_meta(pos):set_float("cleaning_cycle", cleaning_cycle)
		minetest.add_entity({x=pos.x, y=pos.y+1, z=pos.z}, "cidades:seller")
	end,
	on_destruct = function(pos)
		for _, obj in pairs(minetest.get_objects_inside_radius({x=pos.x, y=pos.y+1, z=pos.z}, 0.9)) do
			if obj 
				and obj:get_luaentity() 
				and obj:get_luaentity().name == "cidades:seller" 
			then
				obj:remove()
				break
			end
		end
	end,
	
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		seller_access(clicker, pos)
	end,
})
