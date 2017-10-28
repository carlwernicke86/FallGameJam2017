local gameObject = require "ent/gameObject"
local breakableWall = class("breakableWall", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local image = require "comp/render/image"

function breakableWall:initialize(args)
	gameObject.initialize(self, args)
	self.id = "breakableWall"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=32, h=32, solidity="static", col=false})
	self.img = image:new({parent=self, img="cracked grey tile", posParent=phys, oy=0})

	self:addComponent(self.img)
	self:addComponent(phys)
end

return breakableWall