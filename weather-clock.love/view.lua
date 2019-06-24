function view(location,data,font)
	love.graphics.setFont(font)
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle("fill",location.x,location.y,location.w,location.h)
	love.graphics.setColor(255,255,255)
	love.graphics.print(data,location.x,location.y)
end
