local component = require "comp/component"
local rocketSplash = class("rocketSplash", component)

function rocketSplash:initialize(args)
	component.initialize(self, args)
	self.type = "rocketSplash"
end

function rocketSplash:collisionDetected(cols)
	for i, col in ipairs(cols) do
		local ent = col.other.parent
		if ent.id == "player" then
			ent.phys.y = ent.phys.y - 2
			ent.phys.vy = -600
			ent.controller.airControl = false
		end
	end
end

return rocketSplash