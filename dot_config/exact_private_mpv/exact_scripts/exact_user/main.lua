local mp = require("mp")

local mods = { "seek", "speed" }

for _, mod in ipairs(mods) do
	local ok, err = pcall(require, "modules/" .. mod)
	if not ok then
		local msg = string.format("Failed to load module '%s': %s", mod, err)
		mp.msg.error(msg)
		mp.osd_message(msg, 3)
	end
end
