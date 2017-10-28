local gameObject = require "ent/gameObject"
local wall = class("wall", gameObject)

local physics = require "comp/physics"
local rectangle = require "comp/render/rectangle"
local image = require "comp/render/image"

function wall:initialize(args)
	gameObject.initialize(self, args)
	self.id = "wall"
	
	local solidity = "static"
	if args.col == false then solidity = nil end
	
	local phys = physics:new({parent=self, x=args.x, y=args.y, w=args.w or 50, h=args.h or 50, col=false, solidity=solidity})
	
	if args.img ~= nil then
		self.img = image:new({parent=self, img=args.img, posParent=phys, quad=args.quad})
		self:addComponent(self.img)
	else
		self.rect = rectangle:new({parent=self, x=args.x, y=args.y, w=args.w, h=args.h})
		if solidity == nil then rect.color.a = 100 end
		self:addComponent(self.rect)
	end

	self:addComponent(phys)
end

return wall