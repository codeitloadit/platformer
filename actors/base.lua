module(..., package.seeall)
class = require('lib/30log')

Base = class()
function Base:__init(l, t, w, h)
    self.l, self.t, self.w, self.h = l, t, w, h
end

function Base:update(dt)
    
end

function Base:draw()
    g.setColor(15, 15, 15)
    love.graphics.rectangle('line', self.l, self.t, self.w, self. h)
end

function Base:getBBox()
    return self.l, self.t, self.w, self.h
end

function Base:collision(other, dx, dy)
end

function Base:endCollision(other)
end

return Base