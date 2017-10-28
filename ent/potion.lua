local gameObject = require "ent/gameObject"
local potion = class("potion", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local destroyOnTouch = require "comp/destroyOnTouch"
local potionComponent = require "comp/potionComponent"

function potion:initialize(args)
	gameObject.initialize(self, args)
	self.id = "potion"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=13, h=15, gravity=true, gravScale=800}
	self.img = image:new{parent=self, name="image", img="potion", posParent=self.phys, ox=-9, oy=-6}
	
	self:addComponent(self.phys)
	self:addComponent(self.img)
	self:addComponent(destroyOnTouch:new{parent=self})
	self:addComponent(potionComponent:new{parent=self})
end

return potion