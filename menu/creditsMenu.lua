local suit = require "libs/suit"

local creditsMenu = {}

function creditsMenu:init()

end

function creditsMenu:enter()
	love.graphics.setBackgroundColor(0, 0, 0)
end

function creditsMenu:update(dt)

	suit.layout:reset(100, love.graphics.getHeight() - 100, 20, 20)
	local back = suit.Button("BACK",suit.layout:row(200, 50))
	
	if back.hit then
		self.backToMenu()
	end
end

function creditsMenu:draw()
	love.graphics.setNewFont("/res/font/couriercode-bold.ttf", 100)
	local w = love.graphics.getFont():getWidth("DEVELOPERS")
	love.graphics.print("DEVELOPERS", love.graphics.getWidth()/2-w/2, 25)
	love.graphics.setNewFont("/res/font/couriercode-bold.ttf", 75)
	
	width = love.graphics.getFont():getWidth("CARL")
	love.graphics.print("CARL", love.graphics.getWidth()/2 - width/2, 150)
	width = love.graphics.getFont():getWidth("PETER")
	love.graphics.print("PETER", love.graphics.getWidth()/2 - width/2, 225)
	width = love.graphics.getFont():getWidth("TAYLOR")
	love.graphics.print("TAYLOR", love.graphics.getWidth()/2 - width/2, 300)
	width = love.graphics.getFont():getWidth("VICTOR")
	love.graphics.print("VICTOR", love.graphics.getWidth()/2 - width/2, 375)
	
	
	love.graphics.setNewFont("/res/font/couriercode-bold.ttf", 24)
	suit.draw()
end

function creditsMenu:backToMenu()
	gamestate.switch(gameMode.mainMenu)
end

return creditsMenu
