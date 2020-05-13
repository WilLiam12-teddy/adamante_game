print("[extras] library functions loading")

extras.table_empty = function ( tab )
    for key in pairs(tab) do
        return false
    end
    return true
end

extras.getnodepos = function(npos)
	local node = minetest.get_node_or_nil(npos)
    if not node then
		minetest.get_voxel_manip():read_from_map(npos, npos)
		node = minetest.get_node(npos)
	end
    return node
end

extras.setpos = function (pos,obj)
    local count = 0
	local node = extras.getnodepos(pos)
	while node.name ~= "air" do
		pos.y = pos.y + 1
		count = count + 1
    	--obj:setpos(pos)
		node = extras.getnodepos(pos)
   	end
    local name = obj:get_player_name()
    if name ~= "" then
		if count > 1 then
			minetest.chat_send_player(name, " You were rescued from being buried "..count.." meters deep.")
		end
	end
	obj:setpos(pos)
    if count > 1 then
        pos.y = pos.y - count
    end
end


extras.setprivs_jailed = function ( name)
    minetest.chat_send_all("*************************")
    minetest.chat_send_all(name.." has had all privs removed.")
    minetest.chat_send_all("*************************")
    minetest.chat_send_all(name.." is granted shout to explain themselves...")
    local privs = {}
    privs.shout = true
    minetest.set_player_privs(name, privs)
    return true
end

extras.setprivs_released = function ( name)
    minetest.chat_send_all("Granting "..name.." default privs.")
    local privs = {}
    local str = extras.defaultprivs
    for priv in string.gmatch(str, '([^,]+)') do
        privs[priv] = true
    end
    minetest.set_player_privs(name, privs)
    return true
end

if extras.jail~=0 then
    extras.save_jail = function (jail_data)
        print("[extras] jail - saving data")
        if extras.table_empty(jail_data) then
            print("[extras] jail - jail.data was empty on save")
            return
        end
        local data = minetest.serialize( jail_data )
        local path = minetest.get_worldpath().."/jail.data"
        local file = io.open( path, "w" )
        if( file ) then
            file:write( data )
            file:close()
            return true
        else
            return nil
        end
    end

    extras.load_jail = function ()
        print("[extras] jail - loading data")
        local path = minetest.get_worldpath().."/jail.data"
        local file = io.open( path, "r" )
        if( file ) then
            local jail_data = minetest.deserialize( file:read("*all") )
            file:close()
            if extras.table_empty(jail_data) then
                print("[extras] jail - jail.data is empty, deleting")
                os.remove(path)
            end
            return jail_data
        else
            print("[extras] jail - no data to load")
            return {}
        end
    end

    extras.jail_data = extras.load_jail()
    if not extras.jail_data then
        jail_data.jailpos = { x = 0, y = 5000, z = 0 }
        jail_data.releasepos = minetest.setting_get_pos("static_spawnpoint") or {x=0, y=15, z=0}
        extras.save_jail(jail_data)
    end
end

