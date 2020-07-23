local mk_colour_spawner = function(base, cl)
	local basetex = "default_stone.png"

	return function(mt, overrides)
		local props = table.copy(base)
		for k, v in pairs(overrides) do props[k] = v end
		for _, c in ipairs(cl) do
			local texture = basetex.."^[colorize:#000000:255^[invert:rgb^[colorize:#"..c..":255"
			props.texture = texture
			mt.add_particlespawner(props)
		end
	end
end

return {
	mk = mk_colour_spawner,
}

