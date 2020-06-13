--[[
	Mod Taverna_Barbara para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Diretrizes
	
  ]]

--[[
	Configure apenas nos locais indicados	
  ]]


-- Raridade de tavernas bárbaras no mapa
--[[
	Porcentagem de probabilidade de gerar uma taverna barbara quando possivel
	0% não gera
	100% gera sempre que possivel
  ]]
local PROBABILIDADE_GERAR_TAVERNA = tonumber(minetest.settings:get("taverna_barbara_probabilidade_gerar_taverna") or 7)


-- Tempo para um trambiqueiro oferecer outra troca (em segundos)
local TEMPO_PARA_NOVO_TRAMBIQUE = 600 -- 10 minutos

-- Quantidade de arquivos de tavernas
local QUANTIDADE_TAVERNAS = 1

-- Item de troca
local ITEM_MOEDA = minetest.settings:get("taverna_barbara_moeda") or "default:apple"
local ITEM_MOEDA_CODE = minetest.settings:get("taverna_barbara_moeda_code") or ""

-- Custos no barman
local CUSTO_CERVEJA = tonumber(minetest.settings:get("taverna_barbara_custo_cerveja") or 3)
local CUSTO_WHISKY = tonumber(minetest.settings:get("taverna_barbara_custo_whisky") or 4)
local CUSTO_BATANOURA_DEFUMADA = tonumber(minetest.settings:get("taverna_barbara_custo_batanoura_defumada") or 2)
local CUSTO_AMENDOIM = tonumber(minetest.settings:get("taverna_barbara_custo_amendoim") or 1)
local CUSTO_BALINHA_SORTIDA = tonumber(minetest.settings:get("taverna_barbara_custo_balinha_sortida") or 1)

-- Saciamento de alimentos
local SACIAMENTO_CERVEJA = tonumber(minetest.settings:get("taverna_barbara_saciamento_cerveja") or 4)
local SACIAMENTO_WHISKY = tonumber(minetest.settings:get("taverna_barbara_saciamento_whisky") or 5)
local SACIAMENTO_BATANOURA_DEFUMADA = tonumber(minetest.settings:get("taverna_barbara_saciamento_batanoura_defumada") or 4)
local SACIAMENTO_AMENDOIM = tonumber(minetest.settings:get("taverna_barbara_saciamento_amendoim") or 1)
local SACIAMENTO_BALINHA_SORTIDA = tonumber(minetest.settings:get("taverna_barbara_saciamento_balinha_sortida") or tonumber(0))

-- Trocas oferecidas pelos trambiqueiros 
--[[
	Ao menos 1 ofeta deve estar disponivel nessa lista/tabela
	Todas ofertas devem seguir o exemplo
		* Apenas 1 tipo de item para custo e 1 tipo para oferta
		* A quantidade (número) deve estar sempre após a string/id do item separado por um espaço " "
  ]]
local OFERTAS_TRAMBIQUEIRO = {
	-- exemplo
	-- {custo = "currency:macro 1", item = "default:paper 3"},
	{custo = ITEM_MOEDA.." 12", item = "default:mese_crystal 1"},
	{custo = ITEM_MOEDA.." 5", item = "shields:shield_enhanced_wood 1"},
	{custo = ITEM_MOEDA.." 15", item = "default:pick_diamond 1"},
}

--
-- Ajuste de dados 
--
taverna_barbara.trambiqueiro = {
	ofertas = OFERTAS_TRAMBIQUEIRO,
	tempo_restauro_trambique = TEMPO_PARA_NOVO_TRAMBIQUE
}
taverna_barbara.probabilidade_gen = PROBABILIDADE_GERAR_TAVERNA
taverna_barbara.qtd_arquivos = QUANTIDADE_TAVERNAS
taverna_barbara.gerente_areas = GERENTE_AREAS
taverna_barbara.item_moeda = ITEM_MOEDA
taverna_barbara.desc_item_moeda = minetest.registered_items[ITEM_MOEDA].description
taverna_barbara.item_moeda_code = ITEM_MOEDA_CODE
taverna_barbara.custo_cerveja = CUSTO_CERVEJA
taverna_barbara.custo_whisky = CUSTO_WHISKY
taverna_barbara.custo_batanoura_defumada = CUSTO_BATANOURA_DEFUMADA
taverna_barbara.custo_amendoim = CUSTO_AMENDOIM
taverna_barbara.custo_balinha_sortida = CUSTO_BALINHA_SORTIDA
taverna_barbara.saciamento_cerveja = SACIAMENTO_CERVEJA
taverna_barbara.saciamento_whisky = SACIAMENTO_WHISKY
taverna_barbara.saciamento_batanoura_defumada = SACIAMENTO_BATANOURA_DEFUMADA
taverna_barbara.saciamento_amendoim = SACIAMENTO_AMENDOIM
taverna_barbara.saciamento_balinha_sortida = SACIAMENTO_BALINHA_SORTIDA
