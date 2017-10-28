local gameObject = require "ent/gameObject"
local potionPickup = class("potionPickup", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"

function potionPickup:initialize(args)
	gameObject.initialize(self, args)
	self.id = "potionPickup"
	
	local x = args.x+8 or 100
	local y = args.y+17 or 100

	self.potion = require("game/potionData/" .. args.potion)
	local animation = self.potion.animation

	self.phys = physics:new{parent=self, x=x, y=y, w=13, h=15, col=false}
	self.img = image:new{
		parent=self, img=self.potion.img, animation=self.potion.animation,
		posParent=self.phys, ox=-9, oy=-6
	}
	
	self:addComponent(self.phys)
	self:addComponent(self.img)

end

return potionPickup