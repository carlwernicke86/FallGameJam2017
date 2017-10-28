local vectorClass = {}

local abs = math.abs
local sin = math.sin
local cos = math.cos
local atan = math.atan
local sqrt = math.sqrt
local pi = math.pi

local vector = {}

--Get X--
function vector:getX()
	return self.x
end

--Get Y--
function vector:getY()
	return self.y
end

--Set X and Y--
function vector:set(x, y)
	self.x = x; self.y = y
end

--Set X--
function vector:setX(x)
	self.x = x;
end

--Set Y--
function vector:setY(y)
	self.y = y
end

--Add X and Y--
function vector:add(x, y)
	self.x = self.x + x
	self.y = self.y + y
end

--Get magnitude--
function vector:magnitude()
	return sqrt(self.x^2 + self.y^2)
end
vector.mag = vector.magnitude

--Get magnitude squared--
function vector:sqrMagnitude()
	return self.x^2 + self.y^2
end
vector.sqrMag = vector.sqrMagnitude

local function getNormalizedValues(x, y)
	if y == 0 then
		return x/abs(x), 0
	end
	local b = sqrt(1/(1+(x/y)^2))
	local a = (x/y)*b
	return a, b
end

--Get normalized vector--
function vector:normalized()
	local x, y = getNormalizedValues(self.x, self.y)
	return vectorClass:new(x, y)
end

--Normalize vector--
function vector:normalize()
	local x, y = getNormalizedValues(self.x, self.y)
	self.x = x; self.y = y
end

--Get angle in radians--
function vector:getAngle()
	return atan(self.y, self.x)
end
vector.angle = vector.getAngle

--Set angle in radians--
function vector:setAngle(radians)
	self.x = cos(radians)
	self.y = sin(radians)
end

--Add to the angle--
function vector:addAngle(radians)
	self:setAngle(self:getAngle()+radians)
end

--[[Static functions]]--

--Get distance between two vectors--
function vectorClass.distance(v1, v2)
	local dx = v1:getX() - v2:getX()
	local dy = v1:getY() - v2:getY()
	return sqrt(dx^2 + dy^2)
end
vectorClass.dist = vectorClass.distance

--Gets the nearest direction from one angle to another--
function vectorClass.getAngleDirection(t1, t2)
	if abs(t1-t2) > pi then
		if t1 >= t2 then return 1
		else return -1 end
	else
		if t1 >= t2 then return -1
		else return 1 end
	end
end
vectorClass.getAngleDir = vectorClass.getAngleDirection

--Gets the nearest distance from one angle to another--
function vectorClass.getAngleDistance(t1, t2)
	if abs(t1-t2) > pi then
		if t1 > t2 then t1 = t1 - pi*2
		else if t1 < t2 then t2 = t2 - pi*2 end end
		return abs(t1-t2)
	else
		return abs(t1-t2)
	end
end
vectorClass.getAngleDist = vectorClass.getAngleDistance

--local vectorMt = {__index = vector}
vectorClass.new = function(x, y)
  return setmetatable({x = x; y = y}, {__index = vector})
end

return vectorClass