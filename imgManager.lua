--TODO: remove this and use cargo instead.

imgManager = class("imgManager")

function imgManager:initialize(parent)

	self.id = "imgManager"
	self.game = parent
	self.path = {"res/img/", ".png"}

	self.img = {}
	self.grid = {}
	self.anim = {}

end

function imgManager:getImage(name, path)
	path = path or self.path

	if not self.img[name] then
		self.img[name] = love.graphics.newImage(path[1] .. name .. path[2])
	end
	return self.img[name]

end

--clears the pool of loaded images.
--might be useful if you're using a ton of memory and want to de-load now-unused images.
function imgManager:clearImages()
	self.img = {}
end

function imgManager:getGrid(name, sw, sh, iw, ih)
	if self.grid[name] == nil then
		self.grid[name] = anim8.newGrid(sw, sh, iw, ih)
	end
	return self.grid[name]
end

function imgManager:getAnim(name, grid, durations, frames)
	if self.anim[name] == nil then
		self.anim[name] = anim8.newAnimation(grid(frames), durations)
	end
	return self.anim[name]
end

--get the x/y position of a sub-image from a larger image.
--or something like that.
function imgManager.getIndex(width, id)
	local x = 1
	local y = 1

	id = tonumber(id)

	while(id >= width) do
		id = id - width
		y = y + 1
	end

	x = x + id
	return x, y
end

return imgManager:new()