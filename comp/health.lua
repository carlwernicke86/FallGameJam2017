local component = require "comp/component"
local health = class("health", component)

function health:initialize(args)
	component.initialize(self, args)
	self.type = "health"
	self.maxHP = args.maxHP or 10
	self.hp = self.maxHP

	self.burning = false
	self.burnTime = 0

	self.healing = false
	self.healTime = 0
end

function health:update(dt)

	if self.burning then
		self.hp = self.hp - 6*dt
		self.burnTime = self.burnTime - dt
		if self.burnTime <= 0 then self.burning = false end
	end

	if self.healing then
		self.hp = self.hp + 8*dt
		self.healTime = self.healTime - dt
		if self.healTime <= 0 then self.healing = false end
	end

	if self.hp <= 0 then
		self.parent.die = true
	end

	if self.hp > self.maxHP then
		self.hp = self.maxHP
	end

	--debug(self.hp)
end

function health:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "fire" then
			self:startBurning()
		end
	end
end

function health:startBurning()
	self.burning = true
	self.burnTime = 1
end

function health:startHealing()
	self.healing = true
	self.healTime = 0.5
end

return health