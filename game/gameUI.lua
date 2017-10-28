local gameUI = class("gameUI")

function gameUI:initialize(parent)
	self.parent = parent
	self.player = nil
	self.hpDisplay = 0
	self.display = "Current potion: none"
end

function gameUI:reset()
	self.display = "Current potion: none"
end

function gameUI:update(dt)
	self.player = self.parent.player
	if self.player ~= nil then
		local potionThrower = self.player.potions
		local currentPotion = potionThrower.potions[potionThrower.potionIndex]
		if currentPotion ~= nil then
			self.display = "Current potion: " .. currentPotion.name
		end
	end
end

function gameUI:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.print(self.display, 10, 10)
end

return gameUI