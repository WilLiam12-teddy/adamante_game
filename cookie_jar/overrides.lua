-----------------------------------
--COMPATIBILITY WITH FARMING COOKIE
-----------------------------------
if  minetest.registered_items["farming:cookie"] ~= nil then
minetest.override_item("farming:cookie", {
    groups = {confection=1},
})
end
