lunohints = { }

lunohints.getFormspecIndex = function()
	local formspec = "size[3.0,3.25]"
	--.."bgcolor[#00880044;false]"
	formspec = formspec
		--.."background[0,0;3.0,2.75;adamante.png]"
		.."image[0,0;3.6,0.5;adamante.png]"
		.."button[0,0.75;3,0.5;btnHistory;Historia]"
		.."button[0,1.50;3,0.5;btnRules;Regras]"
		.."button[0,2.25;3,0.5;btnHints;Dicas]"
		.."label[0,3.00;ESC para sair...]"
	return formspec
end

lunohints.getFormspecRules = function()
	local formspec = "size[10,7.5]"
	.."bgcolor[#00880044;false]"
	formspec = formspec
		.."textarea[0.5,0.5;9.5,7.5;txtRules;Regras;"
			..minetest.formspec_escape(
				"ATENCAO: Aqui no Servidor de Adamante, não permitimos que desrespeite as regras, pois você será kickado ou até banido! O Admin do servidor é gente boa, mas quando desrespeitam as regras... Hahahaha.\n\n"
				.."   #1 - Não encomode o Admin pedindo o famoso pedido de noob para ser admin ou para obter os privs de admin. Cara, você será apenas ignorado, ou ATÉ BANIDO.\n\n"
				.."   #2 - Nunca ouse de usar hack, viu? AQUI NÃO PERMITIMOS HACKER.\n\n"
				.."   #3 - Não seja racista ou homofobico. POIS ISSO TERÁ SEVERAS PUNIÇÕES. Aqui não é permitido esse tipo de coisa. \n\n"
				.."   #4 - O dono do terreno pode compartilhar (ou descompartilhar) o acesso a interação com seu terreno (e também dos baús) com outras pessoas conforme sua própria vontade!\n\n"
				.."   #5 - Não seja rude com os outros players, pois isso é muita má educação e os players se magoam.\n\n"
				.."   #6 - Conselho: por email em uma placa em frente sua casa para que o Admin possa ter certos contatos com você, para discussão sobre o servidor se for nescessario. Mas não é nada obrigatorio.\n\n"
				.."   #7 - Não mate os outros players, pois isso faz com que eu (Admin) te dê um chute do servidor.\n\n"
				.."   #8 - Denúncias sobre regras infligidas devem ser feitas através de 'carta' (item craftável do servidor), e endereçadas ao Admin (WilLiam12) com descrição de data-hora e local da ocorrência.\n\n"
                                .."   #9 - Favor, colabore com a cidade, e tenha pelo menos uma construção perto do Spawn. Isso vai coperar e ajudar muito com a cidade de Adamante! =)\n\n"
                                .."   #10 - Nunca faça atos sexuais pois há crianças no servidor! Não comente nada sexual no chat também. Queremos que as crianças deste servidor vejam e façam atos saudaveis como construir, conversas e papos legais, etc...\n\n"
			)
		.."]"
		.."button[7.75,7.2;2,0.5;btnIndex;Voltar]"
	return formspec
end

lunohints.getFormspecHistory = function(playername)
	local formspec = "size[10,7.5]"
	--.."bgcolor[#00880044;false]"
	formspec = formspec
		.."textarea[0.5,0.5;9.5,7.5;txtHistory;Sua historia de sobrevivencia neste mundo cruel;"
			..minetest.formspec_escape(""
				.."Adamante, a cidade que será construida por todos nós. "
				.."Adamante começou com um simples servidor que cabia 8 pessoas e tinha poucas coisas, e com o tempo foi evoluindo.  "
				.."Os jogadores começaram a vir e se fixar aqui, a cidade começou a ser levantada, mais players vieram e a cidade começou a crescer. "
				.."Muitas coisas divertidas forão sido descobridas em Adamante, e assim surgiu o servidor da diversão, o Adamante. "
				.."Muitos pensam que e só isso, mas não. Adamante é algo grande, e cada um pode ver isso, basta procurar por coisas novas... "
				.."Cada vez que alguém novo entra, mais feliz e completo fica Adamante.\n"
				.."\n"
				..playername.." é uma pessoa que veio pra alegrar o dia de WilLiam12 (dono do servidor) com seus planos de construção para a cidade. "
				.."O sonho de "..playername.." é construir muito bem, mas aqui tudo é possivel, basta focar em seus projetos que eles dão certo. "
				.."\n"
				.."E assim começa a saga de construção de "..playername.."..."
			)
		.."]"
		.."button[7.75,7.2;2,0.5;btnIndex;Voltar]"

	return formspec
