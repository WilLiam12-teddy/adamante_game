local have_banmod = minetest.get_modpath("xban2")
--local have_jailmod = minetest.get_modpath("jail")


minetest.register_privilege("willadmin", {
    description = "Privilege required to use admin tools.",
    give_to_singleplayer = false
})

local function handle_tool(itemstack, player, pointed_thing, hitter_item)
	if pointed_thing.type ~= "object" then
		return
	end
	if not pointed_thing.ref:is_player() then
		return
	end
	local hitter_name = player:get_player_name()
	local punched_name = pointed_thing.ref:get_player_name()
	local hitter_privs = minetest.get_player_privs(hitter_name)
	print(hitter_item)
	
	if hitter_privs.willadmin then
		if hitter_privs.kick == true and hitter_item == "kickstick" then
			minetest.kick_player(punched_name)
			return
		elseif hitter_privs.ban == true and hitter_item == "banhammer" then
			if have_banmod then
				xban.ban_player(punched_name,hitter_name,nil,"You Were hit with the Banhammer." )
			else
				minetest.ban_player(punched_name)
			end
			return
-- 		elseif hitter_privs.jail == true and hitter_item == "jailtool" then
-- 			--jail.jail(punched_name)
-- 			return
		end
	else
		minetest.chat_send_player(hitter_name, "You need willadmin priv to use this tool.")
	end
end


print("[willadmin] adding kickstick")
minetest.register_craftitem("willadmin:kickstick", {
    description = "Kick Stick - click on the bad player.",
    inventory_image = "kickstick.png",
	wield_image = "kickstick.png",
	on_use = function(itemstack, player, pointed_thing)
		handle_tool(itemstack, player, pointed_thing, "kickstick")
		return itemstack
	end,
})

print("[willadmin] adding banhammer")
minetest.register_craftitem("willadmin:banhammer", {
	description = "Ban Hammer - click on the bad player. (take care!)",
	inventory_image = "banhammer.png",
	wield_image = "banhammer.png",
	on_use = function(itemstack, player, pointed_thing)
		handle_tool(itemstack, player, pointed_thing, "banhammer")
		return itemstack
	end,
})

--if have_jailmod then
-- 	print("[willadmin] adding jailtool")
-- 	minetest.register_craftitem("willadmin:jailtool", {
-- 		description = "Jail Tool - click on the bad player.",
-- 		inventory_image = "jailtool.png",
-- 		wield_image = "jailtool.png",
-- 		on_use = function(itemstack, player, pointed_thing)
-- 			handle_tool(itemstack, player, pointed_thing, "jailtool")
-- 			return itemstack
-- 		end,
-- 	})
--else
--	print("[willadmin] NOT adding jailtool - mod jail not found")
--end
