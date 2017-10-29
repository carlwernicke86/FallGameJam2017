local suit = require "libs/suit"

--images
local playerImage = love.graphics.newImage("res/img/proper player.png")
local potionImage = love.graphics.newImage("res/img/potion.png")
local endImage = love.graphics.newImage("res/img/exit block.png")
local fireImage = love.graphics.newImage("res/img/fire.png")
local crackedImage = love.graphics.newImage("res/img/cracked grey tile.png")
local spikeImage = love.graphics.newImage("res/img/spikes.png")

local instructionMenu = {}

function instructionMenu:init()

end

function instructionMenu:enter()
	love.graphics.setBackgroundColor(0,0,0)
end

function instructionMenu:update(dt)
	
	suit.layout:reset(100, love.graphics.getHeight() - 100, 20, 20)
	local back = suit.Button("BACK",suit.layout:row(200, 50))
	
	if back.hit then
		self.backToMenu()
	end
	
end

function instructionMenu:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(playerImage, 150, 200, 0, 3, 3)
	love.graphics.draw(potionImage, 150, 295, 0, 3, 3)
	love.graphics.draw(endImage, 150, 350, 0, 3, 3)
	love.graphics.draw(fireImage, 150, 425, 0, 3, 3)
	love.graphics.draw(crackedImage, 150, 515, 0, 3, 3)
	love.graphics.draw(spikeImage, 150, 560, 0, 3, 3)
	
	love.graphics.setColor(100, 50, 255)
	love.graphics.setNewFont("/res/font/CourierCode-bold.ttf", 50)
	love.graphics.print("= YOU", 275, 225)
	love.graphics.print("= POTION", 275, 300)
	love.graphics.print("= END", 275, 375)
	love.graphics.print("= FIRE", 275, 450)
	love.graphics.print("= BREAK", 275, 525)
	love.graphics.print("= DEATH", 275, 600)
	
	love.graphics.print("RIGHT  = ->", 600, 225)
	love.graphics.print("LEFT   = <-", 600, 300)
	love.graphics.print("JUMP   = SPACE", 600, 375)
	love.graphics.print("USE    = X", 600, 450)
	love.graphics.print("CHANGE = C", 600, 525)
	love.graphics.print("POTION", 600, 560)
	love.graphics.print("POTION", 600, 485)
	love.graphics.print("RELOAD = R", 600, 600)
	
	love.graphics.setNewFont("/res/font/CourierCode-bold.ttf", 100)
	local w = love.graphics.getFont():getWidth("INSTRUCTIONS")
	love.graphics.print("INSTRUCTIONS", love.graphics.getWidth()/2-w/2, 25)
	
	love.graphics.setNewFont("/res/font/CourierCode-bold.ttf", 24)
	suit.draw()
end

function instructionMenu:backToMenu()
	gamestate.switch(gameMode.mainMenu)
end
return instructionMenu