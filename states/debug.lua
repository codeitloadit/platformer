module(..., package.seeall)

local bump = require('lib/bump')

Player = require('actors/player')
Platform = require('actors/platform')

actors = {}
global.platforms = {}

player = Player:new(SW/2-15, SH-60, 30, 30)
actors[#actors+1] = player
bump.add(player)

global.platforms[#global.platforms+1] = Platform:new(SW/2-300, SH-30, 600, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2+100, SH-120, 30, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2-100, SH-210, 30, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2-300, SH-300, 30, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2-100, SH-390, 30, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2+100, SH-480, 30, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2-300, SH-570, 30, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2-100, SH-660, 30, 30, true)
global.platforms[#global.platforms+1] = Platform:new(SW/2-300, SH-750, 600, 30, true)

for _, platform in pairs(global.platforms) do
    actors[#actors+1] = platform
    bump.add(platform)
end

g.setBackgroundColor(240, 240, 240)

function love.update(dt)
    for _, actor in pairs(actors) do
        actor:update(dt)
    end
    bump.collide()
end

function love.draw()
    for _, actor in pairs(actors) do
        actor:draw()
    end

    g.setColor(15, 15, 15)
    g.print('FPS: '..tostring(love.timer.getFPS()..
        '\nDebug: '..global.debugString), 0, 0)
end

function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end
    if key == 'r' then global:setGameState('debug') end

    if key == 'down' then 
        player:jump()

        -- for _, platform in pairs(global.platforms) do
        --     platform:toggle()
        -- end
    end

    if key == 'left' then
        player.mx = player.mx * 1.1
        player.my = player.my * 1.1
    end

end

function love.keyreleased(key)
    if key == 'left' then
        player.mx = player.mx * 0.9090911
        player.my = player.my * 0.9090911
    end
end

function bump.collision(objectA, objectB, dx, dy)
    -- print(item1.name, "collision with", item2.name, "displacement vector:", dx, dy)
    objectA:collision(objectB,  dx,  dy)
    objectB:collision(objectA, -dx, -dy)
end

function bump.endCollision(objectA, objectB)
    -- print(item1.name, "stopped colliding with", item2.name)
    objectA:endCollision(objectB)
    objectB:endCollision(objectA)
end

-- function bump.getBBox(item)
--   return item.l, item.t, item.w, item.h
-- end

-- function bump.shouldCollide(item1, item2)
--   return true -- we could add certain conditions here - for example, make objects of the same group not collide
-- end