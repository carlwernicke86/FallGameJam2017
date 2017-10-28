local waterPotion = {
	name = "Water Potion";
	img = "potion";
	component = require("comp/potionComponent");
	splashComponents = {
		require("comp/waterSplash");
	};
	splashColor = {r=120, g=120, b=255, a=255};
	vx = 275;
	vy = -225;
	gravity = 800;
}

return waterPotion