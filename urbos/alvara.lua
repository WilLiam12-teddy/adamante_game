--[[
	Mod Urbos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Item para criar cidade
  ]]


-- Abrir interface
local exibir_interface_alvara = function(name)

	-- Formspec
	local formspec = "size[6,5]"
		..default.gui_bg
		..default.gui_bg_img
		.."label[0,0;Fundar cidade]"
		.."field[0.4,1;5.8,1;nome_cidade;Nome da Cidade;]"
		
		.."textarea[0.4,1.6;5.6,3;;Isso nao podera ser desfeito\nEsteja na altura do solo;]"
		
		.."button_exit[0,4.3;3,1;calcelar;Cancelar]"
		.."button_exit[3,4.3;3,1;fundar;Fundar]"
	
	-- Exibe regras
	minetest.show_formspec(name, "urbos:fundar_cidade", formspec)
end

-- Receber botoes
minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname == "urbos:fundar_cidade" then
		
		-- Caso estava so verificando regras
		if fields.fundar then
			local name  = player:get_player_name()
			
			-- Verifica se local esta protegido
			if minetest.is_protected(player:getpos(), "urbos:test") == true then
				minetest.chat_send_player(name, "Area protegida. Precisa ficar numa area livre")
				return
			end
			
			-- Verificar nome dados
			local check, erro = urbos.checkname_cidade(fields.nome_cidade)
			if check == false then
				if erro == 1 then
					minetest.chat_send_player(name, "Limite de 30 letras para o nome da cidade")
				elseif erro == 2 then
					minetest.chat_send_player(name, "Nome deve conter apenas letras A-Z a-z")
				else
					minetest.chat_send_player(name, "Falha ao criar cidade. Nome invalido")
				end
				return
			end
			
			-- Verifica se ja existe cidade com esse nome
			if urbos.bd.verif("cidades", fields.nome_cidade) == true then
				minetest.chat_send_player(name, "Ja existe uma cidade com esse nome")
				return
			end
			
			-- Verifica se possui o item ainda
			if urbos.tror.trocar_plus(player, {"urbos:alvara_cidade 1"}, nil) == false then
				minetest.chat_send_player(name, "Precisa do alvará para fundar a cidade")
				return
			end
			
			-- Cria cidade
			urbos.criar_cidade(player, fields.nome_cidade)
			
			minetest.chat_send_player(name, "Cidade "..fields.nome_cidade.." Fundada")
		end
	end
end)

-- Alvara
minetest.register_craftitem("urbos:alvara_cidade", {
	description = "Alvara para Fundar Cidade",
	inventory_image = "urbos_alvara_cidade.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		exibir_interface_alvara(user:get_player_name())
	end,
})
