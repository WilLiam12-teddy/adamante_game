--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Exchange
  ]]

local S = cidades.S

-- Exchange methods
cidades.exchange = {}

-- Get value to text
cidades.exchange.get_value_to_text = function(value)
	return value
end

-- Take 
cidades.exchange.take = function(player, count)
	player:get_inventory():remove_item("main", cidades.money_item.." "..count)
end

 -- Check take
cidades.exchange.check_take = function(player, count)
	if player:get_inventory():contains_item("main", cidades.money_item.." "..count) == false then
		 minetest.chat_send_player(player:get_player_name(), S("You can not pay that."))
		 return false
	end
	return true
end

-- Give 
cidades.exchange.give = function(player, count)

	local leftover = player:get_inventory():add_item("main", cidades.money_item.." "..count)
	
	-- Drop leftover
	if leftover ~= true then
		local pos = player:get_pos()
		minetest.item_drop(leftover, player, {x=pos.x, y=pos.y+1, z=pos.z})
		minetest.chat_send_player(player:get_player_name(), S("Crowded inventory. Leftovers were dropped."))
	end
end

-- Use macromoney methods
if macromoney and cidades.money_item == "macromoney:macro" then
	
	-- Get value to text
	cidades.exchange.get_value_to_text = function(value)
		return macromoney.get_value_to_text("money", value)
	end
	
	-- Take 
	cidades.exchange.take = function(player, count)
		macromoney.subtract_account(player:get_player_name(), "money", count)
	end

	 -- Check take
	cidades.exchange.has_payment = function(player, count)
		return macromoney.get_account(player:get_player_name(), "money") >= count
	end

	-- Give 
	cidades.exchange.give = function(player, count)
		macromoney.add_account(player:get_player_name(), "money", count)
	end

end





