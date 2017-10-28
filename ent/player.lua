local gameObject = require "ent/gameObject"
local player = class("player", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local platformerController = require "comp/platformerController"

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"
	
	local x = args.x or 100
	local y = args.y or 100
	local phys = physics:new({parent=self, x=x, y=y, w=48, h=48, gravity=true})

	local img = image:new({parent=self, name="image", img="player", posParent=phys, ox=-2, oy=-2})
	
	--local controller = topDownController:new({parent=self})
	local controller = platformerController:new({parent=self})
	
	self:addComponent(controller)
	self:addComponent(phys)
	self:addComponent(img)
end

return player