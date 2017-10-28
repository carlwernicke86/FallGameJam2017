local playerDeath = class("playerDeath")

function playerDeath:initialize(parent)
	self.parent = parent

	self.deathTimer = 2
	self.playerDead = false
end

function playerDeath:update(dt)
	if self.playerDead then
		self.deathTimer = self.deathTimer - dt
		if self.deathTimer <= 0 then
			self.playerDead = false
			self.deathTimer = 2
			self.parent:unloadLevel()
			self.parent:nextLevel()
		end
	end
end

function playerDeath:die()
	self.playerDead = true
end

return playerDeath