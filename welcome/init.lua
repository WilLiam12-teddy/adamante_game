lunohints = { }

lunohints.getFormspecIndex = function()
	local formspec = "size[3.0,3.25]"
	--.."bgcolor[#00880044;false]"
	formspec = formspec
		--.."background[0,0;3.0,2.75;adamante.png]"
		.."image[0,0;3.6,0.5;adamante.png]"
		.."button[0,0.75;3,0.5;btnHistory;Sobre/About/Sobre]"
		.."button[0,1.50;3,0.5;btnRules;Regras/Rules/Reglas]"
		.."button[0,2.25;3,0.5;btnHints;Dicas/Tips/Consejos]"
		.."label[0,3.00;ESC...]"
	return formspec
end

lunohints.getFormspecRules = function()
	local formspec = "size[10,7.5]"
	.."bgcolor[#00880044;false]"
	formspec = formspec
		.."textarea[0.5,0.5;9.5,7.5;txtRules;Regras/Rules/Reglas;"
			..minetest.formspec_escape(
				"ATENCAO: Aqui no Servidor de Adamante, não permitimos que desrespeite as regras, pois você será kickado ou até banido! O Admin do servidor é gente boa, mas quando desrespeitam as regras... Hahahaha.\n\n"
				.."   #1 - Não pedir por privs de Admin. / Don't ask for Admin privs. / No solicite privilegios de administrador.\n\n"
				.."   #2 - Não use Hack. / Don't Hack. / No uses hack.\n\n"
				.."   #3 - Não seja Racista/Homofobico. / Don't be Racist / Homophobic. /  No seas racista / homofóbico.\n\n"
				.."   #4 - Não faça Spam. / No Spam. / No hagas spam.\n\n"
				.."   #5 - Não seja rude com os outros players. / Don't be rude to other players. / No seas grosero con otros jugadores. \n\n"
				.."   #6 - Não grifar terrenos. / Don't grief areas. / No griefes las areas. \n\n"
				.."   #7 - Não mate os players. / Do not kill the players. / No mates a los jugadores.  \n\n"
				.."   #8 - Não faça ofensas. / Do not offend others. / No ofendas a los demás.\n\n"
			)
		.."]"
		.."button[7.75,7.2;2,0.5;btnIndex;Voltar/Back/Vuelve]"
	return formspec
end

lunohints.getFormspecHistory = function(playername)
	local formspec = "size[10,7.5]"
	--.."bgcolor[#00880044;false]"
	formspec = formspec
		.."textarea[0.5,0.5;9.5,7.5;txtSobre/About/Sobre;Adamante;"
			..minetest.formspec_escape(""
				.."Adamante é um servidor de construção para players que gostam de construir coisas mais detalhadas voltada a arquitetura medieval, moderna.... "
				.."Adamante is a building server for players who like to build more detailed things focused on medieval, modern architecture ....  "
				.."Adamante es un servidor de construcción para jugadores que les gusta construir cosas más detalladas centradas en la arquitectura medieval y moderna ... "
				.."Admins: Anthony, Nigel, Marcy e/and/y WilLiam12. Moderator: PequenoGamer, Pandinha e/and/y luizinho. "
				.."Divirta-se e tenha um bom jogo! "
                                .."Have fun and have a good game! "
				.."¡Diviértete y diviértete!\n"
				.."\n"
			)
		.."]"
		.."button[7.75,7.2;2,0.5;btnIndex;Voltar/Back/Vuelve]"

	return formspec
end

lunohints.getFormspecHints = function()
	local formspec = "size[10,7.5]"
	--.."bgcolor[#00880044;false]"
	formspec = formspec
		.."textarea[0.5,0.5;9.5,7.5;txtHints;Dicas/Tips/Consejos;"
			..minetest.formspec_escape(
				"Dicas/Tips/Consejos\n\n"
				.."   #01 - Se você precisar, poderá exibir novamente esta ajuda com o comando: '/welcome' ou '/adamante' ou apenas relogando no servidor./If you need to, you can display this help again with the command: '/welcome' or '/adamante' or just relogging it on the server./Si lo necesita, puede volver a mostrar esta ayuda con el comando: '/welcome' o '/adamante' o simplemente volviéndolo a registrar en el servidor.\n\n"
				.."   #02 - Dispomos de varios serviços de proteção de terreno./We have several terrain protection services/Contamos con varios servicios de protección del terreno.\n "
				.."   #03 - Faça plantação pra ter comida para não morrer de fome./Plant crops to have food to keep from starving./Plante cultivos para tener alimentos para evitar morir de hambre. \n\n"
				.."   #04 - Tente ajudar os players, ajuda é sempre bem vinda aqui e faz bem a si proprio./Try to help the players, help is always welcome here and is good for you./Intenta ayudar a los jugadores, la ayuda siempre es bienvenida y es buena para ti. \n"
				.."   #05 - Recomendavel jogar na 5.1.1, para evitar possiveis bugs!/It is recommended to play in 5.1.1, to avoid possible bugs!/¡Se recomienda jugar en 5.1.1, para evitar posibles errores!\n\n"
				.."   #06 - Construa em qualquer lugar, menos nas estradas./Build anywhere, except on roads./Construir en cualquier lugar, excepto en carreteras.\n\n"
				.."   #07 - Peça ajuda aos mods/admins./Pide ayuda a los mods / administradores./Ask the mods / admins for help.\n"
			)
		.."]"
		.."button[7.75,7.2;2,0.5;btnIndex;Voltar/Back/Vuelve]"
	return formspec
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "frmIndex" then -- This is your form name
		if fields.btnIndex~=nil then
			minetest.show_formspec(player:get_player_name(), "frmIndex", lunohints.getFormspecIndex())
		elseif fields.btnRules~=nil then
			minetest.show_formspec(player:get_player_name(), "frmIndex", lunohints.getFormspecRules())
		elseif fields.btnHistory~=nil then
			minetest.show_formspec(player:get_player_name(), "frmIndex", lunohints.getFormspecHistory(player:get_player_name()))
		elseif fields.btnHints~=nil then
			minetest.show_formspec(player:get_player_name(), "frmIndex", lunohints.getFormspecHints())
		end
	end
end)


minetest.register_chatcommand("welcome", {
	params = "",
	description = "Exibe painel de Bem Vindo com: Sobre, Regras, e Dicas. / Displays Welcome panel with: About, Rules, and Tips. / Muestra el panel de bienvenida con: Sobre, Reglas y Consejos.",
	privs = {},
	func = function(playername, param)
		minetest.show_formspec(playername, "frmIndex", lunohints.getFormspecIndex())
	end,
})

minetest.register_chatcommand("adamante", {
	params = "",
	description = "Exibe painel de Bem Vindo com: Sobre, Regras, e Dicas. / Displays Welcome panel with: About, Rules, and Tips. / Muestra el panel de bienvenida con: Sobre, Reglas y Consejos.",
	privs = {},
	func = function(playername, param)
		minetest.show_formspec(playername, "frmIndex", lunohints.getFormspecIndex())
	end,
})

minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "frmIndex", lunohints.getFormspecIndex())
end)


