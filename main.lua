--libraries
class = require "libs/middleclass"
require "libs/misc"
vector = require "libs/vector"
inspect = require "libs/inspect"
lume = require "libs/lume"
gamestate = require "libs/hump/gamestate"
vivid = require "libs/vivid"

--ehhhhh
imgMan = require "imgManager"
audio = require "audio"

--gamestates
gameMode = {}
gameMode.mainMenu = require "menu/mainMenu"
gameMode.erased = require "menu/erased"
gameMode.game = require "game/game"
gameMode.instructionMenu = require "menu/instructionMenu"
gameMode.creditsMenu = require "menu/creditsMenu"

--other things
debugger = require "debugger"

function love.load()
	
	--setup ZeroBrane IDE debugger
	if arg[#arg] == "-debug" then require("mobdebug").start() end
	--require("mobdebug").on(), require("mobdebug").off()
	
	love.graphics.setDefaultFilter("linear", "nearest")

	math.randomseed(os.time())
	
	--TODO remove
	defaultFont = love.graphics.getFont()
	courierCodeBold = love.graphics.newFont("/res/font/CourierCode-bold.ttf", 24)
	love.graphics.setFont(courierCodeBold)
	
	settings = {
		volume = 1,
		mute = false
	}
	audio:setVolume(settings.volume)
	if settings.mute then audio:mute() end

	gamestate.registerEvents()
	if not love.filesystem.isFile("save.txt") then
		gamestate.switch(gameMode.mainMenu)
	else
		gamestate.switch(gameMode.erased)
	end

end

function love.update(dt)

	debugger:update(dt)

end

function love.draw()

	debugger:draw()

end

function love.keypressed(key)
	if key == "escape" then 
		love.filesystem.remove("save.txt")
		love.event.quit()
	end
end

function debug(msg, dur, cat)
	dur = dur or 5
	if cat then debugger:cat(msg, dur)
	else debugger:print(msg, dur) end
end

function getImg(name)
	return imgMan:getImage(name)
end