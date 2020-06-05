# [CORREIO](https://github.com/lunovox/correio) 📨

Adds mailbox and mail paper that allows ordinary Jogadores, without to use commands, to send messages to each other even if the recipient is not online. The player who receives a message will be warned with a letter symbol on his screen.

### **Screenshot of Mod:**

![](https://raw.githubusercontent.com/Lunovox/correio/master/screenshot.png)

### **Internacionalization**

 * There is still no internationalization in progress!

### **Dependencies:**

  * default (Minetest Game Included)
  * dye (Minetest Game Included)
  * [lib_savevars](https://github.com/Lunovox/lib_savevars) → Library to save variables per others mods in file ````variables.tbl````.

### **Optional Dependencies:**

  * [intllib](https://github.com/minetest-mods/intllib) → Facilitates the translation of several others mods into your native language, or other languages.
  * [Super UFO](https://gitlab.com/lunovox/super-ufo) → Add a UFO that allows the player to have a fly house. 
  * [brazutec](https://github.com/BrunoMine/brazutec) → Mod that adds a laptop to the minetest game
  * lunomobs → Change the way you craft the letter, to include chicken feathers in the recipe

### **Licence:**

 * GNU AGPL: https://pt.wikipedia.org/wiki/GNU_Affero_General_Public_License

### **Developers:**

 * [Lunovox](mailto:lunovox@disroot.org)

### **Settings:**

  * Change the file **'minetest.conf'** to change the initial settings of the mod, such as:
  	* ````correio.hud.delay = 10```` →  Delay in seconds of notice of arrival of the new message. Need to be longer than 5 seconds to not cause lag on server
	* ````correio.max_validate_days = 30```` → Limit how long a mail can be stored inside the mailbox. This prevents emails from players that did abandon the server.

### **Privileges:**

### **Commands:**

 * ````/broadcast <mensagem>```` or ````/publicar <mensagem>```` → Send email to all registered players. You need priv 'postman'.
 * ````/delolds```` → Delete emails that are more than 30 days old on the whole server. Serves to relieve server memory. You need priv 'postman'.
 * ````/mail [<ToPlayer> <Message>]```` or ````/escrever [<Destinatario> <mensagem>]```` → If you do not enter parameters you will open a panel to fill the recipient and the message you want to send. You need priv 'postman'.
 * ````/read```` or ````/inbox```` or ````/ler```` → Displays incoming messages. You need priv 'walkingreader'.
 * ````/clearmails```` or ````/limpar```` → Delete all emails already read by the player. You need priv 'walkingreader'.

### **API:**
 * ````<mails> modCorreio.get_mails(<playername>)```` → Coleta lista de correspondencia de um determinado Jogador.
 * ````<mail> modCorreio.get_mail(<playername>, <mailnumber>)```` → Coleta uma carta de um número específico de um determinado Jogador.
 * ````modCorreio.set_mail(<namefrom>, <nameto>, <message>)```` → Envia uma carta (possivelmente de multiplas) de um Jogador ou NPC para outros Jogador.
 * ````modCorreio.set_broadcast(<namefrom>, <message>)```` → Envia uma carta (possivelmente de multiplas) de um Jogador ou NPC para todos os outros Jogador.
 * ````modCorreio.del_mail(<playername>, <mailnumber>)```` → Apaga uma carta de um número específico de um determinado Jogador.
 * ````<number> modCorreio.get_countunreaded(<playername>)```` →  Retorna o número de carta lidas de um determinado Jogador.
 * ````modCorreio.set_read(<playername>, <mailnumber>, <boolean>)```` → Marca de lida true/false em uma carta de um número específico de um determinado Jogador.
 * ````modCorreio.del_readeds(<playername>)```` →  --[[BUGADO]]-- Apaga todos as cartas lidas de um determinado Jogador.
 * ````modCorreio.chat_delreadeds(<playername>)```` →  --[[BUGADO]]-- Apaga todos as cartas lidas de um determinado Jogador e exibe resultado no chat do jogador.
 * ````modCorreio.del_olds()```` →  Apaga todos as cartas de todos os jogadores que estiverem com mais de 30 dias.
 * ````modCorreio.chat_readmail(<playername>)```` → Exibe graficamente a janela de listagem de email a uma determinado jogador.
 * ````modCorreio.hud_print(<playername>)```` → Exibe graficamente o HUD na tela de um determinado jogador caso haja emails não lidos.
 * ````modCorreio.hud_check()```` → Exibe graficamente o HUD na tela de todos os jogadores onlines se possuirem emails não lidos.

### **Translate to Others Languages:**

* This mod currently are configured to language:
	* English
	* Portuguese

* To add a new language to this mod just follow the steps below:
	* Enable the complementary mod **'intllib'.**
	* Set your language in **'minetest.conf'** by adding the [````language = <your language>````] property. 
		* Example for French Language: ````language = fr````
	* Make a copy of the file [ **pt.txt** ] in the [ **locale** ] folder that is inside the mod for [````locale/<your_language>.txt````]. 
		* Example for French language: ````locale/fr.txt````
	* Open the file [````locale/<your_language>.txt````] in a simple text editor.
	* Translate all lines. But, just here that stems the right of the equals symbol (=). 
		* Example for French Language: ````MAIL LETTER=LETTRE DE COURRIER````

