local gameUI = class("gameUI")

function gameUI:initialize(parent)
	self.parent = parent
	self.player = nil
	self.hpDisplay = 0
end

function gameUI:update(dt)
	self.player = self.parent.player
	if self.player ~= nil then
		self.hpDisplay = self.player.health.hp
	end
end

function gameUI:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("wip ui " .. self.hpDisplay, 10, 10)
end

return gameUI