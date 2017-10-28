local waterPotion = {
	img = "potion";
	component = require("comp/potionComponent");
	splashComponents = {
		require("comp/waterSplash");
	};
	splashColor = {r=100, g=100, b=255};
	vx = 275;
	vy = -225;
	gravity = 800;
}

return waterPotion