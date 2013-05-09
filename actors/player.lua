module(..., package.seeall)

Base = require('actors/base')

Player = Base:extends()

local function sign(x)
    return x < 0 and -1 or (x > 0 and 1 or 0)
end

function Player:__init(l, t, w, h)
    self.super.__init(self, l, t, w, h)
    self.name = 'Player'

    self.vx = 0
    self.vy = 0

    self.incX = 20
    self.mx = 350
    self.my = 550
    self.jumpLevel = 0
    self.isGrounded = false
end

function Player:update(dt)
    if keyDown('a') then
        self.vx = self.vx - self.incX
        if self.vx < -self.mx then self.vx = -self.mx end
    elseif keyDown('d') then
        self.vx = self.vx + self.incX
        if self.vx > self.mx then self.vx = self.mx end
    elseif self.vx ~= 0 then
        self.vx = self.vx * 0.83
        if self.vx > -self.incX and self.vx < self.incX then self.vx = 0 end
    end

    global.debugString = tostring(self.isGrounded)

    -- if self.vx < 1 and self.vx > -1 then self.mx = 350 end

    self.l = self.l + self.vx * dt
    self.t = self.t + self.vy * dt
    self.vy = self.vy + global.gravity * dt
end

function Player:jump()
    if self.jumpLevel == 0 and self.isGrounded then
        self.jumpLevel = 1
        self.vy = -self.my
        self.mx = self.mx * 0.7
    elseif self.vy > -200 and self.vy < 200 and self.jumpLevel == 1 then
        self.jumpLevel = 2
        self.vy = -self.my * 0.9 --90%
        self.mx = self.mx * 0.8 --80%
    -- elseif self.vy > -50 and self.jumpLevel == 2 then
    --     self.jumpLevel = 3
    --     self.vy = -350
    --     self.mx = self.mx * 0.8
    end
end

function Player:collision(other, dx, dy)
    -- if instanceOf(Coin, other) then
    --     other:destroy()
    --     self.coins = self.coins + 1
    -- else
    if other.solid then
        if dx~=0 or dy~=0 then -- it can only be a platform then
            if dx~=0 and sign(self.vx) ~= sign(dx) then self.vx = 0 end
            if dy~=0 and sign(self.vy) ~= sign(dy) then self.vy = 0 end

            -- if we hit a floor
            if dy < 0 then
                self.jumpLevel = 0
                self.mx = 350
                self.isGrounded = true
            end

            -- update the player position so that the intersection stops occurring
            self.l, self.t = self.l + dx, self.t + dy
        end
    end
end

function Player:endCollision(other)
    -- if self.vy > 50 then
    --     self.isGrounded = false
    -- end
end

return Player
