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

function love.keypressed(key)
    if key == "q" then
        Poly1.angle = Poly1.angle - math.pi / 60
        collide(Poly1, Poly2)
    end
    if key == "e" then
        Poly1.angle = Poly1.angle + math.pi / 60
        collide(Poly1, Poly2)
    end
    if key == "a" then
        Poly2.angle = Poly2.angle - math.pi / 60
        collide(Poly1, Poly2)
    end
    if key == "d" then
        Poly2.angle = Poly2.angle + math.pi / 60
        collide(Poly1, Poly2)
    end
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
    local axis = Vector:create(1, -1)
    axis:norm()

    print(Poly1:getMinProj(axis), Poly1:getMaxProj(axis), Poly2:getMinProj(axis), Poly2:getMaxProj(axis))
    if ((Poly2:getMaxProj(axis) < Poly1:getMinProj(axis)) or (Poly1:getMaxProj(axis) < Poly2:getMinProj(axis))) then
        print("No collision.")
    else
        print("Collision detected!")
    end
end