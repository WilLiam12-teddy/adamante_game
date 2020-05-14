modCorreio = {
	huds = { },
	hud_time = 0,
	hud_delay = (tonumber(minetest.setting_get("correio.hud.delay")) or 5), -- Delay in seconds of notice of arrival of the new message. Need to be longer than 5 seconds to not cause lag on server
	max_days_validate = (tonumber(minetest.setting_get("correio.max_validate_days")) or 30), -- Avoid occupying RAM memory with the mails of players who have forsake the server.
}
