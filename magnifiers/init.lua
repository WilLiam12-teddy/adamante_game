minetest.register_craftitem("magnifiers:magnifier", {
	description = "Lupa (Exibe descricao de item no mapa)",
	image = "obj_lupa.png",
	groups = { glass=1 },
	liquids_pointable = true, -- Pode apontar para node de Liquidos (mais tarde podera coletar agua)
	stack_max=1, --Acumula 1 por slot
	on_use = function(itemstack, user, pointed_thing)
		--[[
			minetest.registered_entities["__builtin:item"].selectionbox = {0,0,0,0,0,0}
			minetest.registered_entities["__builtin:item"].initial_properties.selectionbox = {0,0,0,0,0,0}
			minetest.registered_entities["__builtin:item"].pointable = false
			fonte: https://forum.minetest.net/viewtopic.php?f=47&t=22771
		--]]
		
		local username = user:get_player_name()
		--minetest.chat_send_player(username, "bbbb"..dump(pointed_thing))
		
		if type(pointed_thing)~="nil" and type(pointed_thing.type)~="nil"then
			if pointed_thing.type == "nothing" then
				minetest.chat_send_player(username, "Você está apontando para nada analisável!")
			elseif pointed_thing.type == "object" then
				--minetest.chat_send_player(username, "cccc1"..dump(pointed_thing.ref))
				local pos = minetest.get_pointed_thing_position(pointed_thing, true)
				--minetest.chat_send_player(username, "cccc2"..dump(pos))
				local objs = minetest.get_objects_inside_radius(pos, 1)
				for _, obj in pairs(objs) do
					if type(obj)~="nil" then
						--minetest.registered_entities[mob]
						if obj:is_player() then
							local playername = obj:get_player_name()
							minetest.chat_send_player(username, "Este o(a) jogador(a) '"..minetest.colorize("#00FF00", playername).."'!")
						elseif type(obj:get_luaentity())~="nil" and type(obj:get_luaentity().name)~="nil" then
							local ent = obj:get_luaentity()
							if ent.name=="__builtin:item" then
								if type(ent.itemstring)~="nil" and ent.itemstring~="" then
									local partes_name = ent.itemstring:split(" ")
									if #partes_name > 0 then
										if minetest.get_player_privs(username)["server"] then
											minetest.chat_send_player(username, "###### '"..minetest.colorize("#00FF00", partes_name[1]).."' ########################################################################")
											minetest.chat_send_player(username, dump(ent))
											minetest.chat_send_player(username, "Light="..minetest.env:get_node_light(pos, nil))
										else
											minetest.chat_send_player(username, "Você está apontando para '"..minetest.colorize("#00FF00", partes_name[1]).."'!")
										end
									end
								else
									minetest.chat_send_player(username, "Você está apontando para um item qualquer!")
								end
								--
							else
								minetest.chat_send_player(username, "Você está apontando para '"..minetest.colorize("#FFFF00", ent.name).."'!")
							end
						end
					end
				end
			elseif pointed_thing.type == "node" and type(pointed_thing.under)~="nil" then
				node = minetest.get_node(pointed_thing.under)
				props = minetest.registered_items[node.name]
				if type(props)~="nil" then
					if minetest.get_player_privs(username)["server"] then
						local node = minetest.get_node(pointed_thing.under)
						props = minetest.registered_items[node.name]
						minetest.chat_send_player(username, "###### '"..minetest.colorize("#FFFF00", node.name).."' ########################################################################")
						minetest.chat_send_player(username, minetest.colorize("#CCCCCC", dump(props)))
						minetest.chat_send_player(username, "Light="..minetest.colorize(minetest.env:get_node_light(pointed_thing.above, nil)))
					else
						if props.description~="" then
							minetest.chat_send_player(username, "Isso é '"..minetest.colorize("#00FF00", props.description).."'. ["..minetest.colorize("#FFFF00", node.name).."]")
						else
							minetest.chat_send_player(username, "Isso é '"..minetest.colorize("#FFFF00", node.name).."'")
						end
						local iluminacao = math.floor((minetest.env:get_node_light(pointed_thing.above, nil)/15)*100)
						minetest.chat_send_player(username, "Iluminação: "..minetest.colorize("#8888FF", iluminacao.."%"))
					end
				else
					minetest.chat_send_player(username, "O bloco '"..node.name.."' é um ítem desconhecido de um mod desativado!")
				end
			end
		end
	end,
})

minetest.register_craft({
	output = "magnifiers:magnifier",
	recipe = {
		{"",					"",					"default:glass"},
		{"",					"default:stick",	""},
		{"default:stick",	"",					""},
	},
})

minetest.register_alias("magnifier"	, "magnifiers:magnifier")
minetest.register_alias("lupa"		, "magnifiers:magnifier")
