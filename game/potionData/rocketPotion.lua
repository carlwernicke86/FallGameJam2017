local waterPotion = {
	name = "Propulsion Potion";
	img = "potion";
	component = require("comp/potionComponent");
	splashComponents = {
		require("comp/waterSplash");
		require("comp/rocketSplash");
	};
	splashColor = {r=255, g=50, b=255, a=255};
	vx = 50;
	vy = -420;
	gravity = 1600;
}

return waterPotion