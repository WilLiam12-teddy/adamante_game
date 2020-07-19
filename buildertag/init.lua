minetest.ranks = {
	{
		name = "builder",
		privs = {fly = true, creative = true},
		color = "#EE6E00",
		tag = "[Builder]",
	},
}

minetest.register_chatcommand("buildertag", {
	params = "<player> <rank>",
	description = "Builder tag for the player.",
	privs = {server = true},
	func = function(name, param)
		local target = param:split(" ")[1] or ""
		local rank = param:split(" ")[2] or ""
		local target_ref = minetest.get_player_by_name(target)
		local rank_ref = elidragon.get_rank_by_name(rank)
		if not rank_ref then 
            return false, "Invalid Rank: " .. rank
		elseif not target_ref then
			return false, "Player not online"
        else
			target_ref:get_meta():set_string("buildertag:buildertag", rank)
			local privs = {}
			for _, r in pairs(elidragon.ranks) do
				for k, v in pairs(r.privs) do
					privs[k] = v
				end
				if r.name == rank then
					break
				end
			end
			minetest.set_player_privs(target, privs)
			minetest.chat_send_all(target .. " is now a " .. minetest.colorize(rank_ref.color, rank_ref.name))
			minetest.update_nametag(target_ref)
		end
	end,
})