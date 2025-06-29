-- 临时加速播放 + 切换慢速/快速/原速
local mp = require("mp")

local o = {
	desc_speed = 1,
	asc_speed = 2,
}

local prev_speed = nil
local down_speed = nil
local override = nil

local function set_speed(speed)
	if speed ~= mp.get_property_number("speed") then
		mp.command("set speed " .. speed)
	end
end

mp.add_key_binding(nil, "speed", function(ev)
	local post_speed = o[ev.arg .. "_speed"]

	if ev.event == "down" then
		override = true
		down_speed = mp.get_property_number("speed")
		set_speed(post_speed)
	elseif ev.event == "up" then
		-- mp.msg.info(("prev_speed:%s down_speed:%s post_speed:%s"):format(prev_speed, down_speed, post_speed))
		if prev_speed and down_speed == post_speed then
			set_speed(prev_speed)
			return
		end

		if not override then
			set_speed(down_speed)
		else
			if down_speed ~= o.asc_speed and down_speed ~= o.desc_speed then
				prev_speed = down_speed
			end
		end
		mp.msg.info(("prev_speed:%s"):format(prev_speed))
	else
		override = false
	end
end, { complex = true })
