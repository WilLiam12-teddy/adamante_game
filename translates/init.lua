local path = minetest.get_modpath(minetest.get_current_modname())

local language = core.setting_get("language")
if language== nil or language=="" then
	language = "pt"
	core.setting_set("language", language)
end
local translatefile = path.."/languages/".. language ..".lua"

if io.open(translatefile) then
	dofile(translatefile)
	
	if translate~=nil then
		for _,item in ipairs(translate) do
			if item~=nil and #item==2 and item[1]~= nil and item[1]~= "" and item[2]~= nil and item[2] ~= "" then
				if minetest.registered_items[item[1]] ~= nil then
					local props = minetest.registered_items[item[1]]
					props.description = item[2]
					local ItemID = item[1]
					if props.type == "node" then
						minetest.register_node(":"..ItemID, props)
					elseif props.type == "tool" then
						minetest.register_tool(":"..ItemID, props)
					elseif props.type == "ore" then
						minetest.register_ore(":"..ItemID, props)
					elseif props.type == "craft" then --craft nao se traduz
						minetest.register_craftitem(":"..ItemID, props)
					else
						print("dump(props)='"..dump(props).."'")
					end
					--print("dump(minetest.registered_items[ItemID])='"..dump(minetest.registered_items[ItemID]).."'")
				end
			end
		end
		minetest.log('action','[TRANSLATE] Carregado!')
	end
else
	minetest.log('erro',"[TRANSLATE] Arquivo de traducao '"..translatefile..".lua' nao encontrado!")
end

