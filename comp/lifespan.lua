local component = require "comp/component"
local lifespan = class("lifespan", component)

function lifespan:initialize(args)
	component.initialize(self, args)
	self.type = "lifespan"
	self.time = args.time
end

function lifespan:update(dt)
	self.time = self.time - dt
	if self.time <= 0 then
		self.parent.die = true
	end
end

return lifespan