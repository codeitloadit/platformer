module(..., package.seeall)

g.setBackgroundColor(15, 15, 15)

function love.update(dt)

end

function love.draw(dt)
    love.graphics.setColor(240, 240, 240)
    love.graphics.print('Test state activated!', 0, 0)
end

function love.keypressed(key)
    if key == 'q' then love.event.push('quit') end
    if key == ' ' then global:setGameState('debug') end
end
