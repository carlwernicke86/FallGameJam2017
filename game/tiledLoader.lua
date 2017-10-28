local sti = require "libs/sti"

tiledLoader = class("tiledLoader")

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
					self:spawnTile(data[y][x])
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

function tiledLoader:spawnTile(tile)
	local ix, iy = imgMan.getIndex(6, tile.id) --TODO: calculate tileset width
	local args = {
		game = self.game, col = col,
		x = x*tilewidth-tilewidth, y = y*tileheight-tileheight,
		w = tonumber(tile.width), h = tonumber(tile.height),
		img = currentTileset.name,
		quad = {xPos=ix, yPos=iy, w=16, h=16, tileWidth=16, tileHeight=16} --TODO: get tilewidth/height
	}
	local ent = self.game:addEnt(wall, args)
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