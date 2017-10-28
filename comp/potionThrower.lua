local component = require "comp/component"
local potionThrower = class("potionThrower", component)

function potionThrower:initialize(args)
	component.initialize(self, args)
	self.type = "potionThrower"

	--register a new input mapping for throwing potions
	self.parent.game.inputMan.map["attack"] = function()
		local player = self.parent.game.player
		local potions = player:getComponent("potionThrower")
		if potions ~= nil then potions:throwPotion() end
	end
end

function potionThrower:throwPotion()
	if not self.parent.die then
		local potion = require("ent/potion")
		local playerPhys = self.parent.phys
		local ent = self.parent.game:addEnt(potion, {x=playerPhys.x+playerPhys.w/2, y=playerPhys.y})
		ent.phys.vx = self.parent.controller.faceDir*275+playerPhys.vx/3
		ent.phys.vy = -225+playerPhys.vy/2
	end
end

return potionThrower