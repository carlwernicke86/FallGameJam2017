local anim8 = require "libs/anim8"
local grid = anim8.newGrid(32, 32, 96, 96)
local animation = anim8.newAnimation(grid('1-3','1-3'), 0.1)

local rocketPotion = {
	name = "Propulsion Potion";
	img = "rocket jump potion";
	animation = animation;
	component = require("comp/potionComponent");
	splashComponents = {
		require("comp/waterSplash");
		require("comp/rocketSplash");
	};
	splashColor = function()
		local r, g, b = getHue(love.math.random()*255)
		return {r=r, g=g, b=b}
	end;
	--splashColor = {r=255, g=50, b=255, a=255};
	playerAnimation = animation;
	playerAnimImg = getImg("proper player option 3");
	vx = 50;
	vy = -420;
	gravity = 1600;
}

return rocketPotion