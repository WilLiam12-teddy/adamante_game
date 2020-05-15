# lib_savelogs
[Minetest Mod] Registers server events (on and off), too player events (join and leave), and events of other mods in ````log_[date].txt```` files in the map folder.

## Depends:
 * No have any depends.

## License:
 * [GNU AGPL v3.0](https://github.com/Lunovox/lib_savelogs/blob/master/LICENSE)
 
## Developers:
 * [Lunovox Heavenfinder](https://libreplanet.org/wiki/User:Lunovox)

## Methods:
 * ````<pos> libSaveLogs.getPosResumed(<pos>)```` - Return the resumed 3d position from a float 3d position (<x>,<y>,<z>).
 * ````libSaveLogs.addLog(<message>[, <noTime>])```` - Register message log to memory RAM. if ````<noTime>```` is ````true```` then hide event time of register.
 * ````libSaveLogs.doSave()```` - Save the log from ram memory to file ````log_[date] .txt````.

## Sample Use:
````
  libSaveLogs.addLog("Player 'foobar' rider the home of 'barfoo'.") -- Add log event.
  libSaveLogs.doSave() -- Save all
````
