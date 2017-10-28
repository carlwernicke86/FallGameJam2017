require "game/collisionManager"
require "game/cameraManager"
require "game/inputManager"
require "game/tiledLoader"

--require all components/entities automatically
local function recursiveRequire(folder)
	local filesTable = love.filesystem.getDirectoryItems(folder)
	for i,v in ipairs(filesTable) do
		local file = folder.."/"..v
		if love.filesystem.isFile(file) then
			file = string.sub(file, 1, -5)
			require(file)
		elseif love.filesystem.isDirectory(file) then
			recursiveRequire(file)
		end
	end
end
recursiveRequire("ent")
recursiveRequire("comp")

local game = {}

function game:init()
	
	local vector = require("libs/vector")
	local v1 = vector.new(2,5)
	local v2 = vector.new(4,10)
	v2:normalize()
	--crash(v2:getAngle())

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

	--entities
	self.ent = {}
	self.player = self:addEnt(player, {x=500, y=0})
	
	--crude level design
	for i=-5, 10 do
		for j=1, 3 do
			if((i==-3 and j==1) or (i==-2 and j==1)) then
				self:addEnt(wall, {x=400+i*50, y=100+j*50})
			else
				self:addEnt(wall, {x=400+i*50, y=100+j*50})
			end
		end
	end
	
	for i=-5, 10 do
		for j=1, 3 do
			self:addEnt(wall, {x=400+i*50, y=-350+j*50})
		end
	end
	
	--other stuff
	local phys = self.player:getComponent("physics")
	self.camMan:setTarget(phys, phys.w/2, phys.h/2)
	self.camMan:setPos(phys.x+phys.w/2, phys.y+phys.h/2)

end

function game:enter()
	self:resize(love.graphics.getDimensions())
	--self.tiledLoader:loadLevel("test")
	audio:playLooping("september")
end

function game:reset()
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
			end
		end
		
		--update timers
		--timer.update(dt)
		
		--require("mobdebug").on()

		--require("mobdebug").off()
		
		--update systems
		for i, system in ipairs(self.system) do
			system:update(dt)
		end

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

end

function game:keypressed(key)
	self.inputMan:keypressed(key)
	
	if key=="p" then
		gamestate.switch(gameMode.mainMenu)
	end
	
	if key=="q" then imgMan:clearImages() end
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

function game:resize(w, h)
	self.camMan:setDimensions(w,h)
end

return game