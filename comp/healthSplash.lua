local component = require "comp/component"
local healthSplash = class("healthSplash", component)

function healthSplash:initialize(args)
	component.initialize(self, args)
	self.type = "healthSplash"
end

function healthSplash:collisionDetected(cols)
	for i, col in ipairs(cols) do
		local health = col.other.parent:getComponent("health")
		if health ~= nil then
			health:startHealing()
		end
	end
end

return healthSplash