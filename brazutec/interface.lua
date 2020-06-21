--
-- Interface principal do Laptop
--

-- Slots de aplicativos do laptop
brazutec_slot1_imagem = ""
brazutec_slot1_etiqueta = ""
brazutec_slot2_imagem = ""
brazutec_slot2_etiqueta = ""
brazutec_slot3_imagem = ""
brazutec_slot3_etiqueta = ""
brazutec_slot4_imagem = ""
brazutec_slot4_etiqueta = ""
brazutec_slot5_imagem = ""
brazutec_slot5_etiqueta = ""
brazutec_slot6_imagem = ""
brazutec_slot6_etiqueta = ""
brazutec_laptop = {
	desktop = "size[12,9]"..
			"bgcolor[#080808BB;true]"..
			"background[0,0;12,9;brazutec_desktop.png]"..
			"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
			"image_button[10.3,6.8;2,2;brazutec_botao_semapps.png;brazutec_semapps_etiqueta;]",
	semapps = "size[5,6.5]".. -- Tela de aviso 'Sem Apps'
			"label[0.5,0.5;Nenhum aplicativo instalado]"..
			"image[0.5,1;5,5;brazutec_botao_semapps.png]"..
			"label[0.5,5.5;Encontre aplicativos no site]"..
			"label[0.5,6;brazutec.blogspot.com]",
	acessib = "size[7,4]".. -- Tela de configurar acessibilidade
			"bgcolor[#080808BB;true]"..
			"background[0,0;8.5,5;brazutec_fundo_verde.png;true]"..
			"label[0.5,0.25;Configurar Acessibilidade]"..
			"image_button[0.5,1;3,3;brazutec_botao_acessibilidade.png;brazutec_acessib_fechada_etiqueta;]"..
			"image_button[3.5,1;3,3;brazutec_botao_acessibilidade_aberta.png;brazutec_acessib_aberta_etiqueta;]",
	acessibdes = "size[12,9]".. -- Tela de acessibilidade destravada
			"bgcolor[#080808BB;true]"..
			"background[0,0;12,9;brazutec_desktop.png]"..
			"label[5.3,4;ACESSO DESTRAVADO]"..
			"image[2,2;4,4;brazutec_botao_acessibilidade_aberta.png]",
	acessibtra = "size[12,9]".. -- Tela de acessibilidade travada
			"bgcolor[#080808BB;true]"..
			"background[0,0;12,9;brazutec_desktop.png]"..
			"label[5.3,4;ACESSO TRAVADO]"..
			"image[2,2;4,4;brazutec_botao_acessibilidade.png]",
}

-- Instalador de aplicativos
function brazutec_instalar_em_cub(textura, etiqueta)
	if brazutec_slot1_imagem == "" then
		brazutec_slot1_imagem = textura
		brazutec_slot1_etiqueta = etiqueta
		brazutec_laptop.desktop = "size[12,9]"..
			"bgcolor[#080808BB;true]"..
			"background[0,0;12,9;brazutec_desktop.png]"..
			"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
			"image_button[1,1.5;3,3;"..brazutec_slot1_imagem..";"..brazutec_slot1_etiqueta..";]"
	 else
		if brazutec_slot2_imagem == "" then
	 		brazutec_slot2_imagem = textura
			brazutec_slot2_etiqueta = etiqueta
			brazutec_laptop.desktop = "size[12,9]"..
				"bgcolor[#080808BB;true]"..
				"background[0,0;12,9;brazutec_desktop.png]"..
				"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
				"image_button[1,1.5;3,3;"..brazutec_slot1_imagem..";"..brazutec_slot1_etiqueta..";]"..
				"image_button[2,4.5;3,3;"..brazutec_slot2_imagem..";"..brazutec_slot2_etiqueta..";]"
		 else
		 	if brazutec_slot3_imagem == "" then
		 		brazutec_slot3_imagem = textura
				brazutec_slot3_etiqueta = etiqueta
				brazutec_laptop.desktop = "size[12,9]"..
					"bgcolor[#080808BB;true]"..
					"background[0,0;12,9;brazutec_desktop.png]"..
					"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
					"image_button[1,1.5;3,3;"..brazutec_slot1_imagem..";"..brazutec_slot1_etiqueta..";]"..
					"image_button[2,4.5;3,3;"..brazutec_slot2_imagem..";"..brazutec_slot2_etiqueta..";]"..
					"image_button[4,1.5;3,3;"..brazutec_slot3_imagem..";"..brazutec_slot3_etiqueta..";]"
			else
			 	if brazutec_slot4_imagem == "" then
			 		brazutec_slot4_imagem = textura
					brazutec_slot4_etiqueta = etiqueta
					brazutec_laptop.desktop = "size[12,9]"..
							"bgcolor[#080808BB;true]"..
							"background[0,0;12,9;brazutec_desktop.png]"..
							"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
							"image_button[1,1.5;3,3;"..brazutec_slot1_imagem..";"..brazutec_slot1_etiqueta..";]"..
							"image_button[2,4.5;3,3;"..brazutec_slot2_imagem..";"..brazutec_slot2_etiqueta..";]"..
							"image_button[4,1.5;3,3;"..brazutec_slot3_imagem..";"..brazutec_slot3_etiqueta..";]"..
							"image_button[5,4.5;3,3;"..brazutec_slot4_imagem..";"..brazutec_slot4_etiqueta..";]"
				else
					if brazutec_slot5_imagem == "" then
			 			brazutec_slot5_imagem = textura
						brazutec_slot5_etiqueta = etiqueta
						brazutec_laptop.desktop = "size[12,9]"..
								"bgcolor[#080808BB;true]"..
								"background[0,0;12,9;brazutec_desktop.png]"..
								"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
								"image_button[1,1.5;3,3;"..brazutec_slot1_imagem..";"..brazutec_slot1_etiqueta..";]"..
								"image_button[2,4.5;3,3;"..brazutec_slot2_imagem..";"..brazutec_slot2_etiqueta..";]"..
								"image_button[4,1.5;3,3;"..brazutec_slot3_imagem..";"..brazutec_slot3_etiqueta..";]"..
								"image_button[5,4.5;3,3;"..brazutec_slot4_imagem..";"..brazutec_slot4_etiqueta..";]"..
								"image_button[7,1.5;3,3;"..brazutec_slot5_imagem..";"..brazutec_slot5_etiqueta..";]"
					 else
					 	if brazutec_slot6_imagem == "" then
			 				brazutec_slot6_imagem = textura
							brazutec_slot6_etiqueta = etiqueta
								brazutec_laptop.desktop = "size[12,9]"..
										"bgcolor[#080808BB;true]"..
										"background[0,0;12,9;brazutec_desktop.png]"..
										"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
										"image_button[1,1.5;3,3;"..brazutec_slot1_imagem..";"..brazutec_slot1_etiqueta..";]"..
										"image_button[2,4.5;3,3;"..brazutec_slot2_imagem..";"..brazutec_slot2_etiqueta..";]"..
										"image_button[4,1.5;3,3;"..brazutec_slot3_imagem..";"..brazutec_slot3_etiqueta..";]"..
										"image_button[5,4.5;3,3;"..brazutec_slot4_imagem..";"..brazutec_slot4_etiqueta..";]"..
										"image_button[7,1.5;3,3;"..brazutec_slot5_imagem..";"..brazutec_slot5_etiqueta..";]"..
										"image_button[8,4.5;3,3;"..brazutec_slot6_imagem..";"..brazutec_slot6_etiqueta..";]"..
										"image_button[10.3,6.8;2,2;brazutec_botao_excessodeapps.png;brazutec_excessodeapps_etiqueta;]"
						 else
						 	-- Excesso de aplicativos
						 	brazutec_laptop.desktop = "size[12,9]"..
										"bgcolor[#080808BB;true]"..
										"background[0,0;12,9;brazutec_desktop.png]"..
										"image_button[0,0;1.5,1.5;brazutec_botao_acessibilidade.png;brazutec_acessib_etiqueta;]"..
										"image_button[1,1.5;3,3;"..brazutec_slot1_imagem..";"..brazutec_slot1_etiqueta..";]"..
										"image_button[2,4.5;3,3;"..brazutec_slot2_imagem..";"..brazutec_slot2_etiqueta..";]"..
										"image_button[4,1.5;3,3;"..brazutec_slot3_imagem..";"..brazutec_slot3_etiqueta..";]"..
										"image_button[5,4.5;3,3;"..brazutec_slot4_imagem..";"..brazutec_slot4_etiqueta..";]"..
										"image_button[7,1.5;3,3;"..brazutec_slot5_imagem..";"..brazutec_slot5_etiqueta..";]"..
										"image_button[8,4.5;3,3;"..brazutec_slot6_imagem..";"..brazutec_slot6_etiqueta..";]"..
										"image_button[10.3,6.8;2,2;brazutec_botao_excessodeapps.png;brazutec_excessodeapps_etiqueta;]"
							brazutec_laptop.excessodeapps = "size[5,7]".. -- Tela de aviso de erro no app
										"label[0.5,0.5;Excesso de aplicativos]"..
										"image[0.5,1;5,5;brazutec_botao_semapps.png]"..
										"label[0.5,5.5;O laptop suporta apenas 6]"..
										"label[0.5,6;aplicativos]"..
										"label[0.5,6.5;Existe um excesso (verifique)]"
						end
					end
				end
			end
		end
	end		
end

-- Verificar Dono
local function verificar_dono(meta, player)
	if player:get_player_name() ~= meta:get_string("dono") then
		return false
	end
	return true
end

-- Funcoes dos botoes para ocorrencias
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.brazutec_semapps_etiqueta then
		minetest.show_formspec(player:get_player_name(), "brazutec_laptop", brazutec_laptop.semapps)
	end
	if fields.brazutec_excessodeapps_etiqueta then
		minetest.show_formspec(player:get_player_name(), "brazutec_laptop", brazutec_laptop.excessodeapps)
	end
	if fields.brazutec_acessib_etiqueta then
		local pos = minetest.deserialize(formname)
		local meta = minetest.get_meta(pos)
		if verificar_dono(meta, player) then
			local formname = minetest.serialize(pos)
			minetest.show_formspec(player:get_player_name(), formname, brazutec_laptop.acessib)
		end
	end
	if fields.brazutec_acessib_aberta_etiqueta then
		local pos = minetest.deserialize(formname)
		local meta = minetest.get_meta(pos)
		if verificar_dono(meta, player) then
			meta:set_string("acessib", "aberta")
			minetest.show_formspec(player:get_player_name(), formname, brazutec_laptop.acessibdes)
			minetest.after(1.5, minetest.show_formspec,player:get_player_name(), formname, brazutec_laptop.desktop)
		end
	end
	if fields.brazutec_acessib_fechada_etiqueta then
		local pos = minetest.deserialize(formname)
		local meta = minetest.get_meta(pos)
		if verificar_dono(meta, player) then
			meta:set_string("acessib", "fechada")
			local formname = minetest.serialize(pos)
			minetest.show_formspec(player:get_player_name(), formname, brazutec_laptop.acessibtra)
			minetest.after(1.5, minetest.show_formspec, player:get_player_name(), formname, brazutec_laptop.desktop)
		end
	end
end)
