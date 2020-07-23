minetest.register_chatcommand(modCorreio.translate("broadcast"), modCorreio.getPropCommBroadcast(modCorreio.translate("broadcast")))
minetest.register_chatcommand(modCorreio.translate("delolds"), modCorreio.getPropCommDeleteOldMails(modCorreio.translate("delolds")))
--minetest.register_chatcommand(modCorreio.translate("do"), modCorreio.getPropCommDeleteOldMails(modCorreio.translate("do")))

minetest.register_chatcommand(modCorreio.translate("sendmail"), modCorreio.getPropCommSendMail(modCorreio.translate("sendmail")))
minetest.register_chatcommand(modCorreio.translate("mail"), modCorreio.getPropCommSendMail(modCorreio.translate("mail")))
--minetest.register_chatcommand(modCorreio.translate("sm"), modCorreio.getPropCommSendMail(modCorreio.translate("sm")))

minetest.register_chatcommand(modCorreio.translate("readmail"), modCorreio.getPropCommShowMailBox(modCorreio.translate("readmail")))
minetest.register_chatcommand(modCorreio.translate("showmail"), modCorreio.getPropCommShowMailBox(modCorreio.translate("showmail")))
minetest.register_chatcommand(modCorreio.translate("read"), modCorreio.getPropCommShowMailBox(modCorreio.translate("read")))
minetest.register_chatcommand(modCorreio.translate("inbox"), modCorreio.getPropCommShowMailBox(modCorreio.translate("inbox")))
--minetest.register_chatcommand(modCorreio.translate("rm"), modCorreio.getPropCommShowMailBox(modCorreio.translate("rm")))
--minetest.register_chatcommand(modCorreio.translate("sm"), modCorreio.getPropCommShowMailBox(modCorreio.translate("sm")))
--minetest.register_chatcommand(modCorreio.translate("ib"), modCorreio.getPropCommShowMailBox(modCorreio.translate("ib")))

minetest.register_chatcommand(modCorreio.translate("clearmails"), modCorreio.getPropCommDeleteReadMails(modCorreio.translate("clearmails")))
--minetest.register_chatcommand(modCorreio.translate("cm"), modCorreio.getPropCommDeleteReadMails(modCorreio.translate("cm")))