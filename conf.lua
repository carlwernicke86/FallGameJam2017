function love.conf(t)
	t.window.title = "This can be erased"
	if love.filesystem.isFile("save.txt") then t.window.title = "This has been erased" end
	t.window.width = 1024
	t.window.height = 768
	t.window.resizable = true
	t.window.vsync = false

	t.modules.joystick = false
	t.modules.physics = false
end