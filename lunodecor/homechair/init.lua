local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/api.lua")

modHomeChair.register_chair("wood", "Cadeira de Madeira")

modHomeChair.register_chair("black"			, "Cadeira Preta" 			, {"preta"})
modHomeChair.register_chair("red"			, "Cadeira Vermelha" 		, {"vermelha", "rubra", "escarlate"})
modHomeChair.register_chair("pink"			, "Cadeira Rosa" 				, {"rosa"})
modHomeChair.register_chair("violet"		, "Cadeira Purpura" 			, {"violeta","roxa","purpura"})
modHomeChair.register_chair("blue"			, "Cadeira Azul" 				, {"azul"})
modHomeChair.register_chair("dark_green"	, "Cadeira Cinza Escura"	, {"cinza", "cinzaescura"})

minetest.log('action',"["..modname:upper().."] Carregado!")
