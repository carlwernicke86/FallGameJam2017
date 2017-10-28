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
	if self.health.hp >= self.health.maxHP then
		self.healthBar.color.a = 0
	else
		self.healthBar.color.a = 255
	end
end

return healthBarUpdate