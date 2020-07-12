-- roll on 0.5.0, with modname:foo.lua syntax
local pre = "worldscript"
local wp = minetest.get_worldpath() .. "/"
-- intentional global assignment
worldpath = wp

local byhand = {
  oddly_breakable_by_hand = 3,
}


local e = minetest.chat_send_all
local rightclick = function(...)
  local path = wp.."worldscript.lua"
  local f, err = loadfile(path)
  if not f then
    e("can't run world script: "..err)
  else
    f(...)
  end
end

local n = pre..":block"
local tile = pre.."_block.png"
minetest.register_node(n, {
  description = "Worldscript block",
  tiles = { tile },
  groups = byhand,
  on_rightclick = rightclick,
})