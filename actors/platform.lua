module(..., package.seeall)

Base = require('actors/base')

Platform = Base:extends()

function Platform:__init(l, t, w, h, solid)
    self.super.__init(self, l, t, w, h)

    self.name = 'Platform'

    self.solid = solid

    -- self.triangles = {}

    -- for i=0, self.w-1, 10 do
    --     self.triangles[#self.triangles+1] = {self.l+i, self.t, self.l+i+5, self.t+math.random(5,12), self.l+i+10, self.t}
    -- end

end

function Platform:toggle()
    if self.solid then self.solid = false else self.solid = true end
end

function Platform:draw()
    if self.solid then
        g.setColor(15, 15, 15)
        love.graphics.rectangle('line', self.l, self.t, self.w, self. h)

        -- for _, t in pairs(self.triangles) do
        --     -- g.setColor(240, 240, 240)
        --     -- love.graphics.triangle('fill', t[1], t[2], t[3], t[4], t[5], t[6])
        --     -- g.setColor(15, 15, 15)
        --     love.graphics.triangle('line', t[1], t[2], t[3], t[4], t[5], t[6])
        -- end
    else
        g.setColor(15, 15, 15)
        love.graphics.rectangle('line', self.l, self.t, self.w, self. h)
    end
end

return Platform