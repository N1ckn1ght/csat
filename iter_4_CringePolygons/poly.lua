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
        local x = self.vertices[first]
        local y = self.vertices[second]
        local xReal = x * math.cos(self.angle) - y * math.sin(self.angle)
        local yReal = x * math.sin(self.angle) + y * math.cos(self.angle)
        return Vector:create(xReal + self.x, yReal + self.y)
    else
        return nil
    end
end

function Poly:getMinMaxProj(axis)
    local dot = self:getDot(1)
    local min_proj = dotProduct(Vector:create(dot.x, dot.y), axis)
    local max_proj = min_proj
    for i = 2, #self.vertices / 2 do
        dot = self:getDot(i)
        local curr_proj = dotProduct(Vector:create(dot.x, dot.y), axis)
        if (curr_proj < min_proj) then
            min_proj = curr_proj
        end
        if (curr_proj > max_proj) then
            max_proj = curr_proj
        end
    end
    return {min_proj, max_proj}
end

function Poly:getNormals()
    local normals = {}
    local current_dot = nil
    local previous_dot = nil
    for i = 1, #self.vertices / 2 do
        previous_dot = current_dot or self:getDot(#self.vertices / 2)
        current_dot = self:getDot(i)
        local px = current_dot.x - previous_dot.x
        local py = current_dot.y - previous_dot.y
        -- works only on clockwise cycling?
        normals[i] = Vector:create(-py, px)
        -- normals[i] = Vector:create(py, -px)
    end
    return normals
end

function dotProduct(vec1, vec2)
    return (vec1.x * vec2.x + vec1.y * vec2.y)
end