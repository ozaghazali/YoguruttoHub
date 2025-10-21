--[[

    WindUI YoruHub 1.0
    
]]


local WindUI

do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end
end

-- ===================================================================
-- [[ AWAL DARI KODE INTEGRASI ]]
-- ===================================================================

-- Mengambil Services dan Variabel yang Diperlukan
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Fungsi Teleport Umum (dipakai bersama)
local function teleportCharacter(character, position)
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- Variabel untuk menyimpan UI Toggle (agar bisa disilang-matikan)
local autoTeleportToggle_Mika = nil
local autoTeleportToggle_Gemi = nil
local autoTeleportToggle_Beaja = nil
local autoTeleportToggle_Maaf = nil
local autoTeleportToggle_Kota = nil 
local autoTeleportToggle_Yahayuk = nil -- [DITAMBAHKAN]

-- -------------------------------------------------------------------
-- KODE UNTUK MOUNT MIKA (Mount 1)
-- -------------------------------------------------------------------
local teleportLocations_Mika = {
    Vector3.new(516.6929931640625, 193.8096923828125, -552.5011596679688),
    Vector3.new(646.3467407226562, 177.81179809570312, -635.9164428710938),
    Vector3.new(1106.0369873046875, 217.80970764160156, -360.0383605957031),
    Vector3.new(1181.2825927734375, 221.80970764160156, -568.0306396484375),
    Vector3.new(1328.599365234375, 255.16400146484375, -598.1030883789062),
    Vector3.new(1499.004638671875, 382.2225036621094, -626.5504150390625),
    Vector3.new(1512.4232177734375, 454.0096740722656, -134.4698944091797),
    Vector3.new(1230.667236328125, 430.00970458984375, -114.93517303466797),
    Vector3.new(1120.10498046875, 446.004150390625, 30.018861770629883),
    Vector3.new(678.1668701171875, 598.0096435546875, -249.78890991210938),
    Vector3.new(954.8308715820312, 653.9006958007812, -61.01375961303711),
    Vector3.new(983.54150390625, 677.65966796875, -223.9095458984375),
    Vector3.new(1050.96826171875, 678.0096435546875, -21.644765853881836),
    Vector3.new(488.0829772949219, 650.0096435546875, 656.766845703125),
    Vector3.new(430.4913635253906, 819.7410888671875, 1196.420166015625),
    Vector3.new(480.577392578125, 922.7679443359375, 1839.048095703125),
    Vector3.new(473.0296630859375, 963.4253540039062, 2059.5498046875)
}
local autoTeleportEnabled_Mika = false
local teleportCoroutine_Mika
local godModeConnection_Mika
local teleportDelay_Mika = 1.3 -- [[ VARIABEL INI SEKARANG DIKONTROL OLEH SLIDER ]]
local currentTeleportIndex_Mika = 0

local function activateGodMode_Mika(humanoid)
    humanoid.Health = humanoid.MaxHealth
    if godModeConnection_Mika then godModeConnection_Mika:Disconnect() end
    godModeConnection_Mika = humanoid.HealthChanged:Connect(function()
        if autoTeleportEnabled_Mika then
            humanoid.Health = humanoid.MaxHealth
        else
            if godModeConnection_Mika then
                godModeConnection_Mika:Disconnect()
                godModeConnection_Mika = nil
            end
        end
    end)
end

local function stopAutoTeleport_Mika()
    autoTeleportEnabled_Mika = false
    if godModeConnection_Mika then
        godModeConnection_Mika:Disconnect()
        godModeConnection_Mika = nil
    end
    if teleportCoroutine_Mika then
        coroutine.close(teleportCoroutine_Mika)
        teleportCoroutine_Mika = nil
    end
end

local function startTeleportLoop_Mika()
    while autoTeleportEnabled_Mika do
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character.Parent or humanoid.Health <= 0 then
            print("Mika: Karakter belum siap, menunggu respawn...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end

        if not autoTeleportEnabled_Mika then break end
        currentTeleportIndex_Mika = currentTeleportIndex_Mika + 1

        if currentTeleportIndex_Mika > #teleportLocations_Mika then
            currentTeleportIndex_Mika = 0
            if godModeConnection_Mika then
                godModeConnection_Mika:Disconnect()
                godModeConnection_Mika = nil
            end
            print("Mika: Siklus teleport selesai. Kembali ke start...")
            game:GetService("ReplicatedStorage").CP_DropToStart:FireServer()
            task.wait(2.5) 
            continue
        end
        
        activateGodMode_Mika(humanoid)
        local location = teleportLocations_Mika[currentTeleportIndex_Mika]
        print(string.format("Mika: Auto Teleport ke Lokasi %d (Delay: %.1fs)", currentTeleportIndex_Mika, teleportDelay_Mika))
        teleportCharacter(character, location)
        task.wait(teleportDelay_Mika) -- Menggunakan delay dari slider
        
        if not autoTeleportEnabled_Mika then break end
        if not character.Parent or humanoid.Health <= 0 then
            print("Mika: Karakter mati. Mereset...")
            currentTeleportIndex_Mika = 0
            if godModeConnection_Mika then
                godModeConnection_Mika:Disconnect()
                godModeConnection_Mika = nil
            end
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end
    end
end

-- -------------------------------------------------------------------
-- KODE UNTUK MOUNT GEMI (Mount 2)
-- -------------------------------------------------------------------
local teleportLocations_Gemi = {
    Vector3.new(850.3866577148438, 631.5690307617188, 1144.0350341796875),
    Vector3.new(645.9818725585938, 631.2415161132812, 1147.972900390625),
    Vector3.new(555.5932006835938, 707.5690307617188, 1125.379638671875),
    Vector3.new(-199.89993286132812, 771.5690307617188, 1025.2025146484375),
    Vector3.new(-194.77223205566406, 771.5690307617188, 276.277099609375),
    Vector3.new(-287.89910888671875, 639.5690307617188, 175.0592498779297),
    Vector3.new(-639.2085571289062, 771.5690307617188, 9.303144454956055),
    Vector3.new(-964.3776245117188, 775.5690307617188, 439.8299255371094),
    Vector3.new(-1513.415771484375, 943.5690307617188, 780.7603149414062),
    Vector3.new(-1925.3817138671875, 943.5690307617188, 191.7897491455078),
    Vector3.new(-2434.858154296875, 779.5690307617188, -255.02557373046875),
    Vector3.new(-2079.968017578125, 1051.5689697265625, -381.79815673828125),
    Vector3.new(-1756.7718505859375, 1219.5689697265625, -484.61761474609375),
    Vector3.new(-1875.0968017578125, 1435.5689697265625, -691.7169189453125),
    Vector3.new(-1435.0040283203125, 1435.5689697265625, -1357.06396484375),
    Vector3.new(-1374.8426513671875, 1535.5689697265625, -1569.4886474609375),
    Vector3.new(-1305.24658203125, 1707.5689697265625, -1660.0555419921875),
    Vector3.new(-1879.7392578125, 1707.5689697265625, -2037.0003662109375),
    Vector3.new(-2176.423095703125, 1711.5689697265625, -2045.0057373046875),
    Vector3.new(-2591.745361328125, 1871.5689697265625, -2399.902587890625),
    Vector3.new(-2916.31494140625, 1735.5689697265625, -2154.502685546875),
    Vector3.new(-3266.813232421875, 1739.5689697265625, -2409.79150390625),
    Vector3.new(-3399.127197265625, 1935.5689697265625, -2505.082763671875),
    Vector3.new(-3895.340576171875, 1943.5689697265625, -2220.270751953125),
    Vector3.new(-3967.74560546875, 1755.5689697265625, -2300.5126953125),
    Vector3.new(-3917.8193359375, 1755.5689697265625, -1710.0574951171875),
    Vector3.new(-4144.79638671875, 1943.5689697265625, -1473.3497314453125), -- [PERBAIKAN] Ini baris yang diperbaiki
    Vector3.new(-4308.4931640625, 1943.5689697265625, -1100.2879638671875),
    Vector3.new(-3713.350830078125, 1943.5689697265625, -535.397705078125),
    Vector3.new(-3505.2314453125, 1659.5689697265625, 75.0819091796875),
    Vector3.new(-3720.32763671875, 1661.0533447265625, 459.52398681640625),
    Vector3.new(-4144.39794921875, 1659.5689697265625, 494.5744323730469),
    Vector3.new(-4225.3525390625, 1659.5689697265625, 971.677978515625),
    Vector3.new(-4566.68505859375, 1657.6314697265625, 645.3320922851562),
    Vector3.new(-4464.8505859375, 1659.5689697265625, 151.4462127685547),
    Vector3.new(-4488.75244140625, 2059.56884765625, 55.408111572265625),
    Vector3.new(-4890.02197265625, 2059.56884765625, 686.902587890625),
    Vector3.new(-5395.06689453125, 2061.81884765625, 536.578857421875),
    Vector3.new(-5425.0107421875, 1887.5689697265625, 423.1357421875),
    Vector3.new(-5318.22265625, 1887.5689697265625, 157.05653381347656),
    Vector3.new(-5264.71142578125, 1887.5689697265625, -175.04971313476562),
    Vector3.new(-4969.80224609375, 1911.5689697265625, -426.25048828125),
    Vector3.new(-4834.80419921875, 2059.56884765625, -571.4168701171875),
    Vector3.new(-5001.35595703125, 2059.56884765625, -1229.989501953125),
    Vector3.new(-4919.7099609375, 2067.56884765625, -1569.7496337890625),
    Vector3.new(-5185.1767578125, 2067.56884765625, -1749.6533203125),
    Vector3.new(-5078.51904296875, 2151.56884765625, -1920.4010009765625),
    Vector3.new(-5259.5166015625, 2291.56884765625, -2251.442626953125),
    Vector3.new(-5854.296875, 2467.56884765625, -1783.11767578125),
    Vector3.new(-5917.74365234375, 2707.56884765625, -827.6270141601562),
    Vector3.new(-6630.3056640625, 3151.559814453125, -795.6190795898438)
}
local autoTeleportEnabled_Gemi = false
local teleportCoroutine_Gemi
local godModeConnection_Gemi
local teleportDelay_Gemi = 0.5 -- [[ VARIABEL INI SEKARANG DIKONTROL OLEH SLIDER ]]
local currentTeleportIndex_Gemi = 0

local function activateGodMode_Gemi(humanoid)
    humanoid.Health = humanoid.MaxHealth
    if godModeConnection_Gemi then godModeConnection_Gemi:Disconnect() end
    godModeConnection_Gemi = humanoid.HealthChanged:Connect(function()
        if autoTeleportEnabled_Gemi then
            humanoid.Health = humanoid.MaxHealth
        else
            if godModeConnection_Gemi then
                godModeConnection_Gemi:Disconnect()
                godModeConnection_Gemi = nil
            end
        end
    end)
end

local function stopAutoTeleport_Gemi()
    autoTeleportEnabled_Gemi = false
    if godModeConnection_Gemi then
        godModeConnection_Gemi:Disconnect()
        godModeConnection_Gemi = nil
    end
    if teleportCoroutine_Gemi then
        coroutine.close(teleportCoroutine_Gemi)
        teleportCoroutine_Gemi = nil
    end
end

-- ===================================================================
-- [[ AWAL DARI LOGIKA BARU UNTUK MOUNT GEMI ]]
-- ===================================================================
local function startTeleportLoop_Gemi()
    while autoTeleportEnabled_Gemi do
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character.Parent or humanoid.Health <= 0 then
            print("Gemi: Karakter belum siap, menunggu respawn...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end

        if not autoTeleportEnabled_Gemi then break end
        
        -- 1. Aktifkan God Mode (untuk jaga-jaga)
        activateGodMode_Gemi(humanoid)
        
        -- 2. Ambil lokasi terakhir (Lokasi 51)
        local lastLocationIndex = #teleportLocations_Gemi
        local location = teleportLocations_Gemi[lastLocationIndex]
        
        -- 3. Teleport
        print(string.format("Gemi: Auto Teleport ke Lokasi %d (Delay: %.1fs)", lastLocationIndex, teleportDelay_Gemi))
        teleportCharacter(character, location)
        task.wait(teleportDelay_Gemi) -- Menggunakan delay dari slider
        
        -- Pengecekan jika auto-tp dimatikan saat delay
        if not autoTeleportEnabled_Gemi then break end
        
        -- 4. Matikan God Mode & Paksa Respawn
        if godModeConnection_Gemi then
            godModeConnection_Gemi:Disconnect()
            godModeConnection_Gemi = nil
        end
        
        -- [[ INI ADALAH LOGIKA RESPAWN YANG BARU ]]
        if character.Parent and humanoid.Health > 0 then
            print("Gemi: Teleport selesai. Memicu respawn CP...")
            game:GetService("ReplicatedStorage").CheckpointSystem.ReqResetCP:FireServer()
        end

        -- 5. Tunggu respawn untuk siklus baru
        print("Gemi: Menunggu respawn untuk siklus baru...")
        player.CharacterAdded:Wait()
        task.wait(1) -- Beri jeda singkat setelah respawn
    end
end
-- ===================================================================
-- [[ AKHIR DARI LOGIKA BARU UNTUK MOUNT GEMI ]]
-- ===================================================================


-- -------------------------------------------------------------------
-- KODE UNTUK MOUNT BEAJA (Mount 3)
-- -------------------------------------------------------------------
local teleportLocations_Beaja = {
    Vector3.new(-1119.64, 148.75, 298.83),
    Vector3.new(-707.21, 96.63, 491.17),
    Vector3.new(-724.97, 108.94, 305.90),
    Vector3.new(-662.87, 119.05, 63.17),
    Vector3.new(-278.28, 97.01, -44.61),
    Vector3.new(519.56, 136.54, -37.24),
    Vector3.new(586.94, 277.62, -86.65),
    Vector3.new(746.00, 377.96, -61.52),
    Vector3.new(760.22, 458.22, -171.74),
    Vector3.new(1133.09, 594.60, 103.22),
    Vector3.new(1356.79, 722.71, -82.12),
    Vector3.new(1506.85, 740.15, -138.37),
    Vector3.new(1468.65, 800.56, -212.95),
    Vector3.new(1543.47, 857.32, -400.81),
    Vector3.new(1613.72, 876.82, -254.73),
    Vector3.new(1602.30, 969.95, -192.28),
    Vector3.new(1237.82, 942.79, -371.78),
    Vector3.new(1525.22, 1009.32, -413.88),
    Vector3.new(1539.78, 1070.33, -578.47),
    Vector3.new(1663.49, 1178.21, -852.99),
    Vector3.new(1587.00, 1430.00, -972.54),
    Vector3.new(1375.22, 1429.77, -1090.88),
    Vector3.new(1141.93, 1450.89, -1185.65),
    Vector3.new(1394.65, 1494.84, -1252.45),
    Vector3.new(1327.26, 1518.27, -1100.34),
    Vector3.new(1455.24, 1676.25, -1389.80),
    Vector3.new(1411.77, 1725.65, -1529.35),
    Vector3.new(1360.62, 1786.64, -1701.38),
    Vector3.new(1466.71, 1793.74, -1812.34),
    Vector3.new(1557.33, 1878.00, -1963.26),
    Vector3.new(1344.18, 2053.76, -2267.95),
    Vector3.new(1525.21, 2178.60, -2454.31),
    Vector3.new(1503.68, 2238.15, -2597.72),
    Vector3.new(1416.02, 2308.21, -2645.92),
    Vector3.new(1394.03, 2301.64, -2707.12)
}
local autoTeleportEnabled_Beaja = false
local teleportCoroutine_Beaja
local godModeConnection_Beaja
local teleportDelay_Beaja = 1.5 -- [[ VARIABEL INI SEKARANG DIKONTROL OLEH SLIDER ]]
local currentTeleportIndex_Beaja = 0

local function activateGodMode_Beaja(humanoid)
    humanoid.Health = humanoid.MaxHealth
    if godModeConnection_Beaja then godModeConnection_Beaja:Disconnect() end
    godModeConnection_Beaja = humanoid.HealthChanged:Connect(function()
        if autoTeleportEnabled_Beaja then
            humanoid.Health = humanoid.MaxHealth
        else
            if godModeConnection_Beaja then
                godModeConnection_Beaja:Disconnect()
                godModeConnection_Beaja = nil
            end
        end
    end)
end

local function stopAutoTeleport_Beaja()
    autoTeleportEnabled_Beaja = false
    if godModeConnection_Beaja then
        godModeConnection_Beaja:Disconnect()
        godModeConnection_Beaja = nil
    end
    if teleportCoroutine_Beaja then
        coroutine.close(teleportCoroutine_Beaja)
        teleportCoroutine_Beaja = nil
    end
end

local function startTeleportLoop_Beaja()
    while autoTeleportEnabled_Beaja do
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character.Parent or humanoid.Health <= 0 then
            print("Beaja: Karakter belum siap, menunggu respawn...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end

        if not autoTeleportEnabled_Beaja then break end
        currentTeleportIndex_Beaja = currentTeleportIndex_Beaja + 1

        if currentTeleportIndex_Beaja > #teleportLocations_Beaja then
            currentTeleportIndex_Beaja = 0
            if godModeConnection_Beaja then
                godModeConnection_Beaja:Disconnect()
                godModeConnection_Beaja = nil
            end
            
            if character.Parent and humanoid.Health > 0 then
                print("Beaja: Siklus teleport selesai. Memicu respawn...")
                humanoid.Health = 0
            end

            print("Beaja: Menunggu respawn untuk siklus baru...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end
        
        activateGodMode_Beaja(humanoid)
        local location = teleportLocations_Beaja[currentTeleportIndex_Beaja]
        print(string.format("Beaja: Auto Teleport ke Lokasi %d (Delay: %.1fs)", currentTeleportIndex_Beaja, teleportDelay_Beaja))
        teleportCharacter(character, location)
        task.wait(teleportDelay_Beaja) -- Menggunakan delay dari slider
        
        if not autoTeleportEnabled_Beaja then break end
        if not character.Parent or humanoid.Health <= 0 then
            print("Beaja: Karakter mati. Mereset...")
            currentTeleportIndex_Beaja = 0
            if godModeConnection_Beaja then
                godModeConnection_Beaja:Disconnect()
                godModeConnection_Beaja = nil
            end
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end
    end
end

-- -------------------------------------------------------------------
-- KODE UNTUK MOUNT MAAF (Mount 4)
-- -------------------------------------------------------------------
local teleportLocations_Maaf = {
    Vector3.new(-799.3898315429688, 203.56907653808594, -376.1388854980469),
    Vector3.new(-829.17236328125, 199.56907653808594, -169.6573486328125),
    Vector3.new(-431.79876708984375, 207.56907653808594, -172.06552124023438),
    Vector3.new(-715.0905151367188, 323.5690612792969, 30.009061813354492),
    Vector3.new(-315.80755615234375, 323.56903076171875, -5.9478254318237305),
    Vector3.new(-224.0460662841797, 376.6620178222656, 315.6397705078125),
    Vector3.new(-201.8218536376953, 367.5690612792969, 624.7332763671875),
    Vector3.new(-196.59983825683594, 283.56903076171875, 897.213134765625),
    Vector3.new(-232.6274871826172, 355.56903076171875, 1345.657958984375),
    Vector3.new(-237.2722930908203, 593.5689697265625, 2055.876220703125)
}
local autoTeleportEnabled_Maaf = false
local teleportCoroutine_Maaf
local godModeConnection_Maaf
local teleportDelay_Maaf = 0.5 -- [[ VARIABEL INI SEKARANG DIKONTROL OLEH SLIDER ]]
local currentTeleportIndex_Maaf = 0

local function activateGodMode_Maaf(humanoid)
    humanoid.Health = humanoid.MaxHealth
    if godModeConnection_Maaf then godModeConnection_Maaf:Disconnect() end
    godModeConnection_Maaf = humanoid.HealthChanged:Connect(function()
        if autoTeleportEnabled_Maaf then
            humanoid.Health = humanoid.MaxHealth
        else
            if godModeConnection_Maaf then
                godModeConnection_Maaf:Disconnect()
                godModeConnection_Maaf = nil
            end
        end
    end)
end

local function stopAutoTeleport_Maaf()
    autoTeleportEnabled_Maaf = false
    if godModeConnection_Maaf then
        godModeConnection_Maaf:Disconnect()
        godModeConnection_Maaf = nil
    end
    if teleportCoroutine_Maaf then
        coroutine.close(teleportCoroutine_Maaf)
        teleportCoroutine_Maaf = nil
    end
end

local function startTeleportLoop_Maaf()
    while autoTeleportEnabled_Maaf do
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character.Parent or humanoid.Health <= 0 then
            print("Maaf: Karakter belum siap, menunggu respawn...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end

        if not autoTeleportEnabled_Maaf then break end
        currentTeleportIndex_Maaf = currentTeleportIndex_Maaf + 1

        if currentTeleportIndex_Maaf > #teleportLocations_Maaf then
            currentTeleportIndex_Maaf = 0
            if godModeConnection_Maaf then
                godModeConnection_Maaf:Disconnect()
                godModeConnection_Maaf = nil
            end
            
            if character.Parent and humanoid.Health > 0 then
                print("Maaf: Siklus teleport selesai. Memicu respawn...")
                humanoid.Health = 0
            end

            print("Maaf: Menunggu respawn untuk siklus baru...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end
        
        activateGodMode_Maaf(humanoid)
        local location = teleportLocations_Maaf[currentTeleportIndex_Maaf]
        print(string.format("Maaf: Auto Teleport ke Lokasi %d (Delay: %.1fs)", currentTeleportIndex_Maaf, teleportDelay_Maaf))
        teleportCharacter(character, location)
        task.wait(teleportDelay_Maaf) -- Menggunakan delay dari slider
        
        if not autoTeleportEnabled_Maaf then break end
        if not character.Parent or humanoid.Health <= 0 then
            print("Maaf: Karakter mati. Mereset...")
            currentTeleportIndex_Maaf = 0
            if godModeConnection_Maaf then
                godModeConnection_Maaf:Disconnect()
                godModeConnection_Maaf = nil
            end
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end
    end
end

-- -------------------------------------------------------------------
-- KODE UNTUK MOUNT KOTA (Mount 5) - (LOGIKA BARU DARI TXT)
-- -------------------------------------------------------------------
local teleportLocations_Kota = {
	Vector3.new(-455.15972900390625, 112.14170837402344, 53.73706817626953),
	Vector3.new(-598.843505859375, 111.4283676147461, 242.91510009765625),
	Vector3.new(-554.863037109375, 126.38681030273438, 373.9130859375),
	Vector3.new(-424.31036376953125, 157.30636596679688, 364.7170104980469),
	Vector3.new(-288.1586608886719, 251.2385711669922, 374.8346252441406),
	Vector3.new(-92.31280517578125, 190.5758514404297, 354.5635681152344),
	Vector3.new(-56.26321029663086, 99.88958740234375, 66.4233627319336),
	Vector3.new(138.876220703125, 111.43180847167969, 77.2187271118164),
	Vector3.new(129.5753173828125, 81.49308776855469, 182.6982879638672),
	Vector3.new(190.3717498779297, 167.67715454101562, 115.52503967285156),
	Vector3.new(282.01995849609375, 210.2179718017578, 263.7448425292969),
	Vector3.new(346.1614685058594, 291.32342529296875, 282.6249694824219),
	Vector3.new(445.17529296875, 237.3234405517578, 125.45742797851562),
	Vector3.new(450.37445068359375, 237.3234405517578, 35.843135833740234)
}
local autoTeleportEnabled_Kota = false
local teleportCoroutine_Kota
local godModeConnection_Kota
local teleportDelay_Kota = 0.5 -- [[ VARIABEL INI SEKARANG DIKONTROL OLEH SLIDER ]]
local currentTeleportIndex_Kota = 0 -- (Meskipun tidak dipakai untuk loop 1-N, tetap jaga)
local FAST_WALK_SPEED_KOTA = 150 --
local DEFAULT_WALKSPEED_KOTA = 16 --

local function activateGodMode_Kota(humanoid)
    humanoid.Health = humanoid.MaxHealth
    if godModeConnection_Kota then godModeConnection_Kota:Disconnect() end
    godModeConnection_Kota = humanoid.HealthChanged:Connect(function()
        if autoTeleportEnabled_Kota then
            humanoid.Health = humanoid.MaxHealth
        else
            if godModeConnection_Kota then
                godModeConnection_Kota:Disconnect()
                godModeConnection_Kota = nil
            end
        end
    end)
end

local function stopAutoTeleport_Kota()
    autoTeleportEnabled_Kota = false
    if godModeConnection_Kota then
        godModeConnection_Kota:Disconnect()
        godModeConnection_Kota = nil
    end
    if teleportCoroutine_Kota then
        coroutine.close(teleportCoroutine_Kota)
        teleportCoroutine_Kota = nil
    end
    
    -- [PERBAIKAN] Pastikan walkspeed kembali normal jika dihentikan paksa
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid.WalkSpeed == FAST_WALK_SPEED_KOTA then
                humanoid.WalkSpeed = DEFAULT_WALKSPEED_KOTA
                print("Kota: Walkspeed dikembalikan ke default (16)")
            end
        end
    end)
end

local function startTeleportLoop_Kota()
    while autoTeleportEnabled_Kota do
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character.Parent or humanoid.Health <= 0 then
            print("Kota: Karakter belum siap, menunggu respawn...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end

        if not autoTeleportEnabled_Kota or not character.Parent then break end

        -- Logika spesifik dari MountKota.txt
        activateGodMode_Kota(humanoid)
        
        -- 1. Teleport ke Lokasi 13
        local location13 = teleportLocations_Kota[13]
        print(string.format("Kota: Teleport ke Lokasi 13 (Delay: %.1fs)", teleportDelay_Kota))
        teleportCharacter(character, location13)
        task.wait(teleportDelay_Kota) -- Menggunakan delay dari slider

        if not autoTeleportEnabled_Kota or not character.Parent then break end

        -- 2. Berjalan cepat ke Lokasi 14
        local originalWalkSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = FAST_WALK_SPEED_KOTA

        local location14 = teleportLocations_Kota[14]
        print("Kota: Berjalan cepat ke Lokasi 14")
        humanoid:MoveTo(location14)
        humanoid.MoveToFinished:Wait()

        -- 3. Kembalikan walkspeed dan tunggu sebentar
        humanoid.WalkSpeed = originalWalkSpeed
        print("Kota: Siklus selesai, mengulang.")
        task.wait(1) -- Delay 1 detik dari MountKota.txt
        
        -- Pengecekan jika mati saat berjalan
        if not autoTeleportEnabled_Kota then break end
        if not character.Parent or humanoid.Health <= 0 then
            print("Kota: Karakter mati saat berjalan. Mereset...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end
    end
    
    -- [PEMBERSIHAN] Jika loop berhenti normal (misal karakter mati), pastikan walkspeed normal
    pcall(function()
         if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid.WalkSpeed == FAST_WALK_SPEED_KOTA then
                humanoid.WalkSpeed = DEFAULT_WALKSPEED_KOTA
                print("Kota: Loop berhenti, Walkspeed dikembalikan ke default (16)")
            end
        end
    end)
end

-- -------------------------------------------------------------------
-- [[ AWAL BLOK BARU ]] KODE UNTUK MOUNT YAHAYUK (Mount 6)
-- -------------------------------------------------------------------
local teleportLocations_Yahayuk = {
	Vector3.new(-419.32, 250.59, 787.35),
	Vector3.new(-325.70, 389.59, 524.89),
	Vector3.new(295.93, 431.30, 494.76),
	Vector3.new(324.25, 491.59, 365.65),
	Vector3.new(233.36, 315.59, -143.48),
	Vector3.new(-616.29, 907.59, -548.54),
	Vector3.new(-621.73, 907.09, -488.93)
}
local autoTeleportEnabled_Yahayuk = false
local teleportCoroutine_Yahayuk
local godModeConnection_Yahayuk
local teleportDelay_Yahayuk = 0.5 -- [[ VARIABEL INI SEKARANG DIKONTROL OLEH SLIDER ]]
local currentTeleportIndex_Yahayuk = 0
-- [[ LOGIKA BARU SEPERTI MOUNT KOTA ]]
local FAST_WALK_SPEED_YAHAYUK = 150
local DEFAULT_WALKSPEED_YAHAYUK = 16

local function activateGodMode_Yahayuk(humanoid)
    humanoid.Health = humanoid.MaxHealth
    if godModeConnection_Yahayuk then godModeConnection_Yahayuk:Disconnect() end
    godModeConnection_Yahayuk = humanoid.HealthChanged:Connect(function()
        if autoTeleportEnabled_Yahayuk then
            humanoid.Health = humanoid.MaxHealth
        else
            if godModeConnection_Yahayuk then
                godModeConnection_Yahayuk:Disconnect()
                godModeConnection_Yahayuk = nil
            end
        end
    end)
end

local function stopAutoTeleport_Yahayuk()
    autoTeleportEnabled_Yahayuk = false
    if godModeConnection_Yahayuk then
        godModeConnection_Yahayuk:Disconnect()
        godModeConnection_Yahayuk = nil
    end
    if teleportCoroutine_Yahayuk then
        coroutine.close(teleportCoroutine_Yahayuk)
        teleportCoroutine_Yahayuk = nil
    end
    
    -- [BARU] Pastikan walkspeed kembali normal jika dihentikan paksa
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid.WalkSpeed == FAST_WALK_SPEED_YAHAYUK then
                humanoid.WalkSpeed = DEFAULT_WALKSPEED_YAHAYUK
                print("Yahayuk: Walkspeed dikembalikan ke default (16)")
            end
        end
    end)
end

-- [[ LOGIKA LOOP BARU (TP 1-6, JALAN KE 7, TANPA RESPAWN) ]]
local function startTeleportLoop_Yahayuk()
    while autoTeleportEnabled_Yahayuk do
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        if not character.Parent or humanoid.Health <= 0 then
            print("Yahayuk: Karakter belum siap, menunggu respawn...")
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end

        if not autoTeleportEnabled_Yahayuk then break end
        
        currentTeleportIndex_Yahayuk = currentTeleportIndex_Yahayuk + 1

        -- Jika sudah lebih dari 7 (selesai jalan), reset index ke 0 agar loop berikutnya ke 1
        if currentTeleportIndex_Yahayuk > #teleportLocations_Yahayuk then
            currentTeleportIndex_Yahayuk = 0
            print("Yahayuk: Siklus selesai, kembali ke Lokasi 1.")
            if godModeConnection_Yahayuk then -- Matikan god mode jika ada
                 godModeConnection_Yahayuk:Disconnect()
                 godModeConnection_Yahayuk = nil
            end
            task.wait(1) -- Beri jeda sebelum memulai lagi
            continue -- Lanjut ke iterasi berikutnya (akan +1 jadi 1)
        end
        
        activateGodMode_Yahayuk(humanoid)
        local location = teleportLocations_Yahayuk[currentTeleportIndex_Yahayuk]

        -- Jika lokasi 1-6, teleport biasa
        if currentTeleportIndex_Yahayuk <= 6 then
            print(string.format("Yahayuk: Auto Teleport ke Lokasi %d (Delay: %.1fs)", currentTeleportIndex_Yahayuk, teleportDelay_Yahayuk))
            teleportCharacter(character, location)
            task.wait(teleportDelay_Yahayuk) -- Menggunakan delay dari slider
        
        -- Jika lokasi 7, berjalan cepat
        elseif currentTeleportIndex_Yahayuk == 7 then
            local originalWalkSpeed = humanoid.WalkSpeed
            humanoid.WalkSpeed = FAST_WALK_SPEED_YAHAYUK

            print("Yahayuk: Berjalan cepat ke Lokasi 7")
            humanoid:MoveTo(location)
            humanoid.MoveToFinished:Wait()

            humanoid.WalkSpeed = originalWalkSpeed
            print("Yahayuk: Sampai di Lokasi 7. Siklus akan direset.")
            -- Tidak ada respawn di sini
            task.wait(1) -- Jeda singkat sebelum loop berikutnya (akan reset index)
        end
        
        if not autoTeleportEnabled_Yahayuk then break end
        if not character.Parent or humanoid.Health <= 0 then
            print("Yahayuk: Karakter mati. Mereset...")
            currentTeleportIndex_Yahayuk = 0
            if godModeConnection_Yahayuk then
                godModeConnection_Yahayuk:Disconnect()
                godModeConnection_Yahayuk = nil
            end
            player.CharacterAdded:Wait()
            task.wait(1)
            continue
        end
    end
    
    -- [PEMBERSIHAN] Jika loop berhenti normal
    pcall(function()
         if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid.WalkSpeed == FAST_WALK_SPEED_YAHAYUK then
                humanoid.WalkSpeed = DEFAULT_WALKSPEED_YAHAYUK
                print("Yahayuk: Loop berhenti, Walkspeed dikembalikan ke default (16)")
            end
        end
    end)
end
-- [[ AKHIR BLOK BARU ]]


-- Fungsi Master untuk menghentikan SEMUA auto teleport
local function stopAllAutoTeleports()
    stopAutoTeleport_Mika()
    stopAutoTeleport_Gemi()
    stopAutoTeleport_Beaja()
    stopAutoTeleport_Maaf()
    stopAutoTeleport_Kota()
    stopAutoTeleport_Yahayuk() -- [DITAMBAHKAN]
    
    -- Juga matikan Tampilan Toggle di UI
    if autoTeleportToggle_Mika then
        autoTeleportToggle_Mika:Set(false, true) -- Set(state, suppress_callback)
    end
    if autoTeleportToggle_Gemi then
        autoTeleportToggle_Gemi:Set(false, true) -- Set(state, suppress_callback)
    end
    if autoTeleportToggle_Beaja then
        autoTeleportToggle_Beaja:Set(false, true) -- Set(state, suppress_callback)
    end
    if autoTeleportToggle_Maaf then
        autoTeleportToggle_Maaf:Set(false, true) -- Set(state, suppress_callback)
    end
    if autoTeleportToggle_Kota then
        autoTeleportToggle_Kota:Set(false, true) -- Set(state, suppress_callback)
    end
    if autoTeleportToggle_Yahayuk then -- [DITAMBAHKAN]
        autoTeleportToggle_Yahayuk:Set(false, true) -- Set(state, suppress_callback)
    end
end


-- ===================================================================
-- [[ AKHIR DARI KODE INTEGRASI ]]
-- ===================================================================


-- */  Window  /* --
local Window = WindUI:CreateWindow({
    Title = "YoruHub  |  Mount VIP",
    Author = "made by @AsuGaming",
	Icon = "house",
    Folder = "ftgshub",
    NewElements = true,
    
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    
	    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
        'rbxassetid://':
            Background = "rbxassetid://", -- rbxassetid
        Video:
            Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
    --]]
    
    -- ↓ Optional. You can remove it.
	User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            print("clicked")
        end,
    },

	    KeySystem = { 
        -- ↓ Optional. You can remove it.
        Key = { "1234", "5678" },
        
        -- Note = "Example Key System.",
                
        -- ↓ Optional. You can remove it.
        URL = "YOUR LINK TO GET KEY (Discord, Linkvertise, Pastebin, etc.)",
        
        -- ↓ Optional. You can remove it.
        SaveKey = true, -- automatically save and load the key.
        
        -- ↓ Optional. You can remove it.
        -- API = {} ← Services. Read about it below ↓
    },

    OpenButton = {
        Title = "Open YoruHub", -- can be changed
        CornerRadius = UDim.new(1,0), -- fully rounded
        StrokeThickness = 3, -- removing outline
        Enabled = true, -- enable or disable openbutton
        Draggable = true,
        OnlyMobile = true,
        
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("#30FF6A"), 
            Color3.fromHex("#e7ff2f")
        )
    }
})


-- */  Theme (soon)  /* --
do
    WindUI:AddTheme({
        Name = "Stylish",
        
        Accent = Color3.fromHex("#3b82f6"), 
        Dialog = Color3.fromHex("#1a1a1a"), 
        Outline = Color3.fromHex("#3b82f6"),
        Text = Color3.fromHex("#f8fafc"),  
        Placeholder = Color3.fromHex("#94a3b8"),
        Button = Color3.fromHex("#334155"), 
        Icon = Color3.fromHex("#60a5fa"), 
        
        WindowBackground = Color3.fromHex("#0f172a"),
        
        TopbarButtonIcon = Color3.fromHex("#60a5fa"),
        TopbarTitle = Color3.fromHex("#f8fafc"),
        TopbarAuthor = Color3.fromHex("#94a3b8"),
        TopbarIcon = Color3.fromHex("#3b82f6"),
        
        TabBackground = Color3.fromHex("#1e293b"),    
        TabTitle = Color3.fromHex("#f8fafc"),
        TabIcon = Color3.fromHex("#60a5fa"),
        
        ElementBackground = Color3.fromHex("#1e293b"),
        ElementTitle = Color3.fromHex("#f8fafc"),
        ElementDesc = Color3.fromHex("#cbd5e1"),
        ElementIcon = Color3.fromHex("#60a5fa"),
    })
    
    WindUI:SetTheme("Stylish")
end

Window:Tag({
    Title = "v1.0",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 10, -- from 0 to 13
})


-- */ Other Functions /* --
local function parseJSON(luau_table, indent, level, visited)
    indent = indent or 2
    level = level or 0
    visited = visited or {}
    
    local currentIndent = string.rep(" ", level * indent)
    local nextIndent = string.rep(" ", (level + 1) * indent)
    
    if luau_table == nil then
        return "null"
    end
    
    local dataType = type(luau_table)
    
    if dataType == "table" then
        if visited[luau_table] then
            return "\"[Circular Reference]\""
        end
        
        visited[luau_table] = true
        
        local isArray = true
        local maxIndex = 0
        
        for k, _ in pairs(luau_table) do
            if type(k) == "number" and k > maxIndex then
                maxIndex = k
            end
            if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
                isArray = false
                break
            end
        end
        
        local count = 0
        for _ in pairs(luau_table) do
            count = count + 1
        end
        if count ~= maxIndex and isArray then
            isArray = false
        end
        
        if count == 0 then
            return "{}"
        end
        
        if isArray then
            if count == 0 then
                return "[]"
            end
            
            local result = "[\n"
            
            for i = 1, maxIndex do
                result = result .. nextIndent .. parseJSON(luau_table[i], indent, level + 1, visited)
                if i < maxIndex then
                    result = result .. ","
                end
                result = result .. "\n"
            end
            
            result = result .. currentIndent .. "]"
            return result
        else
            local result = "{\n"
            local first = true
            
            local keys = {}
            for k in pairs(luau_table) do
                table.insert(keys, k)
            end
            table.sort(keys, function(a, b)
                if type(a) == type(b) then
                    return tostring(a) < tostring(b)
                else
                    return type(a) < type(b)
                end
            end)
            
            for _, k in ipairs(keys) do
                local v = luau_table[k]
                if not first then
                    result = result .. ",\n"
                else
                    first = false
                end
                
                if type(k) == "string" then
                    result = result .. nextIndent .. "\"" .. k .. "\": "
                else
                    result = result .. nextIndent .. "\"" .. tostring(k) .. "\": "
                end
                
                result = result .. parseJSON(v, indent, level + 1, visited)
            end
            
            result = result .. "\n" .. currentIndent .. "}"
            return result
        end
    elseif dataType == "string" then
        local escaped = luau_table:gsub("\\", "\\\\")
        escaped = escaped:gsub("\"", "\\\"")
        escaped = escaped:gsub("\n", "\\n")
        escaped = escaped:gsub("\r", "\\r")
        escaped = escaped:gsub("\t", "\\t")
        
        return "\"" .. escaped .. "\""
    elseif dataType == "number" then
        return tostring(luau_table)
    elseif dataType == "boolean" then
        return luau_table and "true" or "false"
    elseif dataType == "function" then
        return "\"function\""
    else
        return "\"" .. dataType .. "\""
    end
end

local function tableToClipboard(luau_table, indent)
    indent = indent or 4
    local jsonString = parseJSON(luau_table, indent)
    setclipboard(jsonString)
    return jsonString
end


-- */  About Tab  /* --
do
    local AboutTab = Window:Tab({
        Title = "About YoruHub",
        Icon = "info",
    })
    
    local AboutSection = AboutTab:Section({
        Title = "About WindUI",
    })
	
    
    AboutSection:Image({
        Image = "https://repository-images.githubusercontent.com/880118829/428bedb1-dcbd-43d5-bc7f-3beb2e9e0177",
        AspectRatio = "16:9",
        Radius = 9,
    })
    
    AboutSection:Space({ Columns = 3 })
    
    AboutSection:Section({
        Title = "What is WindUI?",
        TextSize = 24,
        FontWeight = Enum.FontWeight.SemiBold,
    })

    AboutSection:Space()
    
    AboutSection:Section({
        Title = [[WindUI is a stylish, open-source UI (User Interface) library specifically designed for Roblox Script Hubs.
Developed by Footagesus (.ftgs, Footages).
It aims to provide developers with a modern, customizable, and easy-to-use toolkit for creating visually appealing interfaces within Roblox.
The project is primarily written in Lua (Luau), the scripting language used in Roblox.]],
        TextSize = 18,
        TextTransparency = .35,
        FontWeight = Enum.FontWeight.Medium,
    })
    
    AboutTab:Space({ Columns = 4 }) 
    
    
    -- Default buttons
    
    AboutTab:Button({
        Title = "Export WindUI JSON (copy)",
        Color = Color3.fromHex("#a2ff30"),
        Justify = "Center",
        IconAlign = "Left",
        Icon = "", -- removing icon
        Callback = function()
            tableToClipboard(WindUI)
            WindUI:Notify({
                Title = "WindUI JSON",
                Content = "Copied to Clipboard!"
            })
        end
    })
    AboutTab:Space({ Columns = 1 }) 
    
    
    AboutTab:Button({
        Title = "Destroy Window",
        Color = Color3.fromHex("#ff4830"),
        Justify = "Center",
        Icon = "shredder",
        IconAlign = "Left",
        Callback = function()
            Window:Destroy()
        end
    })
end

-- */  Elements Section  /* --
local ElementsSection = Window:Section({
    Title = "Elements",
})

-- ===================================================================
-- [[ AWAL DARI PENAMBAHAN UI TELEPORT LOKASI ]]
-- ===================================================================

-- Membuat Section baru untuk Teleport
local TeleportLokasiSection = Window:Section({
    Title = "Teleport Lokasi",
})

-- -----------------------------------------
-- UI UNTUK MOUNT 1 (MIKA)
-- -----------------------------------------
local Mount1Tab = TeleportLokasiSection:Tab({
    Title = "Mount Mika",
    Icon = "map-pin" 
})

-- Looping lokasi Mika dan membuat tombol
for i, location in ipairs(teleportLocations_Mika) do
    Mount1Tab:Button({
        Title = "Lokasi " .. i,
        Icon = "navigation",
        Callback = function()
            stopAllAutoTeleports() -- Hentikan semua auto tp jika manual
            
            if player.Character then
                currentTeleportIndex_Mika = i
                print(string.format("Mika: Teleport manual ke Lokasi %d.", i))
                teleportCharacter(player.Character, teleportLocations_Mika[i])
            end
        end
    })
end

Mount1Tab:Space()

-- [[ SLIDER BARU UNTUK MIKA ]]
Mount1Tab:Slider({
    Title = "Auto Teleport Delay (detik)",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 60,
        Default = teleportDelay_Mika, -- Menggunakan nilai default awal
    },
    Callback = function(value)
        teleportDelay_Mika = value
        WindUI:Notify({ Title = "Delay Mika", Content = "Diatur ke " .. value .. " detik" })
    end
})
Mount1Tab:Space() -- Kasih jarak lagi sebelum toggle
-- [[ AKHIR SLIDER BARU ]]

-- Toggle Auto Teleport untuk Mika
autoTeleportToggle_Mika = Mount1Tab:Toggle({
    Title = "Auto Teleport",
    Desc = "Otomatis teleport ke semua lokasi Mika",
    Icon = "fast-forward",
    Default = false,
    Callback = function(state) 
        if state == true then
            -- 1. Matikan logika & UI lainnya
            stopAutoTeleport_Gemi()
            if autoTeleportToggle_Gemi then autoTeleportToggle_Gemi:Set(false, true) end
            stopAutoTeleport_Beaja()
            if autoTeleportToggle_Beaja then autoTeleportToggle_Beaja:Set(false, true) end
            stopAutoTeleport_Maaf()
            if autoTeleportToggle_Maaf then autoTeleportToggle_Maaf:Set(false, true) end
            stopAutoTeleport_Kota() 
            if autoTeleportToggle_Kota then autoTeleportToggle_Kota:Set(false, true) end 
            stopAutoTeleport_Yahayuk() 
            if autoTeleportToggle_Yahayuk then autoTeleportToggle_Yahayuk:Set(false, true) end 

            -- 2. Mulai logika Mika
            autoTeleportEnabled_Mika = true
            WindUI:Notify({ Title = "Auto Teleport (Mika)", Content = "Auto Teleport: ON" })
            if teleportCoroutine_Mika then coroutine.close(teleportCoroutine_Mika) end
            teleportCoroutine_Mika = coroutine.create(startTeleportLoop_Mika)
            coroutine.resume(teleportCoroutine_Mika)
            
        else
            -- 3. Jika toggle ini dimatikan, hentikan logikanya
            autoTeleportEnabled_Mika = false
            if teleportCoroutine_Mika then
                WindUI:Notify({ Title = "Auto Teleport (Mika)", Content = "Auto Teleport: OFF" })
            end
            stopAutoTeleport_Mika()
        end
    end
})


-- -----------------------------------------
-- UI UNTUK MOUNT 2 (GEMI)
-- -----------------------------------------
local MountGemiTab = TeleportLokasiSection:Tab({
    Title = "Mount Gemi",
    Icon = "map-pin"
})

-- Looping lokasi Gemi dan membuat tombol
for i, location in ipairs(teleportLocations_Gemi) do
    MountGemiTab:Button({
        Title = "Lokasi " .. i,
        Icon = "navigation",
        Callback = function()
            stopAllAutoTeleports() -- Hentikan semua auto tp jika manual
            
            if player.Character then
                currentTeleportIndex_Gemi = i
                print(string.format("Gemi: Teleport manual ke Lokasi %d.", i))
                teleportCharacter(player.Character, teleportLocations_Gemi[i])
            end
        end
    })
end

MountGemiTab:Space()

-- [[ SLIDER BARU UNTUK GEMI ]]
MountGemiTab:Slider({
    Title = "Auto Teleport Delay (detik)",
    Desc = "Delay sebelum respawn paksa", -- Deskripsi diubah
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 60,
        Default = teleportDelay_Gemi,
    },
    Callback = function(value)
        teleportDelay_Gemi = value
        WindUI:Notify({ Title = "Delay Gemi", Content = "Diatur ke " .. value .. " detik" })
    end
})
MountGemiTab:Space() -- Kasih jarak lagi sebelum toggle
-- [[ AKHIR SLIDER BARU ]]

-- Toggle Auto Teleport untuk Gemi
autoTeleportToggle_Gemi = MountGemiTab:Toggle({
    Title = "Auto Teleport (Ke Lokasi 51)",
    Desc = "Otomatis teleport ke Lokasi 51 lalu respawn", -- DESKRIPSI DIUBAH
    Icon = "fast-forward",
    Default = false,
    Callback = function(state) 
        if state == true then
            -- 1. Matikan logika & UI lainnya
            stopAutoTeleport_Mika()
            if autoTeleportToggle_Mika then autoTeleportToggle_Mika:Set(false, true) end
            stopAutoTeleport_Beaja()
            if autoTeleportToggle_Beaja then autoTeleportToggle_Beaja:Set(false, true) end
            stopAutoTeleport_Maaf()
            if autoTeleportToggle_Maaf then autoTeleportToggle_Maaf:Set(false, true) end
            stopAutoTeleport_Kota() 
            if autoTeleportToggle_Kota then autoTeleportToggle_Kota:Set(false, true) end 
            stopAutoTeleport_Yahayuk() 
            if autoTeleportToggle_Yahayuk then autoTeleportToggle_Yahayuk:Set(false, true) end 

            -- 2. Mulai logika Gemi
            autoTeleportEnabled_Gemi = true
            WindUI:Notify({ Title = "Auto Teleport (Gemi)", Content = "Auto Teleport: ON (Ke Lokasi 51)" })
            if teleportCoroutine_Gemi then coroutine.close(teleportCoroutine_Gemi) end
            teleportCoroutine_Gemi = coroutine.create(startTeleportLoop_Gemi)
            coroutine.resume(teleportCoroutine_Gemi)

        else
            -- 3. Jika toggle ini dimatikan, hentikan logikanya
            autoTeleportEnabled_Gemi = false
            if teleportCoroutine_Gemi then
                WindUI:Notify({ Title = "Auto Teleport (Gemi)", Content = "Auto Teleport: OFF" })
            end
            stopAutoTeleport_Gemi()
        end
    end
})

-- -----------------------------------------
-- UI UNTUK MOUNT 3 (BEAJA)
-- -----------------------------------------
local MountBeajaTab = TeleportLokasiSection:Tab({
    Title = "Mount Beaja",
    Icon = "map-pin"
})

-- Looping lokasi Beaja dan membuat tombol
for i, location in ipairs(teleportLocations_Beaja) do
    MountBeajaTab:Button({
        Title = "Lokasi " .. i,
        Icon = "navigation",
        Callback = function()
            stopAllAutoTeleports() -- Hentikan semua auto tp jika manual
            
            if player.Character then
                currentTeleportIndex_Beaja = i
                print(string.format("Beaja: Teleport manual ke Lokasi %d.", i))
                teleportCharacter(player.Character, teleportLocations_Beaja[i])
            end
        end
    })
end

MountBeajaTab:Space()

-- [[ SLIDER BARU UNTUK BEAJA ]]
MountBeajaTab:Slider({
    Title = "Auto Teleport Delay (detik)",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 60,
        Default = teleportDelay_Beaja,
    },
    Callback = function(value)
        teleportDelay_Beaja = value
        WindUI:Notify({ Title = "Delay Beaja", Content = "Diatur ke " .. value .. " detik" })
    end
})
MountBeajaTab:Space() -- Kasih jarak lagi sebelum toggle
-- [[ AKHIR SLIDER BARU ]]

-- Toggle Auto Teleport untuk Beaja
autoTeleportToggle_Beaja = MountBeajaTab:Toggle({
    Title = "Auto Teleport",
    Desc = "Otomatis teleport ke semua lokasi Beaja",
    Icon = "fast-forward",
    Default = false,
    Callback = function(state) 
        if state == true then
            -- 1. Matikan logika & UI lainnya
            stopAutoTeleport_Mika()
            if autoTeleportToggle_Mika then autoTeleportToggle_Mika:Set(false, true) end
            stopAutoTeleport_Gemi()
            if autoTeleportToggle_Gemi then autoTeleportToggle_Gemi:Set(false, true) end
            stopAutoTeleport_Maaf()
            if autoTeleportToggle_Maaf then autoTeleportToggle_Maaf:Set(false, true) end
            stopAutoTeleport_Kota() 
            if autoTeleportToggle_Kota then autoTeleportToggle_Kota:Set(false, true) end 
            stopAutoTeleport_Yahayuk() 
            if autoTeleportToggle_Yahayuk then autoTeleportToggle_Yahayuk:Set(false, true) end 

            -- 2. Mulai logika Beaja
            autoTeleportEnabled_Beaja = true
            WindUI:Notify({ Title = "Auto Teleport (Beaja)", Content = "Auto Teleport: ON" })
            if teleportCoroutine_Beaja then coroutine.close(teleportCoroutine_Beaja) end
            teleportCoroutine_Beaja = coroutine.create(startTeleportLoop_Beaja)
            coroutine.resume(teleportCoroutine_Beaja)

        else
            -- 3. Jika toggle ini dimatikan, hentikan logikanya
            autoTeleportEnabled_Beaja = false
            if teleportCoroutine_Beaja then
                WindUI:Notify({ Title = "Auto Teleport (Beaja)", Content = "Auto Teleport: OFF" })
            end
            stopAutoTeleport_Beaja()
        end
    end
})

-- -----------------------------------------
-- UI UNTUK MOUNT 4 (MAAF)
-- -----------------------------------------
local MountMaafTab = TeleportLokasiSection:Tab({
    Title = "Mount Maaf",
    Icon = "map-pin"
})

-- Looping lokasi Maaf dan membuat tombol
for i, location in ipairs(teleportLocations_Maaf) do
    MountMaafTab:Button({
        Title = "Lokasi " .. i,
        Icon = "navigation",
        Callback = function()
            stopAllAutoTeleports() -- Hentikan semua auto tp jika manual
            
            if player.Character then
                currentTeleportIndex_Maaf = i
                print(string.format("Maaf: Teleport manual ke Lokasi %d.", i))
                teleportCharacter(player.Character, teleportLocations_Maaf[i])
            end
        end
    })
end

MountMaafTab:Space()

-- [[ SLIDER BARU UNTUK MAAF ]]
MountMaafTab:Slider({
    Title = "Auto Teleport Delay (detik)",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 60,
        Default = teleportDelay_Maaf,
    },
    Callback = function(value)
        teleportDelay_Maaf = value
        WindUI:Notify({ Title = "Delay Maaf", Content = "Diatur ke " .. value .. " detik" })
    end
})
MountMaafTab:Space() -- Kasih jarak lagi sebelum toggle
-- [[ AKHIR SLIDER BARU ]]

-- Toggle Auto Teleport untuk Maaf
autoTeleportToggle_Maaf = MountMaafTab:Toggle({
    Title = "Auto Teleport",
    Desc = "Otomatis teleport ke semua lokasi Maaf",
    Icon = "fast-forward",
    Default = false,
    Callback = function(state) 
        if state == true then
            -- 1. Matikan logika & UI lainnya
            stopAutoTeleport_Mika()
            if autoTeleportToggle_Mika then autoTeleportToggle_Mika:Set(false, true) end
            stopAutoTeleport_Gemi()
            if autoTeleportToggle_Gemi then autoTeleportToggle_Gemi:Set(false, true) end
            stopAutoTeleport_Beaja()
            if autoTeleportToggle_Beaja then autoTeleportToggle_Beaja:Set(false, true) end
            stopAutoTeleport_Kota() 
            if autoTeleportToggle_Kota then autoTeleportToggle_Kota:Set(false, true) end
            stopAutoTeleport_Yahayuk() 
            if autoTeleportToggle_Yahayuk then autoTeleportToggle_Yahayuk:Set(false, true) end 

            -- 2. Mulai logika Maaf
            autoTeleportEnabled_Maaf = true
            WindUI:Notify({ Title = "Auto Teleport (Maaf)", Content = "Auto Teleport: ON" })
            if teleportCoroutine_Maaf then coroutine.close(teleportCoroutine_Maaf) end
            teleportCoroutine_Maaf = coroutine.create(startTeleportLoop_Maaf)
            coroutine.resume(teleportCoroutine_Maaf)

        else
            -- 3. Jika toggle ini dimatikan, hentikan logikanya
            autoTeleportEnabled_Maaf = false
            if teleportCoroutine_Maaf then
                WindUI:Notify({ Title = "Auto Teleport (Maaf)", Content = "Auto Teleport: OFF" })
            end
            stopAutoTeleport_Maaf()
        end
    end
})


-- -----------------------------------------
-- UI UNTUK MOUNT 5 (KOTA) - (LOGIKA BARU DARI TXT)
-- -----------------------------------------
local MountKotaTab = TeleportLokasiSection:Tab({
    Title = "Mount Kota",
    Icon = "map-pin"
})

-- Looping lokasi Kota dan membuat tombol
for i, location in ipairs(teleportLocations_Kota) do
    MountKotaTab:Button({
        Title = "Lokasi " .. i,
        Icon = "navigation",
        Callback = function()
            stopAllAutoTeleports() -- Hentikan semua auto tp jika manual
            
            if player.Character then
                currentTeleportIndex_Kota = i
                print(string.format("Kota: Teleport manual ke Lokasi %d.", i))
                teleportCharacter(player.Character, teleportLocations_Kota[i])
            end
        end
    })
end

MountKotaTab:Space()

-- [[ SLIDER BARU UNTUK KOTA ]]
MountKotaTab:Slider({
    Title = "Auto Teleport Delay (detik)",
    Desc = "Delay setelah TP ke Lokasi 13",
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 60,
        Default = teleportDelay_Kota,
    },
    Callback = function(value)
        teleportDelay_Kota = value
        WindUI:Notify({ Title = "Delay Kota", Content = "Diatur ke " .. value .. " detik" })
    end
})
MountKotaTab:Space() -- Kasih jarak lagi sebelum toggle
-- [[ AKHIR SLIDER BARU ]]

-- Toggle Auto Teleport untuk Kota
autoTeleportToggle_Kota = MountKotaTab:Toggle({
    Title = "Auto Teleport (13 -> 14)",
    Desc = "Otomatis teleport ke 13 lalu jalan ke 14",
    Icon = "fast-forward",
    Default = false,
    Callback = function(state) 
        if state == true then
            -- 1. Matikan logika & UI lainnya
            stopAutoTeleport_Mika()
            if autoTeleportToggle_Mika then autoTeleportToggle_Mika:Set(false, true) end
            stopAutoTeleport_Gemi()
            if autoTeleportToggle_Gemi then autoTeleportToggle_Gemi:Set(false, true) end
            stopAutoTeleport_Beaja()
            if autoTeleportToggle_Beaja then autoTeleportToggle_Beaja:Set(false, true) end
            stopAutoTeleport_Maaf()
            if autoTeleportToggle_Maaf then autoTeleportToggle_Maaf:Set(false, true) end
            stopAutoTeleport_Yahayuk() 
            if autoTeleportToggle_Yahayuk then autoTeleportToggle_Yahayuk:Set(false, true) end 

            -- 2. Mulai logika Kota
            autoTeleportEnabled_Kota = true
            WindUI:Notify({ Title = "Auto Teleport (Kota)", Content = "Auto Teleport: ON (13->14)" })
            if teleportCoroutine_Kota then coroutine.close(teleportCoroutine_Kota) end
            teleportCoroutine_Kota = coroutine.create(startTeleportLoop_Kota)
            coroutine.resume(teleportCoroutine_Kota)

        else
            -- 3. Jika toggle ini dimatikan, hentikan logikanya
            autoTeleportEnabled_Kota = false
            if teleportCoroutine_Kota then
                WindUI:Notify({ Title = "Auto Teleport (Kota)", Content = "Auto Teleport: OFF" })
            end
            stopAutoTeleport_Kota()
        end
    end
})

-- -----------------------------------------
-- [[ AWAL BLOK BARU ]] UI UNTUK MOUNT 6 (YAHAYUK)
-- -----------------------------------------
local MountYahayukTab = TeleportLokasiSection:Tab({
    Title = "Mount Yahayuk",
    Icon = "map-pin"
})

-- Looping lokasi Yahayuk dan membuat tombol
for i, location in ipairs(teleportLocations_Yahayuk) do
    MountYahayukTab:Button({
        Title = "Lokasi " .. i,
        Icon = "navigation",
        Callback = function()
            stopAllAutoTeleports() -- Hentikan semua auto tp jika manual
            
            if player.Character then
                currentTeleportIndex_Yahayuk = i
                print(string.format("Yahayuk: Teleport manual ke Lokasi %d.", i))
                teleportCharacter(player.Character, teleportLocations_Yahayuk[i])
            end
        end
    })
end

MountYahayukTab:Space()

-- [[ SLIDER BARU UNTUK YAHAYUK (LOGIKA BARU) ]]
MountYahayukTab:Slider({
    Title = "Auto Teleport Delay (detik)",
    Desc = "Delay teleport lokasi 1-6", -- [DIUBAH]
    Step = 0.1,
    Value = {
        Min = 0.1,
        Max = 60,
        Default = teleportDelay_Yahayuk,
    },
    Callback = function(value)
        teleportDelay_Yahayuk = value
        WindUI:Notify({ Title = "Delay Yahayuk", Content = "Diatur ke " .. value .. " detik" })
    end
})
MountYahayukTab:Space() -- Kasih jarak lagi sebelum toggle
-- [[ AKHIR SLIDER BARU ]]

-- Toggle Auto Teleport untuk Yahayuk
autoTeleportToggle_Yahayuk = MountYahayukTab:Toggle({
    Title = "Auto Teleport (1-6, Jalan ke 7)", -- [DIUBAH]
    Desc = "Otomatis TP 1-6 lalu jalan ke 7 (tanpa respawn)", -- [DIUBAH]
    Icon = "fast-forward",
    Default = false,
    Callback = function(state) 
        if state == true then
            -- 1. Matikan logika & UI lainnya
            stopAutoTeleport_Mika()
            if autoTeleportToggle_Mika then autoTeleportToggle_Mika:Set(false, true) end
            stopAutoTeleport_Gemi()
            if autoTeleportToggle_Gemi then autoTeleportToggle_Gemi:Set(false, true) end
            stopAutoTeleport_Beaja()
            if autoTeleportToggle_Beaja then autoTeleportToggle_Beaja:Set(false, true) end
            stopAutoTeleport_Maaf()
            if autoTeleportToggle_Maaf then autoTeleportToggle_Maaf:Set(false, true) end
            stopAutoTeleport_Kota() 
            if autoTeleportToggle_Kota then autoTeleportToggle_Kota:Set(false, true) end

            -- 2. Mulai logika Yahayuk
            autoTeleportEnabled_Yahayuk = true
            WindUI:Notify({ Title = "Auto Teleport (Yahayuk)", Content = "Auto Teleport: ON (1-6, Jalan 7)" }) -- [DIUBAH]
            if teleportCoroutine_Yahayuk then coroutine.close(teleportCoroutine_Yahayuk) end
            teleportCoroutine_Yahayuk = coroutine.create(startTeleportLoop_Yahayuk)
            coroutine.resume(teleportCoroutine_Yahayuk)

        else
            -- 3. Jika toggle ini dimatikan, hentikan logikanya
            autoTeleportEnabled_Yahayuk = false
            if teleportCoroutine_Yahayuk then
                WindUI:Notify({ Title = "Auto Teleport (Yahayuk)", Content = "Auto Teleport: OFF" })
            end
            stopAutoTeleport_Yahayuk()
        end
    end
})
-- [[ AKHIR BLOK BARU ]]


-- ===================================================================
-- [[ AKHIR DARI PENAMBAHAN UI TELEPORT LOKASI ]]
-- ===================================================================


local ConfigUsageSection = Window:Section({
    Title = "Config Usage",
})
local OtherSection = Window:Section({
    Title = "Other",
})


-- */ Using Nebula Icons /* --
do
    local NebulaIcons = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/nebula-icon-library-loader"))()
    
    -- Adding icons (e.g. Fluency)
    WindUI.Creator.AddIcons("fluency",    NebulaIcons.Fluency)
    --               ^ Icon name          ^ Table of Icons
    
    -- You can also add nebula icons
    WindUI.Creator.AddIcons("nebula",    NebulaIcons.nebulaIcons)
    
    -- Usage ↑ ↓
    
    local TestSection = Window:Section({
        Title = "Custom icons usage test (nebula)",
        Icon = "nebula:nebula",
    })
end



-- */  Toggle Tab  /* --
do
    local ToggleTab = ElementsSection:Tab({
        Title = "Toggle",
        Icon = "arrow-left-right"
    })
    
    
    ToggleTab:Toggle({
        Title = "Toggle",
    })
    
    ToggleTab:Space()
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Desc = "Toggle example"
    })
    
    ToggleTab:Space()
    
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Locked = true,
    })
    
    ToggleTab:Toggle({
        Title = "Toggle",
        Desc = "Toggle example",
        Locked = true,
    })
end


-- */  Button Tab  /* --
do
    local ButtonTab = ElementsSection:Tab({
        Title = "Button",
        Icon = "mouse-pointer-click",
    })
    
    
    local HighlightButton
    HighlightButton = ButtonTab:Button({
        Title = "Highlight Button",
        Icon = "mouse",
        Callback = function()
            print("clicked highlight")
            HighlightButton:Highlight()
        end
    })

    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Blue Button",
        Color = Color3.fromHex("#305dff"),
        Icon = "",
        Callback = function()
        end
    })

    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Blue Button",
        Desc = "With description",
        Color = Color3.fromHex("#305dff"),
        Icon = "",
        Callback = function()
        end
    })
    
    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Button",
        Desc = "Button example",
    })
    
    ButtonTab:Space()
    
    ButtonTab:Button({
        Title = "Button",
        Locked = true,
    })
    
    
    ButtonTab:Button({
        Title = "Button",
        Desc = "Button example",
        Locked = true,
    })
end


-- */  Input Tab  /* --
do
    local InputTab = ElementsSection:Tab({
        Title = "Input",
        Icon = "text-cursor-input",
    })
    
    
    InputTab:Input({
        Title = "Input",
        Icon = "mouse"
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Type = "Textarea",
        Icon = "mouse",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Type = "Textarea",
        --Icon = "mouse",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input",
        Desc = "Input example",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input Textarea",
        Desc = "Input example",
        Type = "Textarea",
    })
    
    InputTab:Space()
    
    
    InputTab:Input({
        Title = "Input",
        Locked = true,
    })
    
    
    InputTab:Input({
        Title = "Input",
        Desc = "Input example",
        Locked = true,
    })
end





-- */  Config Usage  /* --
do -- config elements
    local ConfigElementsTab = ConfigUsageSection:Tab({
        Title = "Config Elements",
        Icon = "square-dashed-mouse-pointer",
    })
    
    -- All elements are taken from the official documentation: https://footagesus.github.io/WindUI-Docs/docs
    
    -- Saving elements to the config using `Flag`
    
    ConfigElementsTab:Colorpicker({
        Flag = "ColorpickerTest",
        Title = "Colorpicker",
        Desc = "Colorpicker Description",
        Default = Color3.fromRGB(0, 255, 0),
        Transparency = 0,
        Locked = false,
        Callback = function(color) 
            print("Background color: " .. tostring(color))
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Dropdown({
        Flag = "DropdownTest",
        Title = "Advanced Dropdown",
        Values = {
            {
                Title = "Category A",
                Icon = "bird"
            },
            {
                Title = "Category B",
                Icon = "house"
            },
            {
                Title = "Category C",
                Icon = "droplet"
            },
        },
        Value = "Category A",
        Callback = function(option) 
            print("Category selected: " .. option.Title .. " with icon " .. option.Icon) 
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Input({
        Flag = "InputTest",
        Title = "Input",
        Desc = "Input Description",
        Value = "Default value",
        InputIcon = "bird",
        Type = "Input", -- or "Textarea"
        Placeholder = "Enter text...",
        Callback = function(input) 
            print("Text entered: " .. input)
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Keybind({
        Flag = "KeybindTest",
        Title = "Keybind",
        Desc = "Keybind to open ui",
        Value = "G",
        Callback = function(v)
            Window:SetToggleKey(Enum.KeyCode[v])
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Slider({
        Flag = "SliderTest",
        Title = "Slider",
        Step = 1,
        Value = {
            Min = 20,
            Max = 120,
            Default = 70,
        },
        Callback = function(value)
            print(value)
        end
    })
    
    ConfigElementsTab:Space()
    
    ConfigElementsTab:Toggle({
        Flag = "ToggleTest",
        Title = "Toggle",
        Desc = "Toggle Description",
        --Icon = "house",
        --Type = "Checkbox",
        Default = false,
        Callback = function(state) 
            print("Toggle Activated" .. tostring(state))
        end
    })
end

do -- config panel
    local ConfigTab = ConfigUsageSection:Tab({
        Title = "Config Usage",
        Icon = "folder",
    })

    local ConfigManager = Window.ConfigManager
    local ConfigName = "default"

    local ConfigNameInput = ConfigTab:Input({
        Title = "Config Name",
        Icon = "file-cog",
        Callback = function(value)
            ConfigName = value
        end
    })

    local AllConfigs = ConfigManager:AllConfigs()
    local DefaultValue = table.find(AllConfigs, ConfigName) and ConfigName or nil

    ConfigTab:Dropdown({
        Title = "All Configs",
        Desc = "Select existing configs",
        Values = AllConfigs,
        Value = DefaultValue,
        Callback = function(value)
            ConfigName = value
            ConfigNameInput:Set(value)
        end
    })

    ConfigTab:Space()

    ConfigTab:Button({
        Title = "Save Config",
        Icon = "",
        Justify = "Center",
        Callback = function()
            Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
            if Window.CurrentConfig:Save() then
                WindUI:Notify({
                    Title = "Config Saved",
                    Desc = "Config '" .. ConfigName .. "' saved",
                    Icon = "check",
                })
            end
        end
    })

    ConfigTab:Space()

    ConfigTab:Button({
        Title = "Load Config",
        Icon = "",
        Justify = "Center",
        Callback = function()
            Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
            if Window.CurrentConfig:Load() then
                WindUI:Notify({
                    Title = "Config Loaded",
                    Desc = "Config '" .. ConfigName .. "' loaded",
                    Icon = "refresh-cw",
                })
            end
        end
    })
end




-- */  Other  /* --
do
    local InviteCode = "ftgs-development-hub-1300692552005189632"
    local DiscordAPI = "https://discord.com/api/v10/invites/" .. InviteCode .. "?with_counts=true&with_expiration=true"

    local Response = game:GetService("HttpService"):JSONDecode(WindUI.Creator.Request({
        Url = DiscordAPI,
        Method = "GET",
        Headers = {
            ["User-Agent"] = "WindUI/Example",
            ["Accept"] = "application/json"
        }
    }).Body)
    
    local DiscordTab = OtherSection:Tab({
        Title = "Discord",
    })
    
    if Response and Response.guild then
        DiscordTab:Section({
            Title = "Join our Discord server!",
            TextSize = 20,
        })
        local DiscordServerParagraph = DiscordTab:Paragraph({
            Title = tostring(Response.guild.name),
            Desc = tostring(Response.guild.description),
            Image = "https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024",
            Thumbnail = "https://cdn.discordapp/banners/1300692552005189632/35981388401406a4b7dffd6f447a64c4.png?size=512",
            ImageSize = 48,
            Buttons = {
                {
                    Title = "Copy link",
                    Icon = "link",
                    Callback = function()
                        setclipboard("https://discord.gg/" .. InviteCode)
                    end
                }
            }
        })
        
    end
end
