require "vector"
require "poly"

function love.load()
    math.randomseed(os.time())
    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()

    R = 40

    Poly1 = Poly:create(200, 200, {-R, 0, 0, -R, R, 0, R * 3 / 5, R, -R * 3 / 5, R}, 0)
    Poly2 = Poly:create(300, 150, {-R, -R, R, 0, -R, R}, -0.25 * math.pi)
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

function collide(poly1, poly2)
    local np1 = poly1:getNormals()
    local np2 = poly2:getNormals()
    for _, np in pairs({np1, np2}) do
        for _, v in pairs(np) do
            local p = poly1:getMinMaxProj(v)
            local q = poly2:getMinMaxProj(v)
            if ((p[2] < q[1]) or (q[2] < p[1])) then
                print("No collision.")
                return
            end
        end
    end

    print("Collision detected!")
end