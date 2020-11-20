Object = require "classic"
require "player"
require "room"
require "health"

local window_width = 800
local window_height = 600
local scale = 5

local max_health = 5

local health_empty_image;
local health_full_image;
local tileset_image;

local tile_width;
local tile_height;

local health;
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

    health_empty_image = love.graphics.newImage("heart_empty.png")
    health_full_image = love.graphics.newImage("heart_full.png")

    tileset_image = love.graphics.newImage("tileset.png")
    tile_width = (tileset_image:getWidth() / 3) - 2
    tile_height = (tileset_image:getHeight() / 3) - 2

    local pos = getRandomPosition()
    health = Health(pos.x, pos.y)

    pos = getRandomPosition()
    player = Player(pos.x, pos.y, 3, max_health)

    room = Room(tileset_image, tilemap)
end

function love.update(dt)
    player:update(dt)
    room:update(dt)
    health:update(dt)

    if player.position.x == health.position.x and player.position.y == health.position.y and health.active then
        health:pickUp(player)
    end
end

function love.keyreleased(key)
    local pos = {}
    pos.x = player.position.x
    pos.y = player.position.y

    if key == "left" then 
        pos.x = pos.x - 1
    elseif key == "right" then 
        pos.x = pos.x +  1
    elseif key == "up" then 
        pos.y = pos.y - 1
    elseif key == "down" then 
        pos.y = pos.y + 1
    end

    if isEmpty(pos) then
        player.position = pos
    end
end

function isEmpty(point)
    return tilemap[point.y][point.x] == 5
end

function getRandomPosition()
    result = {}
    result.x = 0
    result.y = 0
    local safe = 1000
    repeat
        result.x = love.math.random(1, map_width)
        result.y = love.math.random(1, map_height)
        safe = safe - 1
        if isEmpty(result) then return result end
    until ( safe <= 0 )
end

function love.draw()
    love.graphics.scale(scale, scale)
    local r = 34 / 255
    local g = 34 / 255
    local b = 35 / 255
    love.graphics.setBackgroundColor(r, g, b , 1)

    room:draw()

    if health.active then
        love.graphics.draw(health:draw(), health.position.x * tile_width, health.position.y * tile_height)
    end

    love.graphics.draw(player:draw(), player.position.x * tile_width, player.position.y * tile_height)

    local width = health_full_image:getWidth()
    for i=1,max_health do
        local image;
        if i > player.health then 
            image = health_empty_image
        else
            image = health_full_image
        end
        love.graphics.draw(image, i * width, 0)
    end
end