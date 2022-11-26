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