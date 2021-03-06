local anim8 = require "libs/anim8"

local gameObject = require "ent/gameObject"
local fire = class("fire", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"

function fire:initialize(args)
	gameObject.initialize(self, args)
	self.id = "fire"

	local grid = anim8.newGrid(32, 32, 64, 64)
	local animation = anim8.newAnimation(grid(1,1, 2,1, 1,2), 0.1)
	
	local phys = physics:new({parent=self, x=args.x, y=args.y+16, w=32, h=16, col=false})
	self.img = image:new({parent=self, img="fire idle", posParent=phys, oy=-16, animation=animation})

	self:addComponent(self.img)
	self:addComponent(phys)
end

return fire