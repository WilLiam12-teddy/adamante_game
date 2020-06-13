--[[
	Mod Urbos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Banco de dados das cidades
  ]]


-- Caracteres validos
local valid_chars = {
	-- Maiusculos
	["A"] = true,
	["B"] = true,
	["C"] = true,
	["D"] = true,
	["E"] = true,
	["F"] = true,
	["G"] = true,
	["H"] = true,
	["I"] = true,
	["J"] = true,
	["K"] = true,
	["L"] = true,
	["M"] = true,
	["N"] = true,
	["O"] = true,
	["P"] = true,
	["Q"] = true,
	["R"] = true,
	["S"] = true,
	["T"] = true,
	["U"] = true,
	["V"] = true,
	["W"] = true,
	["X"] = true,
	["Y"] = true,
	["Z"] = true,
	-- Minusculos
	["a"] = true,
	["b"] = true,
	["c"] = true,
	["d"] = true,
	["e"] = true,
	["f"] = true,
	["g"] = true,
	["h"] = true,
	["i"] = true,
	["j"] = true,
	["k"] = true,
	["l"] = true,
	["m"] = true,
	["n"] = true,
	["o"] = true,
	["p"] = true,
	["q"] = true,
	["r"] = true,
	["s"] = true,
	["t"] = true,
	["u"] = true,
	["v"] = true,
	["w"] = true,
	["x"] = true,
	["y"] = true,
	["z"] = true,
	-- Caracteres especiais
	[" "] = true
}

-- Verificar nome do grupo
urbos.checkname_cidade = function(nome)
	-- Verifica comprimento
	if string.len(nome) > 30 or string.len(nome) == 0 then
		return false, 1
	end
	
	-- Verifica caracteres validos
	local nome_valido = ""
	for char in string.gmatch(nome, ".") do
		if valid_chars[char] then
			nome_valido = nome_valido .. char
		end
	end
	if nome ~= nome_valido then
		return false, 2, nome_valido
	end
	
	return true
end


-- Registrar nova cidade
urbos.nova_cidade = function(name, pos)
	
	-- Salva na tabela de cidades
	dados = {
		pos = pos,
		pts = 1,
	}
	
	-- Salva coordenada
	urbos.bd.salvar("cidades", name, dados)
end