end

lunohints.getFormspecHints = function()
	local formspec = "size[10,7.5]"
	--.."bgcolor[#00880044;false]"
	formspec = formspec
		.."textarea[0.5,0.5;9.5,7.5;txtHints;Dicas de como jogar;"
			..minetest.formspec_escape(
				"ATENÇÃO: Leia com atenção. Pois são coisas legais e que vão te ajudar no servidor. ;-)\n\n"
				.."   #01 - Se você precisar, poderá exibir novamente esta ajuda com o comando: '/welcome' ou '/adamante' ou apenas relogando no servidor.\n\n"
				.."   #02 - Aqui você escolhe sua dificuldade, se você não sabe. Então use qualquer um de nossos serviços de proteção de terreno. Temos o: areas, alvará de proteção e o protector block.\n "
				.."   #03 - O pior inimigo que você encontrará é a fome. Mate animais domésticos, colha frutas nas arvores, compre comida nas lojas e cultive comida, mas não morra de fome!\n\n"
				.."   #04 - Tente ajudar os players, ajuda é sempre bem vinda aqui e faz bem a si proprio. \n"
				.."   #05 - Recomendavel jogar na 5.1.1, para evitar possiveis bugs!\n\n"
				.."   #06 - Voce pode construir seu abrigo ou casa em qualquer local (exceto sobre o terreno das estradas).\n\n"
				.."   #07 - Contrua o que quiser, mas se quiser, pode construir algo que toda cidade tem para ajudar a cidade, mas espere, cada bloco novo que você colocar, já estará colaborando com a cidade! :-)\n\n"
				.."   #08 - Casas ou Construções com uma beleza inigualáveis poderão receber um premio, mas isso vai ser pensado pelo Admin.\n\n"
				.."   #09 - Se cortou uma árvore, corte-a completamente e depois replante-a! Um dia você pode precisar novamente de madeira e não a encontrará.\n\n"
				.."   #10 - Colete os seus próprios recursos embaixo de seu próprio terreno protegido, ou nas minas públicas próximas ao spawn. Crie seu proprios equipamentos, pois ninguem tem a obrigação de lhe dar nada!\n\n"
				.."   #11 - Seja generoso com outras pessoas antes de querer que colaborem com voce!\n\n"
				.."   #12 - Ajude os outros players a construir, eles irão amar sua ajuda. E isso deixa qualquer um feliz de ver uma generosidade dessas.\n"
			)
		.."]"
		.."button[7.75,7.2;2,0.5;btnIndex;Voltar]"
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
	description = "Exibe painel de Bem Vindo com: História, Regras, e Dicas.",
	privs = {},
	func = function(playername, param)
		minetest.show_formspec(playername, "frmIndex", lunohints.getFormspecIndex())
	end,
})

minetest.register_chatcommand("adamante", {
	params = "",
	description = "Exibe painel de Bem Vindo com: História, Regras, e Dicas.",
	privs = {},
	func = function(playername, param)
		minetest.show_formspec(playername, "frmIndex", lunohints.getFormspecIndex())
	end,
})

minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
	minetest.show_formspec(playername, "frmIndex", lunohints.getFormspecIndex())
end)


