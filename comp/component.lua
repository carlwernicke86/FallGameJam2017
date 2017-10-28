local component = class("component")

function component:initialize(args)
	self.parent = args.parent
	if self.parent then self.game = args.parent.game end
	self.type = "unknown"
	self.name = "unnamed"
	if args.name ~= nil then self.name = args.name end
end

function component:entID()
	return self.parent.id
end

function component:destroy()
end

function component:update(dt)
end

function component:draw()
end

function component:keypressed()
end

function component:mousepressed()
end

return component