-- register the privileges needed for the player to use the lua command.

-- prefix during development to avoid problems with luacmd.
local devp = ""

local priv = devp.."lua"
local privs = { [priv] = true }



minetest.register_privilege(priv, {
	description = "grants the player the ability to execute arbitary lua code (DANGEROUS)",
	give_to_singleplayer = false
})



return { devp = devp, privs = privs }
