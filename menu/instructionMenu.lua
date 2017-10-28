local suit = require "libs/suit"

local instructionMenu = {}

function instructionMenu:init()

end

function instructionMenu:enter()
	love.graphics.setBackgroundColor(0,0,0)
end

function instructionMenu:update(dt)
	
	suit.layout:reset(100, 100, 20, 20)
	local back = suit.Button("BACK",suit.layout:row(200, 50))
	
	if back.hit then
		self.backToMenu()
	end
	
end

function instructionMenu:draw()
	love.graphics.setColor(100, 50, 255)
	local w = love.graphics.getFont():getWidth("WELCOME TO THE INSTRUCTIONS PAGE. PLS READ")
	love.graphics.print("WELCOME TO THE INSTRUCTIONS PAGE. PLZ READ", love.graphics.getWidth()/2-w/2, love.graphics.getHeight()/2)
	
	suit.draw()
end

function instructionMenu:backToMenu()
	gamestate.switch(gameMode.mainMenu)
end
return instructionMenu