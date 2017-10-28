local suit = require "libs/suit"

local background = love.graphics.newImage("res/title_img.png")
local buttonWidth = 200

local mainMenu = {}

function mainMenu:init()
	self.slider = {value = settings.volume, min = 0, max = 1}
end

function mainMenu:enter()
	love.graphics.setBackgroundColor(0,0,20)
	--love.graphics.setBackgroundColor(55,57,8)

end

function mainMenu:update(dt)
	
	
	--used ui stuff
	suit.layout:reset(love.graphics.getWidth()/2 - buttonWidth/2, love.graphics.getHeight()/2, 20, 20) --originx, originy, paddingx, paddingy
	local start = suit.Button("START", suit.layout:row(buttonWidth,50))
	local instructions = suit.Button("INSTRUCTIONS", suit.layout:row(buttonWidth, 50))
	--local volumeSlider = suit.Slider(self.slider, suit.layout:row(buttonWidth, 20))
	
	if instructions.hit then
		self:showInstructions()
	end
	
	if start.hit then
		self:startGame()
	end
	
	--[[if volumeSlider.changed then
		audio:setVolume(self.slider.value)
	end]]
	
end

function mainMenu:draw()
	love.graphics.draw(background, 0, 0)
	courierCodeBold = love.graphics.newFont("/res/font/CourierCode-bold.ttf", 24)
	love.graphics.setNewFont("/res/font/CourierCode-bold.ttf", 50)
	love.graphics.setColor(100,50,255)
	local w = love.graphics.getFont():getWidth("CAVE GAME")
	love.graphics.printf("CAVE GAME", love.graphics.getWidth()/2-w/2, love.graphics.getHeight()/4, 350, 'left')
	
	love.graphics.setFont(courierCodeBold)
	suit.draw()
end

function mainMenu:startGame()
	gamestate.switch(gameMode.game)
end

function mainMenu:showInstructions()
	gamestate.switch(gameMode.instructionMenu)
end

function mainMenu:keypressed(key)
	self:startGame()
end

function mainMenu:mousepressed() --todo add button
end

return mainMenu