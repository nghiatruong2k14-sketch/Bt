-- main.lua
-- Menu xoay vòng tròn có thể chỉnh tốc độ

local angle = 0
local speed = 2
local menuOpen = true

local buttons = {
    {text = "Tăng tốc [+]", x = 40, y = 120, w = 200, h = 40},
    {text = "Giảm tốc [-]", x = 40, y = 170, w = 200, h = 40},
    {text = "Đóng/Mở Menu [M]", x = 40, y = 220, w = 200, h = 40}
}

function love.update(dt)
    angle = angle + speed * dt
end

function love.draw()

    ------------------------
    -- Vòng xoay
    ------------------------
    local cx, cy = 500, 300
    local radius = 100

    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", cx, cy, radius)

    local x = cx + math.cos(angle) * radius
    local y = cy + math.sin(angle) * radius

    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill", x, y, 15)

    ------------------------
    -- MENU
    ------------------------
    if menuOpen then

        -- Background menu
        love.graphics.setColor(0.1,0.1,0.1,0.85)
        love.graphics.rectangle("fill", 20, 50, 250, 250, 15, 15)

        -- Tiêu đề
        love.graphics.setColor(0,1,1)
        love.graphics.print("MENU XOAY", 90, 70, 0, 2, 2)

        -- Hiển thị tốc độ
        love.graphics.setColor(1,1,1)
        love.graphics.print("Tốc độ: "..string.format("%.1f", speed), 70, 95)

        -- Buttons
        for i,btn in ipairs(buttons) do
            love.graphics.setColor(0.2,0.2,0.2)
            love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h, 10,10)

            love.graphics.setColor(1,1,1)
            love.graphics.printf(
                btn.text,
                btn.x,
                btn.y + 12,
                btn.w,
                "center"
            )
        end
    end
end

function love.keypressed(key)

    if key == "kp+" or key == "=" then
        speed = speed + 0.5
    end

    if key == "kp-" or key == "-" then
        speed = speed - 0.5
    end

    if key == "m" then
        menuOpen = not menuOpen
    end
end

function love.mousepressed(x, y, button)

    if button == 1 and menuOpen then

        -- Tăng tốc
        if x > 40 and x < 240 and y > 120 and y < 160 then
            speed = speed + 0.5
        end

        -- Giảm tốc
        if x > 40 and x < 240 and y > 170 and y < 210 then
            speed = speed - 0.5
        end

        -- Ẩn/Hiện menu
        if x > 40 and x < 240 and y > 220 and y < 260 then
            menuOpen = false
        end
    end
end
