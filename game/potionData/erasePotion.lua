local anim8 = require "libs/anim8"
local grid = anim8.newGrid(32, 32, 64, 64)
local animation = anim8.newAnimation(grid(1,1, 1,2), 0.2)

local erasePotion = {
	name = "ERASE";
	img = "end game";
	animation = animation;
	component = require("comp/potionComponent");
	splashComponents = {
		require("comp/waterSplash");
		require("comp/eraseSplash");
	};
	splashColor = {r=255, g=255, b=255, a=255};
	vx = 800;
	vy = 0;
	gravity = 0;
}

return erasePotion