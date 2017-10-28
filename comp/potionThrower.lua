local component = require "comp/component"
local potionThrower = class("potionThrower", component)

local potion = require("ent/potion")

function potionThrower:initialize(args)
	component.initialize(self, args)
	self.type = "potionThrower"

	local waterPotion = require("game/potionData/waterPotion")
	local healthPotion = require("game/potionData/healthPotion")
	local rocketPotion = require("game/potionData/rocketPotion")
	self.potions = {}
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

	--self:setPlayerColor()

end

function potionThrower:getPotion(potion)
	self.potions[#self.potions+1] = potion
	self.potionIndex = #self.potions
	self:setPlayerColor()
end

function potionThrower:throwPotion()
	if #self.potions > 0 then
		local currentPotion = self.potions[self.potionIndex]

		local playerPhys = self.parent.phys
		local ent = self.parent.game:addEnt(potion, {
			x=playerPhys.x+playerPhys.w/2, y=playerPhys.y+playerPhys.h/4,
			gravity=currentPotion.gravity, component=currentPotion.component,
			img=currentPotion.img, animation=currentPotion.animation,
			splashComponents=currentPotion.splashComponents,
			splashColor = currentPotion.splashColor
		})
		ent.phys.vx = self.parent.controller.faceDir*currentPotion.vx+playerPhys.vx/3
		ent.phys.vy = currentPotion.vy+playerPhys.vy/2
	end
end

function potionThrower:switchPotion()
	self.potionIndex = self.potionIndex + 1
	if self.potionIndex > #self.potions then self.potionIndex = 1 end
	self:setPlayerColor()
end

function potionThrower:setPlayerColor()
	if #self.potions > 0 then
		local player = self.parent
		local potion = self.potions[self.potionIndex]

		if potion.playerAnimation then
			player.overlay.img = potion.playerAnimImg
			player.overlay.color = {r=255,g=255,b=255}
			player.overlay.animation = potion.playerAnimation
		else
			player.overlay.img = getImg("playerOverlay")
			player.overlay.color = potion.splashColor
			player.overlay.animation = nil
		end
	end
end

return potionThrower