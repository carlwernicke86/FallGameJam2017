local playerDeath = class("playerDeath")

function playerDeath:initialize(parent)
	self.parent = parent

	self.deathTimer = 2
	self.playerDead = false

	self.endGame = false
	self.endTimer = 8
end

function playerDeath:update(dt)
	if self.playerDead and (not self.endGame) then
		self.deathTimer = self.deathTimer - dt
		if self.deathTimer <= 0 then
			self.playerDead = false
			self.deathTimer = 2
			self.parent:unloadLevel()
			self.parent:nextLevel()
		end
	end

	if self.endGame then
		self.endTimer = self.endTimer - dt
		if self.endTimer <= 0 then love.event.quit() end
	end
end

function playerDeath:die()
	self.playerDead = true
end

return playerDeath