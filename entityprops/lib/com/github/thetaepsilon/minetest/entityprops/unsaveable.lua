--[[
unsaveable.lua
helper routines and callbacks for visual-only entities that should not be saved.
]]
local i = {}

--[[
define an activate function that wraps a "real" constructor for the object.
if staticdata happens to be empty, the object self-deletes.
the net effect of this is that the entity, assuming it has a nil get_staticdata callback,
effectively becomes "unsaveable" and will disappear when loaded invididually again,
and that the object can only exist when set up by a parent object.
this is because MT in general doesn't always load attached parents on reload,
resulting in the object becoming detached -
the only reliable way to re-construct the attachments is to spawn them fresh from the parent object.
only makes sense in combination with the add_entity_with_staticdata flag!
]]

--[[
technically, if the object never constructs when activated by being loaded in,
then the staticdata is free to be a non-string since it (see above assumption)
will never have to be saved to a string for storage.
therefore we have to look out for an empty string or nil, but let anything else through.
]]
local is_maploaded_empty = function(s)
	local t = type(s)

	if t == "nil" then
		return true
	elseif t == "string" and #s < 1 then
		return true
	end

	return false
end

local mk_unsaveable_activate = function(on_activate)
	on_activate = on_activate or function() end
	return function(self, staticdata, ...)
		if is_maploaded_empty(staticdata) then
			self.object:remove()
		else
			return on_activate(self, staticdata, ...)
		end
	end
end
i.mk_unsaveable_activate = mk_unsaveable_activate

return i
