minetest.register_chatcommand("set_global_value", {
	params = "<variavel> <valor>",
	description = "Grava uma variavel no mapa (Necessita de privilegio 'modsavevars').",
	privs = {savevars=true},
	func = function(player, param)
		-- Returns (pos, true) if found, otherwise (pos, false)
		--variavel, valor = string.match(param, "^([^ ]+) +([^ ]+)")
		local variavel, valor = string.match(param, "([%a%d_]+) (.+)")
		if variavel~=nil and variavel~="" and valor~=nil and valor~="" then
			modsavevars.setGlobalValue(variavel, valor)
			minetest.chat_send_player(player, variavel.."='"..valor.."'")
		else
			minetest.chat_send_player(player, "SINTAXE: /set_global_value <variavel> <valor>")
		end
		return
	end,
})

minetest.register_chatcommand("del_global_value", {
	params = "<variavel>",
	description = "Apaga uma variavel no mapa (Necessita de privilegio 'modsavevars').",
	privs = {savevars=true},
	func = function(player, param)
		local variavel = string.match(param, "([%a%d_]+)")
		if variavel~=nil and variavel~="" then
			modsavevars.setGlobalValue(variavel, nil)
			minetest.chat_send_player(player, "Variavel '"..variavel.."' apagada!")
		else
			minetest.chat_send_player(player, "SINTAXE: /del_global_value <variavel>")
		end
		return
	end,
})

minetest.register_chatcommand("get_global_value", {
	params = "<variavel>",
	description = "Exibe o valor de uma variavel do mapa (Necessita de privilegio 'modsavevars').",
	privs = {savevars=true},
	func = function(player, param)
		local variavel = string.match(param, "([%a%d_]+)")
		if variavel~=nil and variavel~="" then
			local valor = modsavevars.getGlobalValue(variavel)
			if valor~=nil then
				minetest.chat_send_player(player, variavel.."="..dump(valor))
			else
				minetest.chat_send_player(player, "Variavel '"..variavel.."' nao foi definida.")
			end
		else
			minetest.chat_send_player(player, "SINTAXE: /get_global_value <variavel>")
		end
		return
	end,
})

minetest.register_chatcommand("set_char_value", {
	params = "<jogador> <variavel> <valor>",
	description = "Grava uma variavel no jogador indicado. (Necessita de privilegio 'modsavevars').",
	privs = {savevars=true},
	func = function(player, param)
		-- Returns (pos, true) if found, otherwise (pos, false)
		--variavel, valor = string.match(param, "^([^ ]+) +([^ ]+)")
		local charName, variavel, valor = string.match(param, "([%a%d_]+) ([%a%d_]+) (.+)")
		if charName~=nil and charName~="" and variavel~=nil and variavel~="" and valor~=nil and valor~="" then
			modsavevars.setCharValue(charName, variavel, valor)
			minetest.chat_send_player(player, charName.."."..variavel.."='"..valor.."'")
		else
			minetest.chat_send_player(player, "SINTAXE: /set_char_value <jogador> <variavel> <valor>")
		end
		return
	end,
})

minetest.register_chatcommand("del_char_value", {
	params = "<jogador> <variavel>",
	description = "Apaga uma variavel no jogador indicado. (Necessita de privilegio 'modsavevars').",
	privs = {savevars=true},
	func = function(player, param)
		local charName, variavel = string.match(param, "([%a%d_]+) ([%a%d_]+)")
		if charName~=nil and charName~="" and variavel~=nil and variavel~="" then
			modsavevars.setCharValue(charName, variavel, nil)
			minetest.chat_send_player(player, charName.."."..variavel.."=nil")
		else
			minetest.chat_send_player(player, "SINTAXE: /del_char_value <jogador> <variavel>")
		end
		return
	end,
})

minetest.register_chatcommand("get_char_value", {
	params = "<jogador> <variavel>",
	description = "Exibe o valor de uma variavel no jogador indicado. (Necessita de privilegio 'modsavevars').",
	privs = {savevars=true},
	func = function(player, param)
		local charName, variavel = string.match(param, "([%a%d_]+) ([%a%d_]+)")
		if charName~=nil and charName~="" and variavel~=nil and variavel~="" then
			local valor = modsavevars.getCharValue(charName, variavel)
			if valor~=nil then
				minetest.chat_send_player(player, charName.."."..variavel.."="..dump(valor))
			else
				minetest.chat_send_player(player, "Variavel '"..charName.."."..variavel.."' nao foi definida.")
			end
		else
			minetest.chat_send_player(player, "SINTAXE: /get_char_value <jogador> <variavel>")
		end
		return
	end,
})

minetest.register_chatcommand("lib_savevars", {
	params = "",
	description = "Exibe todos os comando deste mod",
	privs = {},
	func = function(playername, param)
		minetest.chat_send_player(playername, "    ", false)
		minetest.chat_send_player(playername, "############################################################################################", false)
		minetest.chat_send_player(playername, "### LIB_SAVEVARS (TELA DE AJUDA DESTE MODING)                                            ###", false)
		minetest.chat_send_player(playername, "### Desenvolvedor:'Lunovox Heavenfinder'<rui.gravata@gmail.com>                          ###", false)
		minetest.chat_send_player(playername, "############################################################################################", false)
		minetest.chat_send_player(playername, "FUNCAO:", false)
		minetest.chat_send_player(playername, "   * Habilita funcao de salvar e ler variaveis globais e pessoais em arquivo,", false)
		minetest.chat_send_player(playername, "     que podem ser usadas diretamente pelo jogador administrador, ou por outros mods.", false)
		minetest.chat_send_player(playername, "SINTAXE:", false)
		minetest.chat_send_player(playername, "   * /set_global_value <variavel> <valor>", false)
		minetest.chat_send_player(playername, "       -> Grava uma variavel global no mapa (Necessita de privilegio 'server').", false)
		minetest.chat_send_player(playername, "   * /get_global_value <variavel>", false)
		minetest.chat_send_player(playername, "       -> Exibe uma variavel global na tela (Necessita de privilegio 'server').", false)
		minetest.chat_send_player(playername, "   * /del_global_value <variavel>", false)
		minetest.chat_send_player(playername, "       -> Apaga uma variavel global no mapa (Necessita de privilegio 'server').", false)
		minetest.chat_send_player(playername, "   * /set_char_value <jogador> <variavel> <valor>", false)
		minetest.chat_send_player(playername, "       -> Grava uma variavel de jogador no mapa (Necessita de privilegio 'server').", false)
		minetest.chat_send_player(playername, "   * /get_char_value <jogador> <variavel>", false)
		minetest.chat_send_player(playername, "       -> Exibe uma variavel de jogador na tela (Necessita de privilegio 'server').", false)
		minetest.chat_send_player(playername, "   * /del_char_value <jogador> <variavel>", false)
		minetest.chat_send_player(playername, "       -> Apaga uma variavel de jogador no mapa (Necessita de privilegio 'server').", false)
		minetest.chat_send_player(playername, "############################################################################################", false)
		minetest.chat_send_player(playername, playername..", precione F10 e use a rolagem do mouse para ler todo este tutorial!!!", false)
	end,
})
