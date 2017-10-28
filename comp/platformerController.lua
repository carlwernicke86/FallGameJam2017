local component = require "comp/component"
local platformerController = class("platformerController", component)

function platformerController:initialize(args)
	component.initialize(self, args)
	self.type = "platformerController"
	
	self.speed = args.speed or 200
	self.accel = args.accel or 16
	self.friction = args.friction or 12
	
	self.jumpForce = args.jumpForce or 420

	self.lowGrav = 1000*0.8
	self.highGrav = 4000*0.8
	
	self.phys = self.parent:getComponent("physics")
end

function platformerController:update(dt)
	if not self.phys then self.phys = self.parent:getComponent("physics") end
	if self.phys == nil then error("platformerController error: No physics component found") end
	
	--movement
	local phys = self.phys
	local input = self.game.inputMan

	--x-movement
	local accel = 12; local maxSpeed = self.speed
	if not phys.onGround then accel = 8 end
	
	if input:keyDown("left") and phys.vx > -maxSpeed then
		phys.vx = phys.vx - (phys.vx + self.speed)*accel*dt
	end
	if input:keyDown("right") and phys.vx < maxSpeed then
		phys.vx = phys.vx - (phys.vx - self.speed)*accel*dt
	end

	--jumping/falling
	if phys.vy > 0 then
		phys.gravScale = self.lowGrav
	else
		if input:keyDown("jump") then phys.gravScale = self.lowGrav
		else phys.gravScale = self.highGrav end
		if not self.airControl then phys.gravScale = self.lowGrav end
	end
	
	--friction
	if phys.onGround and not input:keyDown("left") and not input:keyDown("right") then
		phys.vx = phys.vx - phys.vx*self.friction*dt
	end
	
	--debug
	if keyDown("e") then self.phys.col = false else self.phys.col = true end
	
end

function platformerController:jump()
	if self.phys.onGround then self.phys.vy = -self.jumpForce end
end

function platformerController:sideHit(args)
	if args.side == "up" then
		self.airControl = true
	end
end

function platformerController:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "pounder" and col.side == "in" then
			self.phys.vx = self.phys.vx/2
			self.phys.vy = self.phys.vy/2
		end
	end
end

return platformerController