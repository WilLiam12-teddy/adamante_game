-- uses extras.safepvp

if extras.safepvp~=0 then
    print("[extras] Safe PvP - ACTIVE, "..extras.safepvp.." blocks around spawn")
    local spawn = extras.safepvp
    local spawnpoint=extras.spawnpoint
    if minetest.register_on_punchplayer then
        minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
            local pos = player:get_pos()
            if math.abs(spawnpoint.x-pos.x) < spawn  and math.abs(spawnpoint.y-pos.y) < spawn and math.abs(spawnpoint.z-pos.z) < spawn then
                if hitter:is_player() then
                    minetest.chat_send_player(hitter:get_player_name(), "NO PvP in spawn area")
                end
                return true
            end
            for _,o in pairs(areas:getNodeOwners(pos)) do
                if player:get_player_name() == o then
                    if hitter:is_player() then
                        minetest.chat_send_player(player:get_player_name(), hitter:get_player_name().." was stopped from hitting you.")
                        minetest.chat_send_player(hitter:get_player_name(), player:get_player_name().." is protected here.")
                    end
                    return true
                end
            end
        end)
    end
end

