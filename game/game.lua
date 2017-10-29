local collisionManager = require "game/collisionManager"
local inputManager = require "game/inputManager"
local cameraManager = require "game/cameraManager"
local tiledLoader = require "game/tiledLoader"
local playerDeath = require "game/playerDeath"
local gameUI = require "game/gameUI"

local game = {}

function game:init()

	--timestep related stuff
	dt = 0.01
	accum = 0
	self.paused = false

	self.drawLayers = {"background", "default"}

	--systems
	self.system = {}
	self.colMan = self:addSystem(collisionManager)
	self.camMan = self:addSystem(cameraManager)
	self.inputMan = self:addSystem(inputManager)
	self.tiledLoader = self:addSystem(tiledLoader)
	self.playerDeath = self:addSystem(playerDeath)

	self.ui = self:addSystem(gameUI)

	self.endTasks = {}

	--entities
	self.ent = {}

	self.levels = {"lvl_tutorial", "lvl_wall", "lvl_spike", "lvl_bomb", "lvl_hardplatform", "level5", "testmap", "erase_level", "lvl_final"}
	self.levelIndex = 1

end

function game:enter()
	audio:playLooping("bgm")
	self:nextLevel()
end

function game:endLevel()
	self.levelIndex = self.levelIndex + 1
	self:unloadLevel()
	self:nextLevel()
end

function game:unloadLevel()
	self.ent = {}
	self.colMan:resetWorld()
	self.camMan:unbound()
	self.ui:reset()
end

function game:nextLevel()
	self.tiledLoader:loadLevel(self.levels[self.levelIndex])
	
	local phys = self.player:getComponent("physics")
	self.camMan:setTarget(phys, phys.w/2, phys.h/2)
	self.camMan:setPos(phys.x+phys.w/2, phys.y+phys.h/2)
end

function game:update(delta)
	--timestep stuff
	if self.paused == false then accum = accum + delta end
	if accum > 0.05 then accum = 0.05 end
	while accum >= dt do

		--reverse iterate entities
		for i, entity in lume.ripairs(self.ent) do
			--update entity
			entity:update(dt)

			--if die then is kill
			if entity.die then
				--destroy all components first
				entity:notifyComponents("destroy")
				table.remove(self.ent, i)
				if entity == self.player then
					self.playerDeath:die()
				end
			end
		end

		--update systems
		for i, system in ipairs(self.system) do
			system:update(dt)
		end

		for i, func in ipairs(self.endTasks) do
			func()
		end
		self.endTasks = {}

		accum = accum - 0.01
	end
	if accum>0.1 then accum = 0 end
end

function game:draw()
	
		--attach camera
		self.camMan.cam:attach()
	
		--draw world
		local dim = self.camMan:getDimensions()
		for i, layer in ipairs(self.drawLayers) do
			for i, entity in ipairs(self.ent) do
				for i, comp in ipairs(entity.component) do
					if comp.drawLayer == layer then
						if comp:getX()+comp:getW() > dim.x and comp:getY()+comp:getH() > dim.y and comp:getX() < dim.x+dim.w and comp:getY() < dim.y+dim.h then
							comp:draw()
						end
					end
				end
			end
		end
		
		self.showHitboxes = false
		if self.showHitboxes then
			love.graphics.setColor(255,0,0,200)
			local cols, len = self.colMan.world:queryRect(-1000, -1000, 2000, 2000)
			for i, phys in ipairs(cols) do
				love.graphics.rectangle("fill", phys.x, phys.y, phys.w, phys.h)
			end
		end
		
		--detach camera
		self.camMan.cam:detach()

		--draw ui
		for i, entity in ipairs(self.ent) do
			for i, comp in ipairs(entity.component) do
				if comp.drawLayer == "ui" then
					comp:draw()
				end
			end
		end

		for i, system in ipairs(self.system) do
			if system.draw then system:draw() end
		end
	
	end

function game:keypressed(key)
	self.inputMan:keypressed(key)

	if key == "r" then
		self:unloadLevel()
		self:nextLevel()
	end
end

function game:mousepressed(button)
end

function game:addSystem(sys, args)
	args = args or {}
	sys = sys:new(self, args)
	self.system[#self.system+1] = sys
	return sys
end

function game:addEnt(ent, args)
	args = args or {}
	args.game = self
	local entity = ent:new(args)
	self.ent[#self.ent+1] = entity
	return entity
end

return game