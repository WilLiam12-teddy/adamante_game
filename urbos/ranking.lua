--[[
	Mod Urbos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Gerenciamento do Ranking
  ]]

-- Pegar ranking
urbos.get_rank = function()
	return urbos.bd.pegar("ranking", "pontos")
end

-- Tabela de acesso rapido ao ranking global
urbos.ranking = {}

-- Atualizar ranking
urbos.update_rank = function(name)
	local att_name = {}
	local rank = urbos.get_rank()
	local pontos = 0
	if urbos.bd.verif("cidades", name) == true then pontos = urbos.bd.pegar("cidades", name).pts end
	local m1 = {name=name,pontos=pontos}
	local m2 = {}
	for x=1, 10 do
		-- Se o objeto atual for o novo colocado
		if m1.name == name then
			-- Verifica se fica no lugar
			if rank[tostring(x)].pontos < m1.pontos then
			
				--Substitui posicao
				m2.name = rank[tostring(x)].name
				m2.pontos = rank[tostring(x)].pontos
				rank[tostring(x)].name = m1.name
				rank[tostring(x)].pontos = m1.pontos
				
				-- Verifica se o que foi tirado é ele mesmo
				if name == m2.name then
					break
				end
				
				-- m2 para a ser m1 para a proxima comparacao
				m1.name = m2.name
				m1.pontos = m2.pontos
				
			-- Nao é maior mas é o mesmo jogador
			elseif m1.name == rank[tostring(x)].name then
				-- atualiza os pontos e encerra
				rank[tostring(x)].pontos = m1.pontos
				break
			end
			
		-- Se o objeto atual for um recolocado
		else
			-- Marca para reclassificalos posteriormente
			table.insert(att_name, tostring(m1.name))
			
			-- Se for o objeto novo que ja foi colocado
			if rank[tostring(x)].name == name then
				rank[tostring(x)].name = m1.name
				rank[tostring(x)].pontos = m1.pontos
				break
				
			-- Se nao for compara normalmente
			else
				if rank[tostring(x)].pontos < m1.pontos then
					-- Substitui posicao
					m2.name = rank[tostring(x)].name
					m2.pontos = rank[tostring(x)].pontos
					rank[tostring(x)].name = m1.name
					rank[tostring(x)].pontos = m1.pontos
									
					-- m2 para a ser m1 para a proxima comparacao
					m1.name = m2.name
					m1.pontos = m2.pontos
				end
			end
			
		end
	end
	
	urbos.bd.salvar("ranking", "pontos", rank)
	urbos.ranking = minetest.deserialize(minetest.serialize(rank))
	
	-- Recoloca os necessarios
	for _, n in ipairs(att_name) do
		urbos.update_rank(n)
		break
	end
end

-- Certifica de que rank existe
if urbos.bd.verif("ranking", "pontos") == false then
	rank = {
		["1"] = {name="-1-",pontos=0},
		["2"] = {name="-2-",pontos=0},
		["3"] = {name="-3-",pontos=0},
		["4"] = {name="-4-",pontos=0},
		["5"] = {name="-5-",pontos=0},
		["6"] = {name="-6-",pontos=0},
		["7"] = {name="-7-",pontos=0},
		["8"] = {name="-8-",pontos=0},
		["9"] = {name="-9-",pontos=0},
		["10"] = {name="-10-",pontos=0},
	}
	urbos.bd.salvar("ranking", "pontos", rank)
end


-- Bloqueio de verificador para evitar pesar no servidor
local bloq = {}
-- Desbloquear analise da cidade
local desbloquear_analise = function(name)
	bloq[name] = nil
end

-- Analisar pontuação da cidade
urbos.analisar_cidade = function(name)
	
	-- Controlar bloqueio
	if bloq[name] == true then return end
	urbos[name] = true
	minetest.after(60, desbloquear_analise, name)
	
	local d = urbos.bd.pegar("cidades", name)
		
	-- Varrer areas protegidas
	local pts = 1
	local loop = 1
	local last_check = true -- Controla se ultimo loop encontrou algo valido
	while (loop <= 10 and last_check == true) do
		last_check = false
		local passo = loop*s_protect.claim_size
		
		for x=d.pos.x-passo, d.pos.x+passo, s_protect.claim_size do
		
			for z=d.pos.z-(loop*s_protect.claim_size), d.pos.z+(loop*s_protect.claim_size), s_protect.claim_size do
			
				-- Apenas nas bordas
				if x == d.pos.x-passo or x == d.pos.x+passo
					or z == d.pos.z-passo or z == d.pos.z+passo
				then
					
					-- Verificar se o quadrado foi protegido
					if minetest.is_protected({x=x, y=d.pos.y, z=z}, "urbos:test") == true then
						pts = pts + 1
						last_check = true
					end
				end
				
			end
		end
		
		loop = loop + 1
	end
	
	-- Salva nova pontuacao
	d.pts = pts
	urbos.bd.salvar("cidades", name, d)
	
	-- Atualiza ranking
	urbos.update_rank(name)
end


