local healthPotion = {
	name = "Health Potion";
	img = "redpotion";
	component = require("comp/potionComponent");
	splashComponents = {
		require("comp/waterSplash");
		require("comp/healthSplash");
	};
	splashColor = {r=234, g=36, b=32};
	vx = 0;
	vy = -200;
	gravity = 600;
}

return healthPotion