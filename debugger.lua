debugger = class("debugger")

function debugger:initialize()
	self.msg = "none"
	self.active = false
	self.timer = 0

	self.w = 200; self.h = 40
end

function debugger:update(dt)
	if self.active then
		self.timer = self.timer - dt
		if self.timer < 0 then
			self.active = false
		end
	end
end

function debugger:clear()
	self.msg = ""
	self.timer = 0
	self.active = false
end

function debugger:print(str, dur)
	self.timer = dur or 5
	self.active = true
	self.msg = str
end

function debugger:cat(str, dur)
	if self.active == false then
		self.timer = dur or 5
		self.active = true
		self.msg = ""
	end
	self.msg = self.msg .. str
end

function debugger:draw()
	if self.active then
		love.graphics.setColor(180, 180, 180, 200)
		
		local strw = love.graphics.getWidth() - 54
		
		local width, wrappedtext = love.graphics.getFont():getWrap(self.msg, strw)
		local height = love.graphics.getFont():getHeight()*#wrappedtext
		
		love.graphics.rectangle("fill", 20, 20, width+20, height+20)
		love.graphics.setColor(255,255,255)
		love.graphics.printf(self.msg, 30, 30, strw)
	end
end

return debugger:new()