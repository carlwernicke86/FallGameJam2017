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
	local potion = require("ent/potion")
	local ent = self.parent.game:addEnt(potion, {x=self.parent.phys.x+love.math.random()*50, y=self.parent.phys.y-50})
	ent.phys.vx = self.parent.controller.faceDir*200
	ent.phys.vy = -200
end

return potionThrower