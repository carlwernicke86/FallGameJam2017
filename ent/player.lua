local gameObject = require "ent/gameObject"
local player = class("player", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local platformerController = require "comp/platformerController"
local potionThrower = require "comp/potionThrower"

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=32, h=32, gravity=true}
	self.img = image:new{parent=self, name="image", img="player", posParent=self.phys, ox=0, oy=0}
	self.controller = platformerController:new{parent=self}
	self.potions = potionThrower:new({parent=self})
	
	self:addComponent(self.controller)
	self:addComponent(self.phys)
	self:addComponent(self.img)
	self:addComponent(self.potions)
end

return player