local gameObject = require "ent/gameObject"
local splash = class("splash", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"

function splash:initialize(args)
	gameObject.initialize(self, args)
	self.id = "splash"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=50, h=50, solidity="static"}
	self.img = image:new{parent=self, name="image", img="splash", posParent=self.phys, ox=-6, oy=12}
	
	self:addComponent(self.phys)
	self:addComponent(self.img)
end

return splash