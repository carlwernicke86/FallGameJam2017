local gameObject = require "ent/gameObject"
local splash = class("splash", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local rectangle = require "comp/render/rectangle"
local lifespan = require "comp/lifespan"

function splash:initialize(args)
	gameObject.initialize(self, args)
	self.id = "splash"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=50, h=50}
	self.rect = rectangle:new{parent=self, posParent=self.phys, w=50, h=50, color={r=100,g=100,b=255}}
	
	self:addComponent(self.phys)
	self:addComponent(self.rect)
	self:addComponent(lifespan:new{parent=self, time=0.2})

	--self.img = image:new{parent=self, name="image", img="splash", posParent=self.phys, ox=-6, oy=12}
	--self:addComponent(self.img)
end

return splash