-- Khởi tạo các biến góc và tốc độ ban đầu
local goc = 0
local toc_do_xoay = 50 -- Đơn vị: độ/giây
local ban_kinh = 10    -- Bán kính vòng tròn

-- Hàm hiển thị menu đơn giản ra màn hình console
local function hien_thi_menu()
    print("\n--- MENU CHỈNH TỐC ĐỘ ---")
    print("Tốc độ hiện tại: " .. toc_do_xoay .. " độ/giây")
    print("1. Tăng tốc độ (+10)")
    print("2. Giảm tốc độ (-10)")
    print("3. Dừng xoay (Đặt về 0)")
    print("Nhập số từ 1-3 để chọn, hoặc nhập bất kỳ số nào khác để đặt tốc độ tùy ý:")
end

-- Hàm xử lý khi người dùng chọn menu
local function xu_ly_menu(lua_chon)
    local so = tonumber(lua_chon)
    if so == 1 then
        toc_do_xoay = toc_do_xoay + 10
    elseif so == 2 then
        toc_do_xoay = toc_do_xoay - 10
    elseif so == 3 then
        toc_do_xoay = 0
    elseif so then
        toc_do_xoay = so -- Nếu nhập số khác thì lấy số đó làm tốc độ luôn
    else
        print("Lựa chọn không hợp lệ!")
    end
end

-- Hàm cập nhật vị trí xoay (Chạy liên tục trong vòng lặp game)
-- dt (Delta Time) là khoảng thời gian giữa 2 khung hình (ví dụ: 1/60 giây)
local function cap_nhat_toa_do(dt)
    -- Tính góc mới dựa trên tốc độ và thời gian trôi qua
    goc = goc + toc_do_xoay * dt
    
    -- Giới hạn góc trong khoảng 0-360 độ cho gọn
    if goc >= 360 then goc = goc - 360 end
    if goc < 0 then goc = goc + 360 end

    -- Đổi từ độ sang Radian để dùng cho hàm toán học math.sin/cos
    local radian = math.rad(goc)
    
    -- Công thức lượng giác để tìm tọa độ X, Y trên vòng tròn
    local x = ban_kinh * math.cos(radian)
    local y = ban_kinh * math.sin(radian)
    
    -- In ra tọa độ hiện tại để kiểm tra
    print(string.format("Góc: %3d° | Tọa độ X: %6.2f | Y: %6.2f", goc, x, y))
end

-- =======================================================
-- MÔ PHỎNG CHƯƠNG TRÌNH CHẠY (Thực tế sẽ chạy theo khung hình của Engine)
-- =======================================================

print("Bắt đầu xoay vật thể...")
hien_thi_menu()

-- Mô phỏng chạy 3 bước với tốc độ mặc định (dt = 0.1 giây mỗi bước)
print("\n--- Vật thể đang xoay ---")
cap_nhat_toa_do(0.1)
cap_nhat_toa_do(0.1)

-- Mô phỏng người dùng chọn Menu: Nhập "1" để tăng tốc độ
print("\n[Hệ thống]: Người dùng chọn '1' trên menu để tăng tốc.")
xu_ly_menu("1") 

hien_thi_menu()
print("\n--- Vật thể tiếp tục xoay với tốc độ mới ---")
cap_nhat_toa_do(0.1)
cap_nhat_toa_do(0.1)
