local gameObject = require "ent/gameObject"
local fire = class("fire", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local image = require "comp/render/image"

local component = require "comp/component"
local fireComponent = class("fireComponent", component)

function fireComponent:initialize(args)
	component.initialize(self, args)
end

function fireComponent:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "splash" then
			self.parent.die = true
		end
	end
end

function fire:initialize(args)
	gameObject.initialize(self, args)
	self.id = "fire"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y+16, w=16, h=32, col=true})
	self.img = image:new({parent=self, img="fire", posParent=phys, oy=-16})

	self:addComponent(self.img)
	self:addComponent(phys)
	self:addComponent(fireComponent:new{parent=self})
end

return fire