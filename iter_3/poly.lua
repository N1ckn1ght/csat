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
        local xReal = x * math.cos(self.angle) - y * math.sin(self.angle)
        local yReal = x * math.sin(self.angle) + y * math.cos(self.angle)
        return Vector:create(xReal + self.x, yReal + self.y)
    else
        return nil
    end
end

function Poly:getMinProj(axis)
    local min_proj_dot = 1
    local min_proj = dotProduct(Vector:create(self:getDot(1).x, self:getDot(1).y), axis)
    for i = 2, #self.vertices / 2 do
        local curr_proj = dotProduct(Vector:create(self:getDot(i).x, self:getDot(i).y), axis)
        if (curr_proj < min_proj) then
            min_proj = curr_proj
            min_proj_dot = i
        end
    end
    return min_proj
end

function Poly:getMaxProj(axis)
    local max_proj_dot = 1
    local max_proj = dotProduct(Vector:create(self:getDot(1).x, self:getDot(1).y), axis)
    for i = 2, #self.vertices / 2 do
        local curr_proj = dotProduct(Vector:create(self:getDot(i).x, self:getDot(i).y), axis)
        if (curr_proj > max_proj) then
            max_proj = curr_proj
            max_proj_dot = i
        end
    end
    return max_proj
end

function dotProduct(vec1, vec2)
    return (vec1.x * vec2.x + vec1.y * vec2.y)
end