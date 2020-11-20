Player = Object.extend(Object)

function Player.new(self, x, y)
    self.image = love.graphics.newImage("player.png")
    self.tile_x = x
    self.tile_y = y
end

function Player.update(self, dt)

end

function Player.draw(self)
    return self.image
end