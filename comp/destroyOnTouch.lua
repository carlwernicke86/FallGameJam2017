local component = require "comp/component"
local destroyOnTouch = class("destroyOnTouch", component)

function destroyOnTouch:initialize(args)
	component.initialize(self, args)
	self.type = "destroyOnTouch"
end

function destroyOnTouch:sideHit(args)
	self.parent.die = true
end

return destroyOnTouch