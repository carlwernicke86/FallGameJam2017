local gameObject = require "ent/gameObject"
local potion = class("potion", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local destroyOnTouch = require "comp/destroyOnTouch"

function potion:initialize(args)
	gameObject.initialize(self, args)
	self.id = "potion"
	
	local x = args.x-6 or 100
	local y = args.y-7 or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=13, h=15, gravity=true, gravScale=args.gravity}
	self.img = image:new{
		parent=self, img=args.img, animation=args.animation,
		posParent=self.phys, ox=-9, oy=-6
	}
	
	self:addComponent(self.phys)
	self:addComponent(self.img)
	self:addComponent(destroyOnTouch:new{parent=self})
	self:addComponent(args.component:new{
		parent=self, splashComponents=args.splashComponents,
		splashColor=args.splashColor
	})
end

return potion