local gameObject = require "ent/gameObject"
local fire = class("fire", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local image = require "comp/render/image"

function fire:initialize(args)
	gameObject.initialize(self, args)
	self.id = "fire"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y+16, w=32, h=16, col=false})
	self.img = image:new({parent=self, img="fire", posParent=phys, oy=-16})

	self:addComponent(self.img)
	self:addComponent(phys)
end

return fire