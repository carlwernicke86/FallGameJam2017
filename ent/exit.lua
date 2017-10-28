local gameObject = require "ent/gameObject"
local exit = class("exit", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local image = require "comp/render/image"

function exit:initialize(args)
	gameObject.initialize(self, args)
	self.id = "exit"
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=32, h=32, col=false})
	self.img = image:new({parent=self, img="exit block", posParent=phys})

	self:addComponent(self.img)
	self:addComponent(phys)
end

return exit