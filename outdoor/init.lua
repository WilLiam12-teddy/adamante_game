local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath.."/api.lua")

--#############################################################################################################

--outdoor.register_simbol(id, description, tile, textHud)

outdoor.register_simbol("flag_brasil", "Bandeira do Brasil", "flag_brasil.png", "Bandeira do Brasil")

outdoor.register_simbol("simbol_shop", "Loja Generica (1)", "simbol_shop.png", "Loja Generica")
outdoor.register_simbol("simbol_shop2", "Loja Generica (2)", "simbol_shop2.png", "Loja Generica")
outdoor.register_simbol("simbol_food", "Loja de Comida", "simbol_food.png", "Loja de Comida")
outdoor.register_simbol("simbol_seed", "Loja de Sementes", "simbol_seed.png", "Loja de Sementes")
outdoor.register_simbol("simbol_tools", "Loja de Ferramentas e Armas", "simbol_tools.png", "Loja de Ferramentas e Armas")
outdoor.register_simbol("simbol_vesture", "Loja de Lan e Roupas", "simbol_vesture.png", "Loja de Lan e Roupas")
outdoor.register_simbol("simbol_cars_shop", "Loja de Veiculos", "simbol_cars_shop.png", "Loja de Veiculos")
outdoor.register_simbol("simbol_cars_race", "Area de Corrida", "simbol_cars_race.png", "Area de Corrida")

outdoor.register_simbol("simbol_danger_radioactive", "Perigo: Radioatividade", "simbol_danger_radioactive.png", "PERIGO: RADIOATIVIDADE")
outdoor.register_simbol("simbol_danger_monsters", "Perigo: Monstros", "simbol_danger_monsters.png", "PERIGO: MONSTROS")
outdoor.register_simbol("simbol_danger_monsters2", "Perigo: Fantasmas", "simbol_danger_monsters2.png", "PERIGO: FANTASMAS")
outdoor.register_simbol("sign_dontfeedthetrolls", "Proibido Alimentar Trolls", "sign_dontfeedthetrolls.png", "PROIBIDO ALIMENTAR TROLLS")
outdoor.register_simbol("sign_constrution_zone_256", "Placa 'Area em Construcao'", "sign_constrution_zone_256x256.png")
outdoor.register_simbol("sign_elec_shock_risk", "Risco de Choque Elétrico", "sign_electrical-shock-risk_96x96.png", "RISCO DE CHOQUE ELÉTRICO")
outdoor.register_simbol("sign_falling_risk", "Risco de Queda", "sign_falling_risk_256x256.png")
outdoor.register_simbol("sign_nao_vendo_fiado", "Não Vendo Fiado", "sign_nao_vendo_fiado_256x256.png")
outdoor.register_simbol("sign_nao_sinta_inveja", "Não Sinta Inveja", "sign_nao_sinta_inveja_256x256.png")
outdoor.register_simbol("sign_inveja_do_gato", "CUIDADO: Inveja do Gato", "sign_inveja_do_gato_256x256.png")
outdoor.register_simbol("sign_comer_coco", "Proibido Comer Coco", "sign_proibido_comer_coco_149x151.png")
outdoor.register_simbol("sign_dona_brava", "CUIDADO: Dona Brava", "sign_cuidado_dona_brava_195x195.png")
outdoor.register_simbol("sign_sua_higiene", "CUIDADO: Com Sua Higiêne", "sign_sua_higiene_512x512.png")

outdoor.register_simbol("sign_hammer", "Loja de Ferramentas", "sign_hammer.png", "Loja de Ferramentas")
outdoor.register_simbol("sign_hospital", "Hospital/Enfermaria", "sign_hospital.png")
outdoor.register_simbol("sign_bank", "Banco (1)", "sign_bank.png", "Banco")
outdoor.register_simbol("sign_bank2", "Banco (2)", "sign_bank2.png", "Banco")
outdoor.register_simbol("sign_hotel", "Hospedaria", "sign_hotel.png", "Hospedaria")
outdoor.register_simbol("simbol_distintivo", "Delegacia de Policia", "simbol_distintivo.png", "Delegacia de Policia")
outdoor.register_simbol("simbol_sheriff", "Xerife", "simbol_sheriff.png")
outdoor.register_simbol("sign_open", "Placa 'Aberto'", "sign_open.png", "Placa 'Aberto'")
outdoor.register_simbol("sign_close", "Placa 'Fechado'", "sign_close.png", "Placa 'Fechado'")

outdoor.register_simbol("sign_alugase1", "Placa 'Aluga-se (Terreno)'", "sign_aluga-se1.png")
outdoor.register_simbol("sign_alugase2", "Placa 'Aluga-se (Generico)'", "sign_aluga-se2.png")
outdoor.register_simbol("sign_vendese1", "Placa 'Vende-se (Terreno)'", "sign_vende-se1.png")
outdoor.register_simbol("sign_vendese2", "Placa 'Vende-se (Generico)'", "sign_vende-se2.png")
outdoor.register_simbol("sign_vendido", "Placa 'Vendido'", "sign_vendido.png")

outdoor.register_simbol("sign_arrow_down", "Siga para a Baixo/Atraz", "sign_arrow_down.png")
outdoor.register_simbol("sign_arrow_left", "Siga para a Esquerda", "sign_arrow_left.png")
outdoor.register_simbol("sign_arrow_right", "Siga para a Direita", "sign_arrow_right.png")
outdoor.register_simbol("sign_arrow_up", "Siga para a Cima/Frente", "sign_arrow_up.png")

outdoor.register_simbol("a", "Letra A", "writing_A.png")
outdoor.register_simbol("b", "Letra B", "writing_B.png")
outdoor.register_simbol("c", "Letra C", "writing_C.png")
outdoor.register_simbol("d", "Letra D", "writing_D.png")
outdoor.register_simbol("e", "Letra E", "writing_E.png")
outdoor.register_simbol("f", "Letra F", "writing_F.png")
outdoor.register_simbol("g", "Letra G", "writing_G.png")
outdoor.register_simbol("h", "Letra H", "writing_H.png")
outdoor.register_simbol("i", "Letra I", "writing_I.png")
outdoor.register_simbol("j", "Letra J", "writing_J.png")
outdoor.register_simbol("k", "Letra K", "writing_K.png")
outdoor.register_simbol("l", "Letra L", "writing_L.png")
outdoor.register_simbol("m", "Letra M", "writing_M.png")
outdoor.register_simbol("n", "Letra N", "writing_N.png")
outdoor.register_simbol("o", "Letra O", "writing_O.png")
outdoor.register_simbol("p", "Letra P", "writing_P.png")
outdoor.register_simbol("q", "Letra Q", "writing_Q.png")
outdoor.register_simbol("r", "Letra R", "writing_R.png")
outdoor.register_simbol("s", "Letra S", "writing_S.png")
outdoor.register_simbol("t", "Letra T", "writing_T.png")
outdoor.register_simbol("u", "Letra U", "writing_U.png")
outdoor.register_simbol("v", "Letra V", "writing_V.png")
outdoor.register_simbol("w", "Letra W", "writing_W.png")
outdoor.register_simbol("x", "Letra X", "writing_X.png")
outdoor.register_simbol("y", "Letra Y", "writing_Y.png")
outdoor.register_simbol("z", "Letra Z", "writing_Z.png")

outdoor.register_simbol("frame_lunovox", "Quadro 'LUNOVOX'", "frame.png^frame_lunovox.png", "Quadro 'LUNOVOX'")
outdoor.register_simbol("frame_amizade1", "Quadro 'Amizade 1'", "frame.png^frame_amizade1.png", "Quadro 'Amizade 1'")
outdoor.register_simbol("frame_amizade2", "Quadro 'Amizade 2'", "frame.png^frame_amizade2.png", "Quadro 'Amizade 2'")
outdoor.register_simbol("frame_apocalipse", "Quadro 'Apocalipse'", "frame.png^frame_apocalipse.png", "Quadro 'Apocalipse'")
outdoor.register_simbol("frame_inteligencia", "Quadro 'Inteligencia'", "frame.png^frame_inteligencia.png", "Quadro 'Inteligencia'")
outdoor.register_simbol("frame_perseveranca", "Quadro 'Perseveranca'", "frame.png^frame_perseveranca.png", "Quadro 'Perseveranca'")
outdoor.register_simbol("frame_preconceito", "Quadro 'Preconceito'", "frame.png^frame_preconceito.png", "Quadro 'Preconceito'")
outdoor.register_simbol("frame_craftopoles", "Quadro 'Craftopoles' (2020-06-12)", "frame.png^frame_craftopoles_2020-06-12.png", "Quadro 'Craftopoles' (2020-06-12)")

--#############################################################################################################

minetest.log('action',"["..modname:upper().."] Carregado!")
