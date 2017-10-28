local component = require "comp/component"
local potionComponent = class("potionComponent", component)

local splash = require "ent/splash"

function potionComponent:initialize(args)
	component.initialize(self, args)
	self.type = "potionComponent"
	self.splashComponents = args.splashComponents
	self.splashColor = args.splashColor
end

function potionComponent:destroy(args)
	local parent = self.parent
	local phys = parent.phys
	local ent = parent.game:addEnt(splash, {
		x=phys.x+phys.w/2, y=phys.y+phys.h/2-5, components=self.splashComponents,
		color=val(self.splashColor)
	})
end

function potionComponent:sideHit(col)
	if col.side ~= "down" and col.side ~= "in" then
		self.parent.die = true
	end
	if col.side == "in" then
		self.parent.phys.vy = 100
	end
end

return potionComponent