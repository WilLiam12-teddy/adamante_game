modceramics = {}

if minetest.get_modpath("intllib") then
	modceramics.translate = intllib.Getter()
else
	modceramics.translate = function(txt) return (txt or "") end
end

modceramics.register_ceramic = function(objname, def)
	if type(objname)~="nil" and objname~="" then
	
		minetest.register_node("ceramics:"..objname, {
			description = def.description,
			tiles = def.tiles,
			is_ground_content = def.is_ground_content,
			groups = def.groups,
			sounds = def.sounds or "",
		})

		if type(def.recipe)=="table" then
			minetest.register_craft({
				output = 'ceramics:'..objname..' 4',
				recipe = def.recipe
			})
		end

		if type(def.alias)=="table" and #def.alias>=1 then
			for i=1, #def.alias do
				if type(def.alias[i])=="string" and def.alias[i]~="" then
					minetest.register_alias(def.alias[i] ,"ceramics:" .. objname)
				end
			end
		end

		--###################################################################################

		if type(def.description_stair)=="string" and def.description_stair~="" then
			stairs.register_stair(objname, "ceramics:"..objname, 
				def.groups,
				def.tiles,
				def.description_stair,
				def.sounds or ""
			)
			
			if type(def.alias_stair)=="table" and #def.alias_stair>=1 then
				for i=1, #def.alias_stair do
					if type(def.alias_stair[i])=="string" and def.alias_stair[i]~="" then
						minetest.register_alias(def.alias_stair[i] ,"stairs:stair_" .. objname)
					end
				end
			end
		end
	end
end
