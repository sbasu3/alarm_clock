local http = require("socket.http")
local json = require("json")
local ltn12 = require("ltn12")
require("./view")

function love.load()
	success = love.window.setMode(480,320,{fullscreen=false,vsync=true,resizable=flase})
	T=11
	lasttime = 0
	weather_url = "http://api.openweathermap.org/data/2.5/weather?lat=12.88&lon=77.58&APPID=222bc56201e319d82a0c478a10ccb03c"
	response ={}
	carbon_font_20 = love.graphics.newFont("/fonts/carbon_bl.ttf",20)
	carbon_font_40 = love.graphics.newFont("/fonts/carbon_bl.ttf",40)
	carbon_font_60 = love.graphics.newFont("/fonts/carbon_bl.ttf",60)
	carbon_font_80 = love.graphics.newFont("/fonts/carbon_bl.ttf",80)
	alarm = love.graphics.newImage("/img/alarm.png")
	alert = love.graphics.newImage("/img/alert.png")
	cloud = love.graphics.newImage("/img/cloud.png")
	hail = love.graphics.newImage("/img/hail.png")
	night_clear = love.graphics.newImage("/img/night_clear.png")
	simple_cloud = love.graphics.newImage("/img/simple_cloud.png")
	snooze = love.graphics.newImage("/img/snooze.png")
	sunny = love.graphics.newImage("/img/sunny.png")
	thunder = love.graphics.newImage("/img/thunder.png")

end
 
function love.update(dt)
	T = T+dt
	if ( T - lasttime > 10) then
		print("Lasttime:"..lasttime)
		lasttime = T
		print("Time:"..T)
		save = ltn12.sink.table(response)
		a,b,c = http.request {method="GET",url = weather_url,sink = save }
		data = json.decode(response[1])
		if data == nil then
			print("Error in fetching data")
		else
			print("Data fetched successfully")
		end

	end
end
 
function love.draw()
    if data == nil then
		view({w=480,h=320,x=0,y=0},"Fetching Data",carbon_font_40)
	else
		view({w=160,h=60,x=30,y=0},"Temp:"..(tonumber(data.main.temp)-273),carbon_font_20)
		view({w=160,h=60,x=190,y=0},os.date("%x"),carbon_font_20)
		view({w=160,h=60,x=350,y=0},"Humidity:"..data.main.humidity.."%",carbon_font_20)
		view({w=160,h=60,x=30,y=280},"Sbasu3",carbon_font_20)
		view({w=160,h=60,x=190,y=280},"Wind:"..data.wind.speed.."KM/Hr",carbon_font_20)
		view({w=160,h=60,x=350,y=280},"Clouds:"..data.clouds.all.."%",carbon_font_20)
		view({w=280,h=140,x=200,y=90},os.date("%X"),carbon_font_80)
		--love.graphics.draw(sunny,30,90);

		if data.weather[1].main == "Clear" then
			love.graphics.draw(sunny,30,90);
		elseif data.weather[1].main == "Clouds" then
			love.graphics.draw(simple_cloud,30,90);
		elseif data.weather[1].main == "Rain" then
			love.graphics.draw(cloud,30,90);
		elseif data.weather[1].main == "Thunderstorm" then
			love.graphics.draw(thunder,30,90);
		elseif data.weather[1].main == "Snow" then
			love.graphics.draw(hail,30,90);
		elseif data.weather[1].main == "Drizzle" then
			love.graphics.draw(cloud,30,90);
		elseif data.weather[1].main == "Mist" then
			love.graphics.draw(cloud,30,90);
		elseif data.weather[1].main == "Fog" then
			love.graphics.draw(cloud,30,90);
		elseif data.weather[1].main == "Smoke" then
			love.graphics.draw(cloud,30,90);
		elseif data.weather[1].main == "Dust" then
			love.graphics.draw(cloud,30,90);
		end
	end
end
