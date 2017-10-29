local sti = require "libs/sti"

local tiledLoader = class("tiledLoader")

tiledLoader.static.path = {prefix = "res/levels/", suffix = ".lua"}

function tiledLoader:initialize(parent)
	self.game = parent
	self.currentLevel = "none"
end

function tiledLoader:loadLevel(name)
	local map = sti.new(tiledLoader.path.prefix .. name .. tiledLoader.path.suffix)
	
	local tileset = map.tilesets[1]
	local currentTileset = tileset
	
	for i, layer in ipairs(map.layers) do
		
		local tilewidth = tonumber(currentTileset.tilewidth)
		local tileheight = tonumber(currentTileset.tileheight)
		
		local data = layer.data
		local w = layer.width or 0; local h = layer.height or 0
		
		local col = true
		if layer.properties.collisions ~= nil then
			if layer.properties.collisions == false then col = false end
		end
		
		--load tile layer
		for y=1, h do
			for x=1, w do
				if data[y][x] ~= nil then
					local properties = map:getTileProperties(layer.name, x, y)
					if properties.type == nil then
						self:spawnTile(data[y][x], x, y, tilewidth, tileheight, currentTileset.name, properties)
					else
						self:spawnSpecialTile(data[y][x], x, y, tilewidth, tileheight, properties)
					end
				end
			end
		end
		
		--load object layer
		if layer.objects ~= nil then
			for j, object in ipairs(layer.objects) do
				self:spawnObject(object)
			end
		end
		
	end
	
	self.currentLevel = name
	
end

function tiledLoader:spawnTile(tile, x, y, w, h, tileset, properties)
	local ix, iy = imgMan.getIndex(10, tile.id)
	local args = {
		game = self.game, col = col,
		x = x*w-w, y = y*h-h,
		w = tonumber(tile.width), h = tonumber(tile.height),
		img = tileset,
		quad = {xPos=ix, yPos=iy, w=32, h=32, tileWidth=32, tileHeight=32}
	}
	local wall = require("ent/wall")
	self.game:addEnt(wall, args)
end

function tiledLoader:spawnSpecialTile(tile, x, y, w, h, properties)
	local class = require("ent/" .. tile.properties.type)
	self.game:addEnt(class, lume.merge({x=x*w-w, y=y*h-h}, properties))
end

function tiledLoader:spawnObject(object)
	if object.properties.type == "playerStart" then
		local player = require("ent/player")
		local ent = self.game:addEnt(player, {x=object.x, y=object.y})
		self.game.player = ent
	end
	if object.properties.type == "potionPickup" then
		local pickup = require("ent/potionPickup")
		self.game:addEnt(pickup, {x=object.x, y=object.y, potion=object.properties.potion})
	end
	if object.properties.type == "bounds" then
		self.game.camMan:setBounds(object.x, object.y, object.x+object.width, object.y+object.height)
	end
end

function tiledLoader:update()
end

return tiledLoader