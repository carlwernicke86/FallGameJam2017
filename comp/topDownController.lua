local component = require "comp/component"
local topDownController = class("topDownController", component)

function topDownController:initialize(args)
	component.initialize(self, args)
	self.type = "topDownController"
	
	self.speed = args.speed or 300
	self.accel = args.accel or 5
	self.friction = args.friction or 3
	
	self.phys = self.parent:getComponent("physics")
end

function topDownController:update(dt)
	if not self.phys then self.phys = self.parent:getComponent("physics") end
	if self.phys == nil then crash("topDownController error: No physics component found") end
	
	local input = self.game.inputMan
	
	local movDir = {x=0, y=0}
	if input:keyDown("left") then movDir.x = movDir.x - 1 end
	if input:keyDown("right") then movDir.x = movDir.x + 1 end
	if input:keyDown("up") then movDir.y = movDir.y - 1 end
	if input:keyDown("down") then movDir.y = movDir.y + 1 end
	
	--movement
	local xMove = 0; local yMove = 0

	xMove = -(self.phys.vx - self.speed*movDir.x) * self.accel*dt
	yMove = -(self.phys.vy - self.speed*movDir.y) * self.accel*dt

	self.phys:addVel(xMove, yMove)

	--friction
	self.phys:addVel(-self.phys.vx*self.friction*dt, -self.phys.vy*self.friction*dt)
	
	--debug
	if keyDown("e") then self.phys.col = false else self.phys.col = true end
	
end

return topDownController