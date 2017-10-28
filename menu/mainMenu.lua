local suit = require "libs/suit"

local mainMenu = {}

function mainMenu:init()
	self.slider = {value = settings.volume, min = 0, max = 1}
end

function mainMenu:enter()
	love.graphics.setBackgroundColor(0,0,20)
	--love.graphics.setBackgroundColor(55,57,8)
end

function mainMenu:update(dt)
	
	--unused ui stuff
	--[[suit.layout:reset(100,100, 20,20) --originx, originy, paddingx, paddingy
	local start = suit.Button("START", suit.layout:row(200,50))
	local start2 = suit.Button("START2", suit.layout:row(200,50))
	local volumeSlider = suit.Slider(self.slider, suit.layout:row(200, 20))
	
	if start.entered then
	end
	
	if start.hit then
		self:startGame()
	end
	
	if volumeSlider.changed then
		audio:setVolume(self.slider.value)
	end]]
	
end

function mainMenu:draw()
	love.graphics.setColor(255,255,255)
	local w = love.graphics.getFont():getWidth("THIS IS SOME SORTA MENU SCREEN")
	love.graphics.print("THIS IS SOME SORTA MENU SCREEN", love.graphics.getWidth()/2-w/2, 350)
	
	--suit.draw()
end

function mainMenu:startGame()
	gamestate.switch(gameMode.game)
end

function mainMenu:keypressed(key)
	self:startGame()
end

function mainMenu:mousepressed() --todo add button
end

return mainMenu