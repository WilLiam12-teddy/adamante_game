-- main execution environment for player commands.
-- supports "execute this statement", "reload rc", and "reset" operations.
-- when initially constructed the reset behaviour is triggered.

local modpath = _modpath
local rcloader = dofile(modpath.."rcloader.lua")
local eval = rcloader.eval
local i = {}

local tableutils = mtrequire("com.github.thetaepsilon.minetest.libmthelpers.tableutils")
local prettyprint = mtrequire("com.github.thetaepsilon.minetest.libmthelpers.prettyprint")



-- the "chat" object used below to send feedback to the player.
local send = minetest.chat_send_player
local err_throw = function(self, msg) self:send("[lua exception] "..msg) end
local err_syntax = function(self, msg) self:send("[lua syntax error] "..msg) end
local send_result = function(self, msg) self:send("[lua result]  "..msg) end
local send_raw = function(self, msg) return self.userref:sendtext(msg) end

local mk_chat = function(userref)
	local self = {
		userref = userref,
		send = send_raw,
		err_throw = err_throw,
		err_syntax = err_syntax,
		send_result = send_result,
	}
	return self
end



local reload = function(self)
	local opts = {}
	local chat = self.chat
	local rawprint = function(msg) return chat:send(msg) end
	local ok, err, message, offender = rcloader.loadrc(self.userref, self.env, self.worldpath, opts, rawprint)
	if not ok then
		local failmsg = "reload failed while loading "..offender..": "..err..": "..message
		local abortmsg = "environment load has been aborted due to previous errors."
		local msgs = { failmsg, abortmsg }
		for _, msg in ipairs(msgs) do chat:send("[consolelua warning] "..msg) end
	end
	return ok
end

-- capture of the global namespace at load time.
local extenv = _G
-- reset the environment to everything globally visible then re-load rc files.
local reset = function(self)
	self.env = tableutils.shallowcopy(extenv)
	return reload(self)
end



local vsfmt = prettyprint.vsfmt
local sep = ", "
local vfmt_if_nonempty = function(...)
	if select("#", ...) > 0 then return vsfmt(sep, ...) end
end
-- the compiled statement may throw due to bad indexes, incompatible operations etc.
-- in order to preserve the number of varargs potentially returned from an eval'd chunk,
-- we have to try to format the results inside pcall.
local vfmt_result = function(env, f) return vfmt_if_nonempty(f()) end
local exec = function(self, st)
	local chat = self.chat
	local success = true

	local chunk, err, message
	chunk, err, message = eval(self.env, st, self.cmdlabel)
	if not chunk then
		chat:err_syntax(message)
		success = false
	else
		local result
		success, result = pcall(vfmt_result, self.env, chunk)
		if not success then
			chat:err_throw(result)
		else
			if result then chat:send_result(result) end
		end
	end

	return success
end



local construct = function(userref, worldpath)
	local self = {}
	self.userref = userref
	self.worldpath = worldpath
	self.chat = mk_chat(userref)
	reset(self)

	self.cmdlabel = "lua command"
	self.exec = exec
	self.reset = reset
	self.reload = reload

	return self
end
i.new = construct



return i
