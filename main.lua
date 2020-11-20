Object = require "classic"
require "player"
require "room"

local window_width = 800
local window_height = 600
local scale = 5

local image;
local tile_width;
local tile_height;
local player;
local room;

local tilemap = {
    {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6},
    {7, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 9},
}

local map_width = 16
local map_height = 11

function love.load()
    love.window.setTitle("Lovehack")
    love.window.setMode(window_width, window_height)
    love.graphics.setDefaultFilter("nearest", "nearest", 0)

    image = love.graphics.newImage("tileset.png")
    tile_width = (image:getWidth() / 3) - 2
    tile_height = (image:getHeight() / 3) - 2

    player = Player(2, 2)

    room = Room(image, tilemap)
end

function love.update(dt)
    player:update(dt)
    room:update(dt)
end

function love.keyreleased(key)
    local x = player.tile_x
    local y = player.tile_y

    if key == "left" then 
        x = x - 1
    elseif key == "right" then 
        x = x +  1
    elseif key == "up" then 
        y = y - 1
    elseif key == "down" then 
        y = y + 1
    end

    if isEmpty(x, y) then
        player.tile_x = x
        player.tile_y = y
    end
end

function isEmpty(x, y)
    return tilemap[y][x] == 5
end

function love.draw()
    love.graphics.scale(scale, scale)
    local r = 34 / 255
    local g = 34 / 255
    local b = 35 / 255
    love.graphics.setBackgroundColor(r, g, b , 1)

    room:draw()

    love.graphics.draw(player:draw(), player.tile_x * tile_width, player.tile_y * tile_height)
end