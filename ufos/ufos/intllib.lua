local ngettext
if minetest.get_modpath("intllib") then
	if intllib.make_gettext_pair then
		-- New method using gettext.
		modUFO.translate, ngettext = intllib.make_gettext_pair()
	else
		-- Old method using text files.
		modUFO.translate = intllib.Getter()
	end
else
	modUFO.translate = function(s) return s end
end
