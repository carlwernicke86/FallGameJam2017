--TODO set font in debugger:draw()

debugger = class("debugger")

function debugger:initialize()
	self.msg = "none"
	self.active = false
	self.timer = 0

	self.w = 200; self.h = 40
	self.alpha = 200
	self.font = nil
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

function debugger:debug(msg, dur, cat)
	dur = dur or 5
	if cat then self:cat(msg, dur)
	else self:print(msg, dur) end
end

function debugger:print(str, dur)
	str = tostring(str)
	self.timer = dur or 5
	self.active = true
	self.msg = str
end

function debugger:cat(str, dur)
	str = tostring(str)
	if self.active == false then
		self:print("", dur)
	end
	self.msg = self.msg .. str
end

function debugger:draw()
	local lg = love.graphics
	if self.active then
		lg.setColor(180, 180, 180, self.alpha)
		
		local strw = lg.getWidth() - 54
		
		local width, wrappedtext = lg.getFont():getWrap(self.msg, strw)
		local height = lg.getFont():getHeight()*#wrappedtext
		
		lg.rectangle("fill", 20, 20, width+20, height+20)
		lg.setColor(255,255,255)
		lg.printf(self.msg, 30, 30, strw)
	end
end

function debugger:setAlpha(alpha)
	self.alpha = alpha
end

function debugger:setFont(font)
	self.font = font
end

return debugger:new()