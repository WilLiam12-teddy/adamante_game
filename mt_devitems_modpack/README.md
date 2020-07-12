# mt_devitems_modpack: useful items and blocks for minetest developers

A bunch of conveinience mods that I wrote to make my life easier during minetest development.
Current mods:

* worldscript:
	Adds a block which executes a script file from the current world directory when right-clicked,
	passing arguments from on_rightclick as the script's varags (...).
	A mod written while cruising in an airplane with only a mobile device to edit on,
	this made it easier to write test lua fragments because the in-game command interface sucks on android.
* formspecdebug:
	Adds a block which prints (rather verbosely, in-game and on console) the data it gets from on_receive_fields.
	It does not set any formspec by default, so something like luacmd is recommended to set the formspec meta field.
