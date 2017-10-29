local anim8 = require "libs/anim8"

local gameObject = require "ent/gameObject"
local spikes = class("spikes", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"

function spikes:initialize(args)
	gameObject.initialize(self, args)
	self.id = "spikes"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y+16, w=32, h=16, col=false, solidity="static"})
	self.img = image:new({parent=self, img="spikes", posParent=phys, oy=-16})

	self:addComponent(self.img)
	self:addComponent(phys)
end

return spikes