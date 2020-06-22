# consolelua: run lua statements using commands

This is my own version of [luacmd][1].
Updated to my tastes (mostly formatting related) and with new features.
Now also with 100% more license! though it's public domain anyway, go forth and hack.

Extra features:

* Has the ability to load mod-local and per-world "rc files",
lua scripts which are run inside each player's environment when they log in.
* Comes with a point tool whose callback behaviour can be set per player.
now you can test tool callbacks without having to fiddle with get_pos().

[1]: https://github.com/prestidigitator/minetest-mod-luacmd
