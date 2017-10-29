local camera = require "libs/hump/camera"

local cameraManager = class("cameraManager")

function cameraManager:initialize(parent)
	self.cam = camera(100,100)
	self.target = nil
	
	self.x = self.cam.x; self.y = self.cam.y
	self.followSpeed = 3
	
	self.targetScale = 1
	self.cam.scale = self.targetScale
	self.scaleSpeed = 1

	self.bound = false
	self.bounds = {l=0, t=0, r=0, b=0}
end

function cameraManager:update(dt)
	if self.target then
		self.x = self.x - (self.x - (self.target.x+self.targetOffset.x))*self.followSpeed*dt
		self.y = self.y - (self.y - (self.target.y+self.targetOffset.y))*self.followSpeed*dt
	end
	
	self.cam.scale = self.cam.scale - (self.cam.scale - self.targetScale)*self.scaleSpeed*dt

	if self.bound then
		local w = love.graphics.getWidth()
		local h = love.graphics.getHeight()
		if self.x-w/2 < self.bounds.l then self.x = self.bounds.l+w/2 end
		if self.y-h/2 < self.bounds.t then self.y = self.bounds.t+h/2 end
		if self.x+w/2 > self.bounds.r then self.x = self.bounds.r-w/2 end
		if self.y+h/2 > self.bounds.b then self.y = self.bounds.b-h/2 end
	end
	
	self.cam:lookAt(math.floor(self.x), math.floor(self.y))
end

function cameraManager:setBounds(l, t, r, b)
	self.bounds = {l=l, t=t, r=r, b=b}
	self.bound = true
end

function cameraManager:unbound()
	self.bound = false
end

function cameraManager:setTarget(target, ox, oy)
	self.target = target
	self.targetOffset = {x=ox or 0, y=oy or 0}
end

function cameraManager:setTargetPos(x, y)
	self.target = {x=x, y=y}
end

function cameraManager:setPos(x, y)
	self.x = x; self.y = y
	self.cam:lookAt(self.x, self.y)
end

function cameraManager:setDimensions(w, h)
	--w and h are the new screen dimensions
end

function cameraManager:getDimensions()
	return {x=self.cam.x - love.graphics.getWidth()/2, y = self.cam.y - love.graphics.getHeight()/2,
		w = love.graphics.getWidth(), h = love.graphics.getHeight()}
end

function cameraManager:setFollowSpeed(speed)
	self.followSpeed = speed
end

function cameraManager:setTargetScale(scale)
	self.targetScale = scale
end

function cameraManager:setScale(scale)
	self.targetScale = scale
	self.cam.scale = scale
end

function cameraManager:getScale()
	return self.cam.scale
end

function cameraManager:worldPos(x, y)
	return self.cam:worldCoords(x, y)
end

return cameraManager