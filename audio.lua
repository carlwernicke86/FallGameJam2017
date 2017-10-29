audio = class("audio")

function audio:initialize(args)
	self.path = {"res/sound/", ".ogg"}
	self.loopingSources = {}
	self.sfx = {}
	self.volume = 1
end

function audio:playLooping(name)
	path = path or self.path
	
	local source = love.audio.newSource(path[1] .. name .. path[2])
	if self.loopingSources[name] ~= nil then self.sources[name]:stop() end
	self.loopingSources[name] = source
	source:setLooping(true)
	love.audio.play(source)
end

function audio:clearAudio()
	for v, source in pairs(self.loopingSources) do
		source:stop()
	end
	self.loopingSources = {}
end

function audio:playSound(name, path)
	path = path or self.path
	
	local source = love.audio.newSource(path[1] .. name .. path[2])
	love.audio.play(source)
end

function audio:playSFX(name, path)
	path = path or self.path
	
	local source = nil
	if not self.sfx[name] then
		source = love.audio.newSource(path[1] .. name .. path[2])
		self.sfx[name] = source
	else
		source = self.sfx[name]:clone()
	end
	
	source:play()
end

function audio:clearSFX()
	self.sfx = {}
end

function audio:setVolume(volume)
	self.volume = volume
	love.audio.setVolume(volume)
end

function audio:mute()
	if love.audio.getVolume() == 0 then
		self:setVolume(self.volume)
	else
		love.audio.setVolume(0)
	end
end

return audio:new()