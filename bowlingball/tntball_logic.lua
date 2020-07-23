--[[
A variant on the ball which, instead of rebounding on zero velocity,
explodes if it accelerated or decelerated too quickly.
]]

local ydebug = print
local ndebug = function() end
local debug = ydebug



-- the minimum magnitude of acceleration to cause explosion
local crit = 200
-- explosion parameters
local r = 5
tntdef = {
	radius = r,
	damage_radius = r,
}

local step = function(self, dtime)
	local oldv = self.previous
	local o = self.object
	local newv = o:get_velocity()

	-- again, only run processing if we have a previous velocity for reference.
	if oldv then
		-- measure the difference in the velocities.
		local vdiff = vector.distance(newv, oldv)
		-- acceleration: ms^-2, velocity: ms^-1
		-- divide by dtime to get acceleration over that period.
		local adiff = vdiff / dtime
		-- pushed around too hard?
		if adiff > crit then
			-- KABOOM
			debug("tntball velocities: adiff="..adiff)
			local pos = o:get_pos()
			o:remove()
			tnt.boom(pos, tntdef)
		end
	end

	self.previous = newv
end



return step

