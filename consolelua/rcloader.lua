--[[
Load a set of scripts into a player's environment table,
given the player reference and said table.
The env variable "me" is set to the player reference passed.
The variables "console", "rawprint" and "print" are also set;
the former prints to server console, the latter are raw and default-formatted printers which send things to the player's chat.
Then, attempt to load the following scripts into the env table in this order:
-- the mod's internal rc file (see playerenv.rc.lua)
	please don't edit this directly; use the file below instead.
-- the per-world editable rc file, worldpath/console.rc.lua
It should be noted that this setup takes NO responsibility for the contents of RC files.
Editing any of these is at the admin's risk.

The loader catches rc file errors and returns the first one on error.
Ideally the player should be made aware of this,
as the loading process aborts.
]]

local envdo = dofile(_modpath.."envdo.lua")
local prettyprint = mtrequire("com.github.thetaepsilon.minetest.libmthelpers.prettyprint")
local modpath = _modpath

local i = {}



local mk_chat_printer = function(name, prefix)
	if not prefix then prefix = "" end
	return function(msg) return minetest.chat_send_player(name, prefix..msg) end
end
i.mk_chat_printer = mk_chat_printer
local mk_print = function(rawprint)
	return function(...)
		return rawprint(prettyprint.vfmt(...))
	end
end



local cond = function(c, v) if c then return v else return nil end end
local rcname = "playerenv.rc.lua"
local loadrc = function(userref, env, worldpath, opts, rawprint)
	local print = mk_print(rawprint)

	env.me = userref.ref
	env.myname = userref.name
	env.rawprint = rawprint
	env.print = print

	local list = {
		modpath..rcname,
		worldpath.."/"..rcname,
	}

	local warnings = {}
	local result, err, message, offender
	local fail = false
	for _, rcfile in ipairs(list) do
		result, err, message = envdo.load(env, rcfile, "rc file "..rcfile)
		if result == nil then
			-- skip non-existant files.
			-- TODO: can io error types be distinguished?
			if err ~= "iofail" then fail = true end
		else
			local ok
			ok, message = pcall(result)
			if not ok then
				err = "execfail"
				fail = true
			end
		end

		if fail then
			offender = rcfile
			break
		end
	end

	return not fail, cond(fail, err), cond(fail, message), offender
end
i.loadrc = loadrc



i.eval = envdo.eval



return i
