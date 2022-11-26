Poly = {}
Poly.__index = Poly

function Poly:create(x, y, vertices, angle)
    local poly = {}
    setmetatable(poly, Poly)

    poly.x = x
    poly.y = y
    poly.vertices = vertices
    poly.angle = angle

    return poly
end

function Poly:draw()
    love.graphics.push()
    love.graphics.translate(self.x, self.y)
    love.graphics.rotate(self.angle)
    love.graphics.polygon("line", self.vertices)
    love.graphics.pop()
end

function Poly:getDot(index)
    if (index == 0) then
        return Vector:create(self.x, self.y)
    end

    local first = index * 2 - 1
    local second = index * 2
    if (self.vertices[first] ~= nil and self.vertices[second] ~= nil) then
        local x = self.vertices[index * 2 - 1]
        local y = self.vertices[index * 2]
        -- values of angle are negative since it's a CLOCKWISE rotation
        local xReal = x * math.cos(-self.angle) - y * math.sin(-self.angle)
        local yReal = x * math.sin(-self.angle) + y * math.cos(-self.angle)
        return Vector:create(xReal + self.x, yReal + self.y)
    else
        return nil
    end
end