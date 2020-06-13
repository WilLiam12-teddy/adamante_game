--[[
	Mod Urbos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicializador de variaveis e scripts
  ]]

-- Notificador de Inicializador
local notificar = function(msg)
	if minetest.setting_get("log_mods") then
		minetest.debug("[Urbos]"..msg)
	end
end

local modpath = minetest.get_modpath("urbos")

-- Variavel global
urbos = {}

-- Carregar scripts
notificar("Carregando scripts...")

-- Criação do banco de dados
urbos.bd = dofile(modpath.."/lib/memor.lua")

-- Lib tror
urbos.tror = dofile(modpath.."/lib/tror.lua")

-- Variaveis personalizaveis
urbos.var = {}

-- Funções
--dofile(modpath.."/tradutor.lua")
dofile(modpath.."/banco_de_dados.lua")
dofile(modpath.."/cidade.lua")
dofile(modpath.."/ranking.lua")
dofile(modpath.."/teleportador.lua")
dofile(modpath.."/comandos.lua")
dofile(modpath.."/alvara.lua")
notificar("OK")

