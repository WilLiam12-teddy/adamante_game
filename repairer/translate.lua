local ngettext

--[[
local S = minetest.get_translator('testmod')
minetest.register_craftitem('testmod:test', {
    description = S('I am a test object'),
    inventory_image = 'default_stick.png^[brighten'
})
--]]

if minetest.get_modpath("intllib") then
	if intllib.make_gettext_pair then
		-- New method using gettext.
		repairer.translate, ngettext = intllib.make_gettext_pair()
	else
		-- Old method using text files.
		repairer.translate = intllib.Getter()
	end
elseif minetest.get_translator ~= nil and minetest.get_current_modname ~= nil and minetest.get_modpath(minetest.get_current_modname()) then
	repairer.translate = minetest.get_translator(minetest.get_current_modname())
else
	repairer.translate = function(s) return s end
end
