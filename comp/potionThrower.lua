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
	local player = require("ent/player")
	--self.parent.game:addEnt(player, {x=player.phys:getX(), y=player.phys:getY()})
end

return potionThrower