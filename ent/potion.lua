local gameObject = require "ent/gameObject"
local potion = class("potion", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"

function potion:initialize(args)
	gameObject.initialize(self, args)
	self.id = "potion"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=10, h=10, gravity=true}
	self.img = image:new{parent=self, name="image", img="potion", posParent=self.phys, ox=-10, oy=-8}
	
	self:addComponent(self.phys)
	self:addComponent(self.img)
end

function potion:sideHit(args)
	self.die = true
	error()
end

return potion