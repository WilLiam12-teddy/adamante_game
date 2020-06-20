[Mod] ds_sailboat [140928] [ds_sailboat]

Mod to add a Sail Boat to MineTest

Picture - https://sites.google.com/site/dsminetest/ds_mods/ds_sailboat

GitHub: https://github.com/deasanta/minetest-deasanta
Download: https://github.com/deasanta/minetest-deasanta/archive/master.zip

License: see README.txt or below
Models: WTFPL
Textures: WTFPL

Features:
 - Sail Boat de-spawn after 7 seconds if not used
 - Boat on_step executes every 10 steps instead of eve
 - Other players can disengage a player
 
Compatibility:
This mod should work with on MineTest 0.4.10

Installation: extract ds_sailboat folder to mods folder

Recipes
Sail Boat = {
	{"", "", ""},
	{"", "", ""},
	{"boats:boat", "boats:boat", "boats:boat"},
},

Notes:
 - bug as of 30/6/13 with player position not updating on other player screens in certain situations.
 - can be used on land - no plan to fix at the moment as it would require more code on the on_step function
 - download speed of 50kb model can be improved by converting it to other irrlicht compatible format ie obj, 3ds, etc
 
Please report any bugs in github or forum

-------
License
-------
This work by PilzAdam, NeXt, deasanta is free of known copyright restrictions.

See also:
http://minetest.net/
See README.txt in each mod directory for information about other authors.

License:
Sourcecode: WTFPL (see below)
Grahpics: WTFPL (see below)
Models: WTFPL (see below)

minetest - Copyright (C) 2013 celeron55, Perttu Ahola <celeron55@gmail.com

         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO. 
  
  http://www.wtfpl.net/