local i = {}

local mk_preserve_newlines = function(f)
	return function()
		-- file:lines() returns lines with newline chars stripped.
		-- this clashes with the semantics of comments;
		-- re-add the newline char if the iterator didn't indicate termination.
		local v = f()
		return v and (v.."\n") or nil
	end
end
-- loads a file inside an environment but doesn't call it.
-- dofile is a bit annoying here as it does not automatically inherit setfenv.
-- instead, we implement it ourself in a deferred manner.
-- load each line from the file, setfenv on the resulting chunk, and return that.
-- the caller then has to actually invoke it.
-- label is optional but helps with diagnostics.
local makeroset = function(list)
	local result = {}
	for _, v in ipairs(list) do result[v] = v end
	return result
end

local e_iofail = "iofail"
local e_loadfail = "loadfail"
local enum = makeroset({e_iofail, e_loadfail})
i.enum_loadfail = enum

local envload = function(env, filename, label)
	local result, err, message
	local file, message = io.open(filename, "r")
	if file == nil then return nil, e_iofail, message end
	result, message = load(mk_preserve_newlines(file:lines()), label)
	if result == nil then
		err = e_loadfail
	else
		setfenv(result, env)
	end
	return result, err, message
end
i.load = envload

-- interestingly, loadstring reacts differently to being explicitly passed a nil for the second arg,
-- as opposed to simply omitting the label argument.
local loadst = function(st, label)
	if label then
		return loadstring(st, label)
	else
		return loadstring(st)
	end
end

-- calls the result of loadstring inside a specified environment.
local enveval = function(env, st, label)
	local result, err, message

	result, message = loadst(st, label)
	if not result then
		err = e_loadfail
	else
		setfenv(result, env)
	end

	return result, err, message
end
i.eval = enveval

return i
