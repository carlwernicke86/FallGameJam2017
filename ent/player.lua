local gameObject = require "ent/gameObject"
local player = class("player", gameObject)

local physics = require "comp/physics"
local image = require "comp/render/image"
local rectangle = require "comp/render/rectangle"
local platformerController = require "comp/platformerController"
local playerScript = require "comp/playerScript"
local potionThrower = require "comp/potionThrower"
local health = require "comp/health"
local healthBarUpdate = require "comp/healthBarUpdate"

function player:initialize(args)
	gameObject.initialize(self, args)
	self.id = "player"
	
	local x = args.x or 100
	local y = args.y or 100

	self.phys = physics:new{parent=self, x=x, y=y, w=32, h=32-6, gravity=true}
	self.img = image:new{parent=self, name="image", img="proper player", posParent=self.phys, ox=0, oy=-6}
	self.playerScript = playerScript:new{parent=self}
	self.controller = platformerController:new{parent=self}
	self.potions = potionThrower:new{parent=self}
	self.health = health:new{parent=self}

	self.healthBar = rectangle:new{
		parent=self, name="healthBar", posParent=self.phys,
		w=60, h=10, ox=-15, oy=-30,
		color={r=255, g=0, b=0}
	}

	self.healthBarUpdate = healthBarUpdate:new{
		parent=self, healthBar=self.healthBar, health=self.health
	}
	
	self:addComponent(self.controller)
	self:addComponent(self.img)
	self:addComponent(self.phys)
	self:addComponent(self.playerScript)
	self:addComponent(self.potions)
	self:addComponent(self.health)

	self:addComponent(self.healthBar)
	self:addComponent(self.healthBarUpdate)

end

return player