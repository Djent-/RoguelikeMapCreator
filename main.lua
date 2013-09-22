--[[
PATRICK HURD
@Djent_
8:33:13 September 21st 2013 CE
Version 1.0.0.3

For use in testing Roguelove.
--]]

function love.load()
	love.graphics.setMode(792,589)
	prime = love.graphics.newFont("Courier Prime.ttf", 20)
	love.graphics.setFont(prime)
	key = ""
	keytimer = 0
	map = {}
	blankMap()
end

function love.draw()
	--draw background
	love.graphics.setColor(30,30,30)
	local z = 1
	for y = 0, 31 do
		for x = 0, 66 do
			if z/2 == math.floor(z/2) then love.graphics.rectangle("fill", x*12,y*19,12,19) end
			z = z + 1
		end
	end
	love.graphics.setColor(255,255,255)
	local z = 1
	for y = 0, 31 do
		for x = 0, 66 do
			if type(map[z]) == "string" then love.graphics.print(map[z], x*12, y*19) end
			z = z + 1
		end
	end
end

function love.update()
	keyboardInput()
end

function love.mousepressed(x,y,b)
	x1 = math.ceil(x/12)
	y1 = math.floor(y/19)
	xd = x1
	yd = y1
	if y1 >= 1 then
		z = y1 * 67 + x1
	else
		z = x1
	end
	d = z
	if key ~= "" then
		map[z] = key
	end
end

function keyboardInput()
	if love.timer.getTime() - keytimer > .1 then
		if (love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) and love.keyboard.isDown("\\") then
			key = "|"
		elseif love.keyboard.isDown("-") then
			key = "-"
		elseif love.keyboard.isDown(".") then
			key = "."
		elseif love.keyboard.isDown("lshift") and love.keyboard.isDown("3") then
			key = "#"
		elseif (love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) and love.keyboard.isDown("=") then
			key = "+"
		elseif love.keyboard.isDown(" ") then
			key = " "
		elseif love.keyboard.isDown("return") then
			saveFile()
		end
		keytimer = love.timer.getTime()
	end
end

function saveFile()
	savedata = "function mapdata() \n\tmap = {\""
	for x = 1, #map do
		if x == #map then savedata = savedata .. map[x] .. "\"} \nend\n" break end
		savedata = savedata .. map[x] .. "\",\""
	end
	io.output(io.open("mapdata.lua","w"))
	io.write(savedata)
	io.close()
end

function blankMap()
	local z = 1
	for y = 0,30 do
		for x = 0,65 do
			map[z] = " "
			z = z + 1
		end
	end
end