repairer.doPrint = function(message, playername)
	if type(repairer.message)=="nil" or repairer.message ~= message then --Evita que a message no chat seja repetida!!!!
		repairer.message = message
		if type(playername)=="string" and playername:trim()~="" then
			minetest.chat_send_player(playername, message)
		elseif repairer.isPrintInPublicChat then
			--if minetest.setting_getbool("log_mods") then minetest.chat_send_all(message)	end
			minetest.chat_send_all(message)
		end
	end
	minetest.log("action", core.strip_colors(message)) --so grava a message se o arquivo 'minetest.conf' permitir.
	--print(message)--Imprime no terminal de controle independente se é ou nao gravado o Log ou avisado ao jogador sobre o ocorrido.
end

repairer.doSave = function()
	local file = io.open(repairer.urlTabela, "w")
	if file then
		file:write(minetest.serialize(repairer.replace))
		file:close()
	end
end

repairer.doLoad = function()
	local file = io.open(repairer.urlTabela, "r")
	if file then
		repairer.replace = minetest.deserialize(file:read("*all"))
		file:close()
		if type(repairer.replace) ~= "table" then
			minetest.log('erro',
				"[REPAIRER:ERRO] "
				..repairer.translate("The file '%s' is not in table format!"):format(repairer.urlTabela)
			)
			return
		end
		if not repairer.replace.nodes then repairer.replace.nodes = {} end
		if not repairer.replace.entities then repairer.replace.entities = {} end
	end
end

repairer.doFindNodes = function()
	if #repairer.replace.nodes >=1 then
		local oldBlocks = {}
		local newBlocks = {}
		for _,replace in ipairs(repairer.replace.nodes) do
			oldBlocks[#oldBlocks + 1] = replace[1]:trim()
			newBlocks[replace[1]:trim()] = replace[2]:trim()
		end
		
		minetest.register_abm({
				nodenames = oldBlocks,
				interval = 1,
				chance = 1,
				action = function(pos, node)
					local old = node.name:trim()
					local new = newBlocks[old]:trim()
					repairer.doPrint(
						core.colorize("#8888ff", "[REPAIRER]")..": "
						..repairer.translate("Replacing '%s' with '%s' in %s."):format(
							core.colorize("#ff0000", old), 
							core.colorize("#00ff00", new), 
							minetest.pos_to_string(pos)
						)
					)
					local meta_old = minetest.get_meta(pos)
					minetest.env:set_node(pos, {name=new})
					local meta_new = minetest.get_meta(pos)
					meta_new = meta_old
				end,
			})
	end
end

repairer.doCommandReplaceBlock = function(playername, param)
	local block_old = nil
	local block_new = nil
	block_old, block_new = string.match(param, "^([^ ]+) +([^ ]+)$")
	if type(block_old)~="string" or block_old:trim() == "" then
		block_old = string.match(param, "^([^ ]+)$")
		block_new = "air"
	end

	if type(block_old)=="string" and block_old:trim() ~= "" and type(block_new)=="string" and block_new:trim() ~= "" then
	
		if not minetest.registered_items[block_new] then
			repairer.doPrint(
				core.colorize("#ff0000", "[REPAIRER:ERRO]")..": "
				..repairer.translate("The New-Block '%s' does not exist, or has not been previously registered."):format(block_new)
			,playername)
			return true
		end

		for _, old in ipairs(repairer.replace.nodes) do
			if old[1]:trim() == block_old:trim() then
				repairer.doPrint(
					core.colorize("#ff0000", "[REPAIRER:ERRO]")..": "
					..repairer.translate("The Old-Block '%s' was already registered in the cleaning list."):format(block_old:trim())
				,playername)
				return true
			end
		end
		
		repairer.replace.nodes[#repairer.replace.nodes + 1] = { block_old:trim(), block_new:trim() }
		repairer.doSave()
		repairer.doFindNodes()
		repairer.doPrint(
			core.colorize("#00ff00", "[REPAIRER:OK]")..": "
			..repairer.translate("The Old-Block '%s' will be replaced with '%s'!"):format(block_old, block_new)
		,playername)
		return true
	else
		repairer.doPrint(
			core.colorize("#ff0000", "[REPAIRER:ERRO]").." /repb <"..repairer.translate("OldBlock").."> [<"..repairer.translate("NewBlock")..">]"
			..core.colorize("#888888", 
				"\n\t* "..repairer.translate("Replaces a disabled mod block with an active mod block.")
				.."\n\t* "..repairer.translate(
					"The parameter [<%s>] is not mandatory. But if it is not declared, [<%s>] will be automatically replaced by air."
				):format("NewBlock", "NewBlock")
			)
		,playername)
		return true
	end
end

repairer.getPropRepBCom = function()
	return  {  -- replaceblock = "Delete Old Blocks"
		params = "<"..repairer.translate("OldBlock").."> [<"..repairer.translate("NewBlock")..">]",
		description = core.colorize("#888888", repairer.translate("Replaces a particular disabled mod block with an active mod block, the next time the server is reactivated.")),	
		privs = {server=true},
		func = function(playername, param)
			return repairer.doCommandReplaceBlock(playername, param)
		end,
	}
end

repairer.getPropStopRepBCom = function()
	return  {  -- replaceblock = "Delete Old Blocks"
		params = "<"..repairer.translate("OldBlock")..">",
		description = core.colorize("#888888", repairer.translate("Stop replacing a particular disabled mod block, the next time the server is reactivated.")),	
		privs = {server=true},
		func = function(playername, param)
			repairer.doPrint(
				core.colorize("#ff0000", "[REPAIRER:ERRO]")..": /stoprb <"..repairer.translate("OldBlock")..">"
				..core.colorize("#888888", 
					"\n\t* "..repairer.translate("Stop replacing a particular disabled mod block, the next time the server is reactivated.")
				)
				..core.colorize("#ff0000", 
					"\n\t* "..repairer.translate("This command has not yet been implemented!")
				)
			,playername)
			return --repairer.doCommandStopRepBlock(playername, param)
		end,
	}
end

