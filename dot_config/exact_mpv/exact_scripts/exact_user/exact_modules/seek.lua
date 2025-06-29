local mp = require("mp")

local o = {
	small_step = 1,
	large_step = 10,
	use_exact = false,
	use_percent = false,
}

local function do_seek(amount)
	local args = { "seek", amount }
	if o.use_percent then
		table.insert(args, "relative-percent")
	else
		table.insert(args, "relative")
	end
	if o.use_exact then
		table.insert(args, "exact")
	else
		table.insert(args, "keyframes")
	end
	mp.command(table.concat(args, " "))
end

mp.add_key_binding(nil, "seek", function(ev)
	if ev.event == "down" or ev.event == "repeat" then
		do_seek(ev.arg)
	end
end, { complex = true })

mp.add_key_binding(nil, "seek-toggle-exact", function()
	o.use_exact = not o.use_exact
	mp.osd_message("Exact seek: " .. tostring(o.use_exact))
end)

mp.add_key_binding(nil, "seek-toggle-mode", function()
	o.use_percent = not o.use_percent
	mp.osd_message("Seek mode: " .. (o.use_percent and "relative-percent" or "relative"))
end)
