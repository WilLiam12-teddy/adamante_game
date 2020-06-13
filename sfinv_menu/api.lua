--[[
	Mod Sfinv_menu for Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	You have received a copy of the GNU Lesser 
	General Public License with this software,
	if not, see <http://www.gnu.org/licenses/>. 
	
	API
  ]]

-- String translator
local S = sfinv_menu.S

-- Registered button table
sfinv_menu.registered_button = {}

-- Number of registered button
sfinv_menu.n_registered_button = 0

-- Register tab in sfinv
local sfinv_tab_created = false

-- Formspec buttons table
local formspec_buttons = {
	{"image[0,0;1,1;", "]button[1,0;3,1;", ";", "]"},
	{"image[0,1;1,1;", "]button[1,1;3,1;", ";", "]"},
	{"image[0,2;1,1;", "]button[1,2;3,1;", ";", "]"},
	{"image[0,3;1,1;", "]button[1,3;3,1;", ";", "]"},
	{"image[4,0;1,1;", "]button[5,0;3,1;", ";", "]"},
	{"image[4,1;1,1;", "]button[5,1;3,1;", ";", "]"},
	{"image[4,2;1,1;", "]button[5,2;3,1;", ";", "]"},
	{"image[4,3;1,1;", "]button[5,3;3,1;", ";", "]"}
}

-- Register button
sfinv_menu.register_button = function(id, def)
	
	
	-- Check if you have already reached the button limit
	if sfinv_menu.n_registered_button + 1 > 8 then
		minetest.log("error", "[Sfinv_menu] Error on register '"..id.."'. Already reached the button limit (8 buttons).")
		local i = 1
		for idd,def in pairs(sfinv_menu.registered_button) do
			minetest.log("error", i.." - "..idd)
			i = i + 1
		end
		return false
	end
	
	sfinv_menu.registered_button[id] = def
	sfinv_menu.n_registered_button = sfinv_menu.n_registered_button + 1
	
	-- Check if sfinv_tab is registered
	if sfinv_tab_created == false then
		sfinv_tab_created = true
		
		sfinv.register_page("sfinv_menu:more", {
			title = S("Mais"),
			get = function(self, player, context)
				
				-- Make button list
				local formspec = ""
				local i = 1
				for id,def in pairs(sfinv_menu.registered_button) do
					-- check privs
					if minetest.check_player_privs(player:get_player_name(), def.privs or {}) == true then
						local f = formspec_buttons[i]
						formspec = formspec .. f[1] .. def.icon .. f[2] .. id .. f[3] .. def.title .. f[4]
						i = i + 1
					end
				end
				
				return sfinv.make_formspec(player, context, 
					formspec
					.."listring[current_player;main]"
					.."listring[current_player;craft]"
					.."image[0,4.75;1,1;gui_hb_bg.png]"
					.."image[1,4.75;1,1;gui_hb_bg.png]"
					.."image[2,4.75;1,1;gui_hb_bg.png]"
					.."image[3,4.75;1,1;gui_hb_bg.png]"
					.."image[4,4.75;1,1;gui_hb_bg.png]"
					.."image[5,4.75;1,1;gui_hb_bg.png]"
					.."image[6,4.75;1,1;gui_hb_bg.png]"
					.."image[7,4.75;1,1;gui_hb_bg.png]", 
				true)
			end,
			on_player_receive_fields = function(self, player, context, fields)
				for f,d in pairs(fields) do
					if sfinv_menu.registered_button[f] then
						sfinv_menu.registered_button[f].func(player)
						return
					end
				end
			end,
		})
	end
	
	return true
end

