# TRADELANDS

Protection of land on payment of periodic rate. The Minetest player can set permissions of PVP for his terrain.

**SCREENSHOT IN PORTUGUESE:**
![](https://github.com/Lunovox/tradelands/raw/master/screenshot.png)

**Dependencies:**
  * default → Minetest Game Included
  * dye → Minetest Game Included

**Optional Dependencies:**
  * [intllib](https://github.com/minetest-mods/intllib) → Facilitates the translation of several other mods into your native language, or other languages.
  
**Licence:**
 * GNU AGPL: https://pt.wikipedia.org/wiki/GNU_Affero_General_Public_License

**Developers:**
 * Lunovox Heavenfinder: [email](mailto:lunovox@disroot.org), [xmpp](xmpp:lunovox@disroot.org?join), [social web](http:mastodon.social/@lunovox), [audio conference](mumble:libreplanetbr.org), [more contacts](https:libreplanet.org/wiki/User:Lunovox)

**Settings:**
  * Change the file **'[config.lua](https://github.com/Lunovox/tradelands/blob/master/config.lua)'** to change the initial settings of the mod, such as:
	* Price of protection
	* Expiration time
	* Size of area

**Translate to Others Languages:**

* This mod currently are configured to language:
	* English (Default)
	* [Portuguese](https://raw.githubusercontent.com/Lunovox/tradelands/master/locale/pt.txt)

* To add a new language to this mod just follow the steps below:
	* Enable the complementary mod **'intllib'.**
	* Set your language in **'minetest.conf'** by adding the [````language = <your language>````] property. 
		* Example for French Language: ````language = fr````
	* Make a copy of the file [ **pt.txt** ] in the [ **locale** ] folder that is inside the mod for [````locale/<your_language>.txt````]. 
		* Example for French language: ````locale/fr.txt````
	* Open the file [````locale/<your_language>.txt````] in a simple text editor.
	* Translate all lines. But, just here that stems the right of the equals symbol (=). 
		* Example for French Language: ````Only the Owner = Seul le propriétaire````
	* Send your translated file to [lunovox@openmailbox.org](mailto:lunovox@openmailbox.org).
