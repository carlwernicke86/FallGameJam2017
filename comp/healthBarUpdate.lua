local component = require "comp/component"
local healthBarUpdate = class("healthBarUpdate", component)

function healthBarUpdate:initialize(args)
	component.initialize(self, args)
	self.healthBar = args.healthBar
	self.maxWidth = self.healthBar.w
	self.health = args.health
end

function healthBarUpdate:update(dt)
	self.healthBar.w = (self.health.hp/self.health.maxHP)*self.maxWidth
end

return healthBarUpdate