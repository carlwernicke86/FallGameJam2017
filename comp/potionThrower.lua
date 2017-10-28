local component = require "comp/component"
local potionThrower = class("potionThrower", component)

local potion = require("ent/potion")

function potionThrower:initialize(args)
	component.initialize(self, args)
	self.type = "potionThrower"

	local waterPotion = require("game/potionData/waterPotion")
	local healthPotion = require("game/potionData/healthPotion")
	self.potions = {waterPotion, healthPotion}
	self.charge = {1, 1}
	self.potionIndex = 1

	--register a new input mapping for throwing potions
	self.parent.game.inputMan.map["attack"] = function()
		local player = self.parent.game.player
		local potions = player:getComponent("potionThrower")
		if potions ~= nil and (not player.die) then potions:throwPotion() end
	end

	self.parent.game.inputMan.map["switch"] = function()
		local player = self.parent.game.player
		local potions = player:getComponent("potionThrower")
		if potions ~= nil and (not player.die) then potions:switchPotion() end
	end

end

function potionThrower:throwPotion()
	local currentPotion = self.potions[self.potionIndex]

	local playerPhys = self.parent.phys
	local ent = self.parent.game:addEnt(potion, {
		x=playerPhys.x+playerPhys.w/2, y=playerPhys.y+playerPhys.h/4,
		gravity=currentPotion.gravity, component=currentPotion.component,
		img=currentPotion.img, splashComponents=currentPotion.splashComponents,
		splashColor = currentPotion.splashColor
	})
	ent.phys.vx = self.parent.controller.faceDir*currentPotion.vx+playerPhys.vx/3
	ent.phys.vy = currentPotion.vy+playerPhys.vy/2
end

function potionThrower:switchPotion()
	self.potionIndex = self.potionIndex + 1
	if self.potionIndex > #self.potions then self.potionIndex = 1 end
end

return potionThrower