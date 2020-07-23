local colourspawner =
	mtrequire("com.github.thetaepsilon.minetest.particleeffects.colourspawner")

local ya = 10
local yd = -10

local mk_fountain = colourspawner.mk({
		amount=200,
		time=10,
		minvel={x=-0.5,y=ya,z=-0.5},
		maxvel={x=0.5,y=ya,z=0.5},
		minacc={x=0,y=yd,z=0},
		maxacc={x=0,y=yd,z=0},
		maxexptime=3,
		maxsize=2,
	}, {
		"00FFFF80",
		"0080FF80",
		"FFFFFFC0",
	}
)

return {
	mk = mk_fountain,
}

