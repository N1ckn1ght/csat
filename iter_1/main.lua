require "poly"

function love.load()
    math.randomseed(os.time())
    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()

    R = 40

    Poly1 = Poly:create(200, 200, {-R, -R, R, -R, R, R, -R, R}, 0)
    Poly2 = Poly:create(300, 200, {-R, -R, R, -R, R, R, -R, R}, 0)
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
    local length = Poly2.x - Poly1.x
    local gap = length - 2 * R
    if (gap > 0) then
        print("No collision.")
    else
        print("Collision detected!")
    end
end