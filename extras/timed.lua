-- Contains code derived from "Jail Mod" By kaeza and RAPHAEL (mostly kaeza)
-- Extended by Nigel Garnett starting 2015-08-21
-- license: see license.txt

-- uses extras.runloop
--  extras.runloop
--	extras.boxsize
--	extras.spawnpoint
--	extras.pingkick
--  extras.jail

if extras.runloop~=0 then
    print("[extras] runloop - ACTIVE")
end

if extras.boxsize~=0 then
    print("[extras] runloop - box size "..extras.boxsize)
    minetest.register_privilege("outlander", { description = "Can go more than "..extras.boxsize.." blocks from spawn." })
end

if extras.pingkick~=0 then
    print("[extras] runloop - pingkick - ACTIVE")
end

if extras.jail~=0 then
    print("[extras] runloop - jail - ACTIVE")
end

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

local tick = 0
local boxsize = extras.boxsize
local spawnpoint = extras.spawnpoint

if extras.runloop~=0 then
    local function do_services ()
        --print("tick "..tick)
        for _, player in ipairs(minetest.get_connected_players()) do
            local name = player:get_player_name()
            local privs = minetest.get_player_privs(name)

            -- spawn box handler
            if extras.boxsize~=0 then
                local edge = extras.boxsize
                if privs.outlander then edge = 32767 end
                local pos = vector.round(player:getpos())
                if math.abs(spawnpoint.x-pos.x) > edge  or math.abs(spawnpoint.y-pos.y) > edge or math.abs(spawnpoint.z-pos.z) >edge then
                    minetest.chat_send_all("player "..name.." went too far from spawn (limited to "..edge.." blocks)")
                    player:setpos(spawnpoint)
                end
            end

            -- jail handler
            if extras.jail~=0 then
                if extras.players_in_jail then
                    if extras.players_in_jail[name] then
                        local pp=vector.round(player:getpos())
                        local jj=vector.round(extras.jail_data.jailpos)
                        if (pp.x ~= jj.x) or (pp.y ~= jj.y) or (pp.z ~= jj.z) then
                            minetest.chat_send_player(name, "Back to jail "..name)
                            player:setpos(jj)
                        end
                    end
                end
            end

            -- thin out the slow connections
            if tick==12 then
                tick=0
            else
                tick=tick+1
            end
            if tick==0 and extras.pingkick~=0 then
                if name ~= nil then
                    local pinf = minetest.get_player_information(name)
                    if pinf then
                        local ping = pinf.avg_rtt / 2
                        ping = math.floor(ping * 1000)
                        if ping > 400 then
                            minetest.kick_player(name, "You were kicked for high ping. This server is in LONDON, try a server closer to you or fix your internet connection")
                            minetest.chat_send_all(name .. ". was kicked for high ping (" .. ping .. ")")
                        end
                    end
                end
            end
        end
        minetest.after(5, do_services)
    end
    minetest.after(10, do_services)
end

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

