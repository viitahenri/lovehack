Stairs = Object.extend(Object)

function Stairs.new(self, x, y)
    self.image = love.graphics.newImage("stairs_down.png")
    self.tile_x = x
    self.tile_y = y
end

function Stairs.update(self, dt)

end

function Stairs.draw(self)
    return self.image
end