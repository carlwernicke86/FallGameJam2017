local component = require "comp/component"
local playerScript = class("playerScript", component)

function playerScript:initialize(args)
	component.initialize(self, args)
end

function playerScript:collisionDetected(cols)
	for i, col in ipairs(cols) do
		if col.other.parent.id == "exit" then
			local game = self.parent.game
			local func = lume.fn(game.endLevel, game)
			game.endTasks[#game.endTasks+1] = func
		end

		if col.other.parent.id == "potionPickup" then
			self.parent.potions:getPotion(col.other.parent.potion)
			col.other.parent.die = true
		end
	end
end

return playerScript