local gameObject = require "ent/gameObject"
local splash = class("splash", gameObject)

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
	self.rect = rectangle:new{parent=self, posParent=self.phys, w=50, h=50, color=args.color}
	
	self:addComponent(self.phys)
	self:addComponent(self.rect)
	self:addComponent(lifespan:new{parent=self, time=0.2})

	for i, comp in ipairs(args.components) do
		self:addComponent(comp:new{parent=self})
	end

	--self.img = image:new{parent=self, name="image", img="splash", posParent=self.phys, ox=-6, oy=12}
	--self:addComponent(self.img)
end

return splash