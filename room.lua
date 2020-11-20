Room = Object.extend(Object)

function Room.new(self, image, tilemap)
    self.image = image
    self.tile_width = (self.image:getWidth() / 3) - 2
    self.tile_height = (self.image:getHeight() / 3) - 2

    self.quads = {}

    for i=0,2 do
        for j=0,2 do
            table.insert(self.quads, 
                love.graphics.newQuad(
                    1 + j * (self.tile_width + 2),
                    1 + i * (self.tile_height + 2),
                    self.tile_width, self.tile_height, self.image:getDimensions()))
        end
    end

    self.tilemap = tilemap
end

function Room.update(self, dt)

end

function Room.draw(self)
    for i,row in ipairs(self.tilemap) do
        for j,tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(self.image, self.quads[tile], j * self.tile_width, i * self.tile_height)
            end 
        end
    end
end