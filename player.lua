Player = Object.extend(Object)

function Player.new(self, x, y, health, max_health)
    self.image = love.graphics.newImage("player.png")
    self.position = {}
    self.position.x = x
    self.position.y = y
    self.health = health
    self.max_health = max_health
end

function Player.update(self, dt)

end

function Player.draw(self)
    return self.image
end

function Player.addHealth(self, add)
    self.health = self.health + add
    if self.health > self.max_health then 
        self.health = self.max_health
        return false
    end

    return true
end