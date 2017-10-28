local gameObject = require "ent/gameObject"
local splash = class("splash", gameObject)

local anim8 = require "libs/anim8"

local physics = require "comp/physics"
local image = require "comp/render/image"
local rectangle = require "comp/render/rectangle"
local lifespan = require "comp/lifespan"

function splash:initialize(args)
	gameObject.initialize(self, args)
	self.id = "splash"
	
	local x = args.x-25 or 100
	local y = args.y-25 or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=50, h=50}
	--self.rect = rectangle:new{parent=self, posParent=self.phys, w=50, h=50, color=args.color}
	
	self:addComponent(self.phys)
	--self:addComponent(self.rect)
	self.lifespan = lifespan:new{parent=self, time=0.2}
	self:addComponent(self.lifespan)

	--240 by 34
	local grid = anim8.newGrid(60, 34, 240, 34)
	local animation = anim8.newAnimation(grid('1-4',1), 0.2/4)

	self.img = image:new{
		parent=self, img="splash", animation=animation,
		posParent=self.phys, ox=-6, oy=6, color=args.color
	}
	self:addComponent(self.img)

	for i, comp in ipairs(args.components) do
		self:addComponent(comp:new{parent=self})
	end
end

return splash