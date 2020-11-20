Health = Object.extend(Object)

function Health.new(self, x, y)
    self.image = love.graphics.newImage("heart_full.png")
    self.position = {}
    self.position.x = x
    self.position.y = y
    self.active = true
end

function Health.pickUp(self, player)
    if not self.active then return end

    local healed = player:addHealth(1)
    if healed then
        self.active = false
    end
end

function Health.update(self, dt)

end

function Health.draw(self)
    return self.image
end