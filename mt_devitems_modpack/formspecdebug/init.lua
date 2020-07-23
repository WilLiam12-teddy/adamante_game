--[[
formspec debug block:
has no formspec set by default,
but has a handler which will dump the arguments to on_receive_fields()
to both player chat and the console.
May be useful to test out formspecs;
will need ability to edit metadata though - luacmd/consolelua advised.
]]

-- minetest.chat_send_all doesn't seem to support multiple args like print does.
local count = function(...) return select("#", ...) end
local function _fmt(v, ...)
	local s = tostring(v)
	local n = count(...)
	local appended = (n == 0) and "" or "\t".._fmt(...)
	return s..appended
end
local format = function(...)
	return (count(...) == 0) and "" or _fmt(...)
end
local prn = function(...)
	local line = format(...)
	minetest.chat_send_all(line)
	print(line)
end
local sep = ", "
local coords = function(pos)
	return pos.x..sep..pos.y..sep..pos.z
end

local show_sender = function(sender)
	local base = tostring(sender)
	local extra
	if minetest.is_player(sender) then
		extra = "player: "..sender:get_player_name()
	end
	extra = (extra == nil) and "" or " ("..extra..")"
	return base..extra
end



local dump_on_receive_fields = function(pos, formname, fields, sender)
	prn("-- dump_on_receive_fields() --")
	prn("pos", coords(pos))
	prn("formname", formname)
	prn("fields", dump(fields))
	prn("sender", show_sender(sender))
end



local n = "formspecdebug:block"
local desc = "Formspec debug block\n" ..
	"(set \"formspec\" meta key and right click to test)"

minetest.register_node(n, {
	description = desc,
	tiles = { "formspecdebug_block.png" },
	groups = {oddly_breakable_by_hand=3},
	on_receive_fields = dump_on_receive_fields,
})

