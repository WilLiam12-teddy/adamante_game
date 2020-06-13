--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Protetor
	
  ]]

-- Proteger uma area
taverna_barbara.proteger_area = function(PlayerName, AreaName, pos1, pos2, silencio)
	
	local id = areas:add(PlayerName, AreaName, pos1, pos2, nil)
	areas:save()
	
	return true
end
