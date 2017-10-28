local component = require "comp/component"
local potionComponent = class("potionComponent", component)

local splash = require "ent/splash"

function potionComponent:initialize(args)
	component.initialize(self, args)
	self.type = "potionComponent"
	self.color = {r=100, g=100, b=255}
end

function potionComponent:destroy(args)
	local parent = self.parent
	local phys = parent.phys
	local ent = parent.game:addEnt(splash, {x=phys.x+phys.w/2-20, y=phys.y+phys.h/2-30, color=self.color})
end

return potionComponent