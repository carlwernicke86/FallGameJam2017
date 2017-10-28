local component = require "comp/component"
local eraseSplash = class("eraseSplash", component)

function eraseSplash:initialize(args)
	component.initialize(self, args)
	self.type = "eraseSplash"
	self.parent.lifespan.time = 99999999
	self.parent.img.color = {r=255,g=255,b=255,a=0}

	self.parent.game.playerDeath.endGame = true
	self.parent.game.ui.endGame = true
end

function eraseSplash:update(dt)
	local phys = self.parent.phys
	local speed = 200
	phys.x = phys.x - speed*dt
	phys.y = phys.y - speed*dt
	phys.w = phys.w + 2*speed*dt
	phys.h = phys.h + 2*speed*dt
end

function eraseSplash:collisionDetected(cols)
	for i, col in ipairs(cols) do
		local ent = col.other.parent
		if ent.id ~= "splash" then
			ent.die = true
		end
	end
end

return eraseSplash