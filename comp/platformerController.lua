local component = require "comp/component"
local platformerController = class("platformerController", component)
local sound = love.audio.newSource("res/sound/jump.wav", "static")
sound:setVolume(0.5)
jump_sound = false

function platformerController:initialize(args)
	component.initialize(self, args)
	self.type = "platformerController"
	
	self.speed = args.speed or 200
	self.accel = args.accel or 16
	self.friction = args.friction or 12
	
	self.jumpForce = args.jumpForce or 420

	self.lowGrav = 1000*0.8
	self.highGrav = 4000*0.8

	self.faceDir = 1
	
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

	local moveDir = 0
	if input:keyDown("left") then moveDir = moveDir - 1 end
	if input:keyDown("right") then moveDir = moveDir + 1 end

	if moveDir < 0 then self.faceDir = -1 end
	if moveDir > 0 then self.faceDir = 1 end
	self.parent.img.sx = self.faceDir
	self.parent.img.ox = (self.faceDir-1)*-16

	if moveDir ~= 0 then
		phys.vx = phys.vx - (phys.vx - self.speed*moveDir)*accel*dt
	end

	--jumping/falling
	if phys.vy > 0 then
		phys.gravScale = self.lowGrav
		jump_sound = false
	else
		if input:keyDown("jump") then 
			phys.gravScale = self.lowGrav
			if not jump_sound then
				sound:play()
				jump_sound = true
			end
		else phys.gravScale = self.highGrav end
		if not self.airControl then phys.gravScale = self.lowGrav end
	end
	
	--friction
	if phys.onGround and not input:keyDown("left") and not input:keyDown("right") then
		phys.vx = phys.vx - phys.vx*self.friction*dt
	end
	
	--debug
	if keyDown("e") and require("prefs").debug then
		self.phys.col = false
		self.hax = true
	else
		self.phys.col = true
		self.hax = false
	end
	
end

function platformerController:jump()
	if self.phys ~= nil then
		if self.phys.onGround or self.hax then self.phys.vy = -self.jumpForce end
	end
end

function platformerController:sideHit(args)
	if args.side == "up" then
		self.airControl = true
	end
end

function platformerController:collisionDetected(cols)
end

return platformerController