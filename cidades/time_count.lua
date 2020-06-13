--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Time count
  ]]

local days_until_month = {
	31, -- month 1
	59, -- month 2
	90, -- month 3
	120,-- ...
	151,
	181,
	212,
	243,
	273,
	304,
	334,
	365
}

-- Get date hash
cidades.get_date_hash = function()
	local years = tonumber(os.date("%Y")) -2000 -1
	local months = tonumber(os.date("%m")) -1
	local days = tonumber(os.date("%d")) -1
	
	local hash = years*365 + days_until_month[months] + days
	
	return hash
end
