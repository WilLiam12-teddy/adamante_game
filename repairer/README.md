# Repairer 

[Minetest Mod] Replaces "Unknow Node" with another Node chosen by the server administrator.

![screenshot]

### LICENSE:

* [GNU-GPL-3.0-or-later]

### REPOSITORY:

* [https://gitlab.com/lunovox/repairer](https://gitlab.com/lunovox/repairer)


### DEPENDENCIES:

* **Mandatory:** 
	* [default] (Internal to Minetest Game)
	* [screwdriver] (Internal to Minetest Game)

* **Optional:** 
	* [intllib] (Internationalization library for Minetest.)

### DEVELOPERS:

* **Lunovox Heavenfinder:** 
	* email: [lunovox@disroot.org]
	* homepage: [libreplanet.org#User:Lunovox]
	
### COMMANDS:

* Replaces a particular disabled mod node with an active mod node, the next time the server is reactivated.
	* ````/repb <OldNode> [<NewNode>]````
	* ````/replaceblock <OldNode> [<NewNode>]````
	* ````/repairblock <OldNode> [<NewNode>]````

* Stop replacing a particular disabled mod node, the next time the server is reactivated.
	* ````/stoprb <OldNode>````
	* ````/stoprepb <OldNode>````
	* ````/stopreplaceblock <OldNode>````
	* ````/stoprepairblock <OldNode>````

### SETTINGS:

These are the settings saved in the '````minetest.conf````' file.

* ````repairer.printInPublicChat = true```` ← Print map repairs in public chat. Default: true

[screenshot]:https://gitlab.com/lunovox/repairer/-/raw/master/screenshot.png
[GNU-GPL-3.0-or-later]:https://gitlab.com/lunovox/repairer/-/raw/master/LICENSE
[default]:https://github.com/minetest/minetest_game/
[screwdriver]:https://github.com/minetest/minetest_game/
[intllib]:https://github.com/minetest-mods/intllib
[lunovox@disroot.org]:mailto:lunovox@disroot.org
[libreplanet.org#User:Lunovox]:https://libreplanet.org/wiki/User:Lunovox
