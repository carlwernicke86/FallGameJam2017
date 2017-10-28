local sti = require "libs/sti"

local tiledLoader = class("tiledLoader")

tiledLoader.static.path = {prefix = "res/levels/", suffix = ".lua"}

function tiledLoader:initialize(parent)
	self.game = parent
	self.currentLevel = "none"
end

function tiledLoader:loadLevel(name)
	local map = sti.new(tiledLoader.path.prefix .. name .. tiledLoader.path.suffix)
	
	local tileset = map.tilesets[1] --TODO: add support for different tilesets
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
					self:spawnTile(data[y][x], x, y, tilewidth, tileheight, currentTileset.name)
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

function tiledLoader:spawnTile(tile, x, y, tilewidth, tileheight, tileset)
	local ix, iy = imgMan.getIndex(10, tile.id)
	local args = {
		game = self.game, col = col,
		x = x*tilewidth-tilewidth, y = y*tileheight-tileheight,
		w = tonumber(tile.width), h = tonumber(tile.height),
		img = tileset,
		quad = {xPos=ix, yPos=iy, w=32, h=32, tileWidth=32, tileHeight=32}
	}
	local wall = require("ent/wall")
	local ent = self.game:addEnt(wall, args)
	--error(inspect(ent.img))
end

function tiledLoader:spawnObject(object)
	local args = {
		game = self.game,
		x = object.x, y = object.y, col = false,
		w = object.width, h = object.height,
		img = "tile1"
	}
	local ent = self.game:addEnt(wall, args)
end

function tiledLoader:update()
end

return tiledLoader