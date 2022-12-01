require "vector"
require "poly"

function love.load()
    math.randomseed(os.time())
    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()

    R = 40

    Poly1 = Poly:create(200, 200, {-R, -R, R, -R, R, R, -R, R}, -0.25 * math.pi)
    Poly2 = Poly:create(300, 150, {-R, -R, R, -R, R, R, -R, R}, -0.25 * math.pi)
    collide(Poly1, Poly2)
end

function love.draw()
    Poly1:draw()
    Poly2:draw()
end

function love.mousepressed(x, y, button)
    if (button == 1) then
		Poly1.x = x
        Poly1.y = y
    elseif (button == 2) then
        Poly2.x = x
        Poly2.y = y
    end
    collide(Poly1, Poly2)
end

function collide(Poly1, Poly2)
    local dot10 = Poly1:getDot(0)
    local dot11 = Poly1:getDot(2)
    local dot20 = Poly2:getDot(0)
    local dot24 = Poly2:getDot(1)

    local axis = Vector:create(1, -1)
    axis:norm()

    local C = Vector:create(dot20.x - dot10.x, dot20.y - dot10.y)
    local A = Vector:create(dot11.x - dot10.x, dot11.y - dot10.y)
    local B = Vector:create(dot24.x - dot20.x, dot24.y - dot20.y)

    local projC = dotProduct(C, axis)
    local projA = dotProduct(A, axis)
    local projB = dotProduct(B, axis)
    
    local gap = projC - projA + projB
    if (gap > 0) then
        print("No collision.")
    else
        print("Collision detected!")
    end
end

function dotProduct(vec1, vec2)
    return (vec1.x * vec2.x + vec1.y * vec2.y)
end