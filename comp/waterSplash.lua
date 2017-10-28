local component = require "comp/component"
local waterSplash = class("waterSplash", component)

function waterSplash:initialize(args)
	component.initialize(self, args)
	self.type = "waterSplash"
end

function waterSplash:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "fire" or col.other.parent.id == "breakableWall" then
			col.other.parent.die = true
		end
	end
end

return waterSplash