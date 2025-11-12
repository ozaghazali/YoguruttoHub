-- Load WindUI Library
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
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ContextActionService = game:GetService("ContextActionService")

-- SAYA TAMBAHKAN: Variabel mouse untuk Click Teleport
local mouse = player:GetMouse() 

-- Fungsi Teleport Umum (dipakai bersama)
local function teleportCharacter(character, position)
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- ===================================================================
-- [[ FITUR FREECAM ]]
-- ===================================================================

local FreecamModule = (function()
    local v1 = {}
    local v_u_3 = math.abs
    local v_u_4 = math.clamp
    local v_u_5 = math.exp
    local v_u_6 = math.rad
    local v_u_7 = math.sign
    local v_u_8 = math.sqrt
    local v_u_9 = math.tan
    local v_u_10 = game:GetService("ContextActionService")
    local v11 = game:GetService("Players")
    local v_u_12 = game:GetService("RunService")
    local v_u_13 = game:GetService("StarterGui")
    local v_u_14 = game:GetService("UserInputService")
    local v_u_15 = game:GetService("Workspace")
    local v_u_16 = v11.LocalPlayer
    if not v_u_16 then
        v11:GetPropertyChangedSignal("LocalPlayer"):Wait()
        v_u_16 = v11.LocalPlayer
    end
    local v_u_17 = v_u_15.CurrentCamera
    v_u_15:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        local v18 = v_u_15.CurrentCamera
        if v18 then
            v_u_17 = v18
        end
    end)
    local v_u_19 = Enum.ContextActionPriority.High.Value
    local v_u_20 = Vector2.new(0.75, 1) * 8
    local v_u_21 = {}
    v_u_21.__index = v_u_21
    function v_u_21.new(p22, p23)
        local v24 = v_u_21
        local v25 = setmetatable({}, v24)
        v25.f = p22
        v25.p = p23
        v25.v = p23 * 0
        return v25
    end
    function v_u_21.Update(p26, p27, p28)
        local v29 = p26.f * 2 * 3.141592653589793
        local v30 = p26.p
        local v31 = p26.v
        local v32 = p28 - v30
        local v33 = v_u_5(-v29 * p27)
        local v34 = p28 + (v31 * p27 - v32 * (v29 * p27 + 1)) * v33
        local v35 = (v29 * p27 * (v32 * v29 - v31) + v31) * v33
        p26.p = v34
        p26.v = v35
        return v34
    end
    function v_u_21.Reset(p36, p37)
        p36.p = p37
        p36.v = p37 * 0
    end
    local v_u_38 = Vector3.new()
    local v_u_39 = Vector2.new()
    local v_u_40 = 0
    local v_u_41 = v_u_21.new(1.5, (Vector3.new()))
    local v_u_42 = v_u_21.new(1, Vector2.new())
    local v_u_43 = v_u_21.new(4, 0)
    local v_u_44 = {}
    local function v_u_46(p45)
        return v_u_7(p45) * v_u_4((v_u_5(2 * ((v_u_3(p45) - 0.15) / 0.85)) - 1) / 6.38905609893065, 0, 1)
    end
    local v_u_47 = { ButtonX = 0, ButtonY = 0, DPadDown = 0, DPadUp = 0, ButtonL2 = 0, ButtonR2 = 0, Thumbstick1 = Vector2.new(), Thumbstick2 = Vector2.new() }
    local v_u_48 = { W = 0, A = 0, S = 0, D = 0, E = 0, Q = 0, U = 0, H = 0, J = 0, K = 0, I = 0, Y = 0, Up = 0, Down = 0, LeftShift = 0, RightShift = 0 }
    local v_u_49 = { Delta = Vector2.new(), MouseWheel = 0 }
    local v_u_50 = Vector2.new(1, 1) * 0.04908738521234052
    local v_u_51 = Vector2.new(1, 1) * 0.39269908169872414
    local v_u_52 = 1
    function v_u_44.Vel(p53)
        v_u_52 = v_u_4(v_u_52 + p53 * (v_u_48.Up - v_u_48.Down) * 0.75, 0.01, 4)
        local v54 = v_u_46(v_u_47.Thumbstick1.X)
        local v55 = v_u_46(v_u_47.ButtonR2) - v_u_46(v_u_47.ButtonL2)
        local v56 = v_u_46
        local v57 = -v_u_47.Thumbstick1.Y
        local v58 = Vector3.new(v54, v55, v56(v57)) * Vector3.new(1, 1, 1)
        local v59 = v_u_48.D - v_u_48.A + v_u_48.K - v_u_48.H
        local v60 = v_u_48.E - v_u_48.Q + v_u_48.I - v_u_48.Y
        local v61 = v_u_48.S - v_u_48.W + v_u_48.J - v_u_48.U
        local v62 = Vector3.new(v59, v60, v61) * Vector3.new(1, 1, 1)
        local v63 = v_u_14:IsKeyDown(Enum.KeyCode.LeftShift) or v_u_14:IsKeyDown(Enum.KeyCode.RightShift)
        return (v58 + v62) * (v_u_52 * (v63 and 0.25 or 1))
    end
    function v_u_44.Pan(_)
        local v64 = Vector2.new(v_u_46(v_u_47.Thumbstick2.Y), v_u_46(-v_u_47.Thumbstick2.X)) * v_u_51
        local v65 = v_u_49.Delta * v_u_50
        v_u_49.Delta = Vector2.new()
        return v64 + v65
    end
    function v_u_44.Fov(_)
        local v66 = (v_u_47.ButtonX - v_u_47.ButtonY) * 0.25
        local v67 = v_u_49.MouseWheel * 1
        v_u_49.MouseWheel = 0
        return v66 + v67
    end
    local function v_u_70(_, p68, p69)
        v_u_48[p69.KeyCode.Name] = p68 == Enum.UserInputState.Begin and 1 or 0
        return Enum.ContextActionResult.Sink
    end
    local function v_u_73(_, p71, p72)
        v_u_47[p72.KeyCode.Name] = p71 == Enum.UserInputState.Begin and 1 or 0
        return Enum.ContextActionResult.Sink
    end
    local function v_u_76(_, _, p74)
        local v75 = p74.Delta
        v_u_49.Delta = Vector2.new(-v75.y, -v75.x)
        return Enum.ContextActionResult.Sink
    end
    local function v_u_78(_, _, p77)
        v_u_47[p77.KeyCode.Name] = p77.Position
        return Enum.ContextActionResult.Sink
    end
    local function v_u_80(_, _, p79)
        v_u_47[p79.KeyCode.Name] = p79.Position.z
        return Enum.ContextActionResult.Sink
    end
    local function v_u_82(_, _, p81)
        v_u_49[p81.UserInputType.Name] = -p81.Position.z
        return Enum.ContextActionResult.Sink
    end
    local v_u_83 = nil
    function v_u_44.StartCapture()
        v_u_10:BindActionAtPriority("FreecamKeyboard", v_u_70, false, v_u_19, Enum.KeyCode.W, Enum.KeyCode.U, Enum.KeyCode.A, Enum.KeyCode.H, Enum.KeyCode.S, Enum.KeyCode.J, Enum.KeyCode.D, Enum.KeyCode.K, Enum.KeyCode.E, Enum.KeyCode.I, Enum.KeyCode.Q, Enum.KeyCode.Y, Enum.KeyCode.Up, Enum.KeyCode.Down)
        v_u_10:BindActionAtPriority("FreecamMousePan", v_u_76, false, v_u_19, Enum.UserInputType.MouseMovement)
        v_u_10:BindActionAtPriority("FreecamMouseWheel", v_u_82, false, v_u_19, Enum.UserInputType.MouseWheel)
        v_u_10:BindActionAtPriority("FreecamGamepadButton", v_u_73, false, v_u_19, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY)
        v_u_10:BindActionAtPriority("FreecamGamepadTrigger", v_u_80, false, v_u_19, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2)
        v_u_10:BindActionAtPriority("FreecamGamepadThumbstick", v_u_78, false, v_u_19, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2)
        local touchMovedConn = v_u_14.TouchMoved:Connect(function(p84)
            local v85 = p84.Delta
            v_u_49.Delta = Vector2.new(-v85.Y, -v85.X)
        end)
        v_u_83 = touchMovedConn
    end
    function v_u_44.StopCapture()
        if v_u_83 then
            v_u_83:Disconnect()
            v_u_83 = nil
        end
        v_u_52 = 1
        local v86 = v_u_47; for v87, v88 in pairs(v86) do v86[v87] = v88 * 0 end
        local v89 = v_u_48; for v90, v91 in pairs(v89) do v89[v90] = v91 * 0 end
        local v92 = v_u_49; for v93, v94 in pairs(v92) do v92[v93] = v94 * 0 end
        v_u_10:UnbindAction("FreecamKeyboard"); v_u_10:UnbindAction("FreecamMousePan"); v_u_10:UnbindAction("FreecamMouseWheel")
        v_u_10:UnbindAction("FreecamGamepadButton"); v_u_10:UnbindAction("FreecamGamepadTrigger"); v_u_10:UnbindAction("FreecamGamepadThumbstick")
    end
    local function v_u_112(p95)
        local v96 = v_u_17.ViewportSize
        local v97 = v_u_9(v_u_40 / 2) * 2
        local v98 = v96.x / v96.y * v97
        local v99 = p95.rightVector;
        local v100 = p95.upVector; 
        local v101 = p95.lookVector
        local v102 = Vector3.new();
        local v103 = 512
        for v104 = 0, 1, 0.5 do
            for v105 = 0, 1, 0.5 do
                local v106 = (v104 - 0.5) * v98;
                local v107 = (v105 - 0.5) * v97
                local v108 = v99 * v106 - v100 * v107 + v101;
                local v109 = p95.p + v108 * 0.1
                local _, v110 = v_u_15:FindPartOnRay(Ray.new(v109, v108.unit * v103))
                local v111 = (v110 - v109).magnitude
                if v111 < v103 then v102 = v108.unit; v103 = v111 end
            end
        end
        return v101:Dot(v102) * v103
    end
    local function v_u_119(p113)
        local v114 = v_u_41:Update(p113, v_u_44.Vel(p113)); local v115 = v_u_42:Update(p113, v_u_44.Pan(p113));
        local v116 = v_u_43:Update(p113, v_u_44.Fov(p113))
        local v117 = v_u_8(0.7002075382097097 / v_u_9((v_u_6(v_u_40 / 2))))
        v_u_40 = v_u_4(v_u_40 + v116 * 300 * (p113 / v117), 1, 120)
        v_u_39 = v_u_39 + v115 * v_u_20 * (p113 / v117)
        v_u_39 = Vector2.new(v_u_4(v_u_39.x, -1.5707963267948966, 1.5707963267948966), v_u_39.y % 6.283185307179586)
        local v118 = CFrame.new(v_u_38) * CFrame.fromOrientation(v_u_39.x, v_u_39.y, 0) * CFrame.new(v114 * Vector3.new(64, 64, 64) * p113)
        v_u_38 = v118.p
        v_u_17.CFrame = v118
        v_u_17.Focus = v118 * CFrame.new(0, 0, -v_u_112(v118))
        v_u_17.FieldOfView = v_u_40
    end
    local v_u_120 = {}
    local v_u_121, v_u_122, v_u_123, v_u_124, v_u_125, v_u_126 = nil, nil, nil, nil, nil, nil
    local v_u_127 = {}
    local v_u_128 = { Backpack = true, Chat = true, Health = true, PlayerList = true }
    local v_u_129 = { BadgesNotificationsActive = true, PointsNotificationsActive = true }
    function v_u_120.Push()
        for v130 in pairs(v_u_128) do v_u_128[v130] = v_u_13:GetCoreGuiEnabled(Enum.CoreGuiType[v130]); v_u_13:SetCoreGuiEnabled(Enum.CoreGuiType[v130], false) end
        for v131 in pairs(v_u_129) do v_u_129[v131] = v_u_13:GetCore(v131); v_u_13:SetCore(v131, false) end
        local v132 = v_u_16:FindFirstChildOfClass("PlayerGui")
        if v132 then
            for _, v133 in pairs(v132:GetChildren()) do
                if v133:IsA("ScreenGui") and v133.Enabled and v133.Name ~= "TeleportControlGui" then v_u_127[#v_u_127 + 1] = v133; v133.Enabled = false end
            end
        end
        v_u_126 = v_u_17.FieldOfView; v_u_17.FieldOfView = 70; v_u_123 = v_u_17.CameraType; v_u_17.CameraType = Enum.CameraType.Custom
        v_u_125 = v_u_17.CFrame; v_u_124 = v_u_17.Focus; v_u_122 = v_u_14.MouseIconEnabled; v_u_14.MouseIconEnabled = false
        v_u_121 = v_u_14.MouseBehavior; v_u_14.MouseBehavior = Enum.MouseBehavior.Default
    end
    function v_u_120.Pop()
        for v134, v135 in pairs(v_u_128) do v_u_13:SetCoreGuiEnabled(Enum.CoreGuiType[v134], v135) end
        for v136, v137 in pairs(v_u_129) do v_u_13:SetCore(v136, v137) end
        for _, v138 in pairs(v_u_127) do if v138 and v138.Parent then v138.Enabled = true end end
        v_u_17.FieldOfView = v_u_126; v_u_126 = nil; v_u_17.CameraType = v_u_123; v_u_123 = nil; v_u_17.CFrame = v_u_125; v_u_125 = nil
        v_u_17.Focus = v_u_124; v_u_124 = nil; v_u_14.MouseIconEnabled = v_u_122; v_u_122 = nil; v_u_14.MouseBehavior = v_u_121; v_u_121 = nil
    end
    local function v_u_140()
        local v139 = v_u_17.CFrame
        v_u_39 = Vector2.new(v139:toEulerAnglesYXZ()); v_u_38 = v139.p; v_u_40 = v_u_17.FieldOfView
        v_u_41:Reset((Vector3.new())); v_u_42:Reset(Vector2.new()); v_u_43:Reset(0)
        v_u_120.Push()
        v_u_12:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, v_u_119)
        v_u_44.StartCapture()
    end
    local v_u_141 = false
    function v1.ToggleFreecam()
        if v_u_141 then
            v_u_44.StopCapture()
            v_u_12:UnbindFromRenderStep("Freecam")
            v_u_120.Pop()
        else
            v_u_140()
        end
        v_u_141 = not v_u_141
        return v_u_141
    end
    return v1
end)()

-- ===================================================================
-- [[ VARIABEL UNTUK STATE MANAGEMENT ]]
-- ===================================================================

local flyToggle, freecamToggle -- Reference untuk UI toggles

-- Variabel cek R15
local isR15 = player.Character and player.Character:WaitForChild("Humanoid").RigType == Enum.HumanoidRigType.R15

-- ===================================================================
-- [[ FITUR FLY ]]
-- ===================================================================

local flyEnabled = false
local flyKeyDown, flyKeyUp
local flyControl = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local fly_lControl = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
local flySpeed = 1
local flyBaseSpeed = 50

local function getFlyRoot(char)
    return char:FindFirstChild("HumanoidRootPart")
end

local function startFly()
    if flyEnabled then return end
    
    -- Matikan fitur yang konflik
    if freecamEnabled then
        FreecamModule.ToggleFreecam()
        freecamEnabled = false
    end

    repeat task.wait() until player and player.Character and getFlyRoot(player.Character) and player.Character:FindFirstChildOfClass("Humanoid")
    
    if flyKeyDown or flyKeyUp then 
        flyKeyDown:Disconnect() 
        flyKeyUp:Disconnect() 
    end

    local T = getFlyRoot(player.Character)
    local CONTROL = flyControl
    local lCONTROL = fly_lControl
    local SPEED = 0

    local function FLY()
        flyEnabled = true
        local BG = Instance.new("BodyGyro")
        local BV = Instance.new("BodyVelocity")
        BG.Name = "AsuHub_FlyGyro"
        BV.Name = "AsuHub_FlyVelocity"
        BG.P = 9e4
        BG.Parent = T
        BV.Parent = T
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = T.CFrame
        BV.velocity = Vector3.new(0, 0, 0)
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
        task.spawn(function()
            repeat task.wait()
                if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                    player.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = flyBaseSpeed -- SAYA UBAH: Menggunakan variabel yang bisa diubah
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + 
                                 ((Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.velocity = ((Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + 
                                 ((Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                else
                    BV.velocity = Vector3.new(0, 0, 0)
                end
                BG.cframe = Workspace.CurrentCamera.CoordinateFrame
            until not flyEnabled
            
            -- Reset state
            flyControl = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            fly_lControl = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            
            -- Cleanup
            BG:Destroy()
            BV:Destroy()
            if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                player.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
            end
        end)
    end

    -- Input handlers
    flyKeyDown = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if not flyEnabled then return end

        local KEY = input.KeyCode.Name:lower()
        if KEY == "w" then
            flyControl.F = flySpeed
        elseif KEY == "s" then
            flyControl.B = -flySpeed
        elseif KEY == "a" then
            flyControl.L = -flySpeed
        elseif KEY == "d" then
            flyControl.R = flySpeed
        elseif KEY == "e" then
            flyControl.Q = flySpeed * 2
        elseif KEY == "q" then
            flyControl.E = -flySpeed * 2
        end
        pcall(function() Workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
    end)

    flyKeyUp = UserInputService.InputEnded:Connect(function(input, gameProcessed)
        local KEY = input.KeyCode.Name:lower()
        if KEY == "w" then
            flyControl.F = 0
        elseif KEY == "s" then
            flyControl.B = 0
        elseif KEY == "a" then
            flyControl.L = 0
        elseif KEY == "d" then
            flyControl.R = 0
        elseif KEY == "e" then
            flyControl.Q = 0
        elseif KEY == "q" then
            flyControl.E = 0
        end
    end)
    
    FLY()
end

local function stopFly()
    if not flyEnabled then return end
    flyEnabled = false
    
    if flyKeyDown then 
        flyKeyDown:Disconnect() 
        flyKeyDown = nil
    end
    if flyKeyUp then 
        flyKeyUp:Disconnect() 
        flyKeyUp = nil
    end
    
    -- Cleanup manual
    if player.Character then
        local root = getFlyRoot(player.Character)
        if root then
            local gyro = root:FindFirstChild("AsuHub_FlyGyro")
            local vel = root:FindFirstChild("AsuHub_FlyVelocity")
            if gyro then gyro:Destroy() end
            if vel then vel:Destroy() end
        end
        if player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
        end
    end
    
    pcall(function() Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

-- ===================================================================
-- [[ FITUR ESP ]]
-- ===================================================================

-- Konfigurasi ESP
local ESP_FRIEND_COLOR = Color3.fromRGB(0, 0, 255)
local ESP_ENEMY_COLOR = Color3.fromRGB(255, 0, 0) 
local ESP_USE_TEAM_COLOR = true

-- Holder untuk ESP
local espHolder = Instance.new("Folder", game:GetService("CoreGui"))
espHolder.Name = "AsuHub_ESP_Holder"

-- Template untuk NameTag
local espNameTagTemplate = Instance.new("BillboardGui")
espNameTagTemplate.Name = "ESP_NameTag"
espNameTagTemplate.Enabled = true
espNameTagTemplate.Size = UDim2.new(0, 200, 0, 60)
espNameTagTemplate.AlwaysOnTop = true
espNameTagTemplate.StudsOffset = Vector3.new(0, 3, 0)

-- Layout untuk NameTag
local espListLayout = Instance.new("UIListLayout", espNameTagTemplate)
espListLayout.FillDirection = Enum.FillDirection.Vertical
espListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
espListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Label untuk Jarak
local espDistanceLabel = Instance.new("TextLabel", espNameTagTemplate)
espDistanceLabel.Name = "Distance"
espDistanceLabel.BackgroundTransparency = 1
espDistanceLabel.Size = UDim2.new(1, 0, 0, 20)
espDistanceLabel.TextSize = 16
espDistanceLabel.TextColor3 = Color3.new(1, 1, 1)
espDistanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
espDistanceLabel.TextStrokeTransparency = 0.2
espDistanceLabel.Text = " 0 m "
espDistanceLabel.Font = Enum.Font.SourceSans

-- Label untuk Nama
local espTagLabel = Instance.new("TextLabel", espNameTagTemplate)
espTagLabel.Name = "Tag"
espTagLabel.BackgroundTransparency = 1
espTagLabel.Size = UDim2.new(1, 0, 0, 20)
espTagLabel.TextSize = 16
espTagLabel.TextColor3 = Color3.new(1, 1, 1)
espTagLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
espTagLabel.TextStrokeTransparency = 0.4
espTagLabel.Text = "PlayerName"
espTagLabel.Font = Enum.Font.SourceSansBold

local espEnabled = false
local espConnection = nil

-- Fungsi untuk menghapus ESP dari pemain tertentu
local function removeESP(target)
    if target.Character then
        -- Hapus Highlight
        local highlight = target.Character:FindFirstChild("AsuHub_ESP_Highlight")
        if highlight then
            highlight:Destroy()
        end

        -- Kembalikan nama default Roblox
        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        end
    end

    -- Hapus NameTag
    local nameTag = espHolder:FindFirstChild(target.Name .. "_NameTag")
    if nameTag then
        nameTag:Destroy()
    end
end

-- Fungsi untuk memperbarui ESP pemain
local function updateESP(target, color)
    local localPlayerHead = player.Character and player.Character:FindFirstChild("Head")
    
    if target.Character and target.Character:FindFirstChild("Head") and target.Character:FindFirstChildOfClass("Humanoid") then
        local head = target.Character.Head
        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")

        -- Sembunyikan nama default Roblox
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

        -- Update Highlight
        local highlight = target.Character:FindFirstChild("AsuHub_ESP_Highlight") 
        if not highlight then
            highlight = Instance.new("Highlight") 
            highlight.Name = "AsuHub_ESP_Highlight"
            highlight.Adornee = target.Character
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.OutlineTransparency = 1  -- Tidak ada outline
            highlight.FillColor = color
            highlight.Parent = target.Character
        else
            highlight.FillColor = color
        end

        -- Update NameTag (BillboardGui)
        local nameTag = espHolder:FindFirstChild(target.Name .. "_NameTag")
        if not nameTag then
            nameTag = espNameTagTemplate:Clone()
            nameTag.Name = target.Name .. "_NameTag"
            nameTag.Adornee = head
            nameTag.Parent = espHolder
        end
        
        if nameTag.Adornee ~= head then -- Jika karakter respawn
            nameTag.Adornee = head
        end
        
        -- Update Teks Nama
        local tagLabel = nameTag:FindFirstChild("Tag")
        if tagLabel then
            tagLabel.Text = target.DisplayName -- Menampilkan nama
            tagLabel.TextColor3 = color -- Menyesuaikan warna
        end

        -- Update Teks Jarak
        local distanceLabel = nameTag:FindFirstChild("Distance")
        if distanceLabel then
            if localPlayerHead then
                local distance = (localPlayerHead.Position - head.Position).Magnitude
                distanceLabel.Text = " " .. math.floor(distance + 0.5) .. " m "
            else
                distanceLabel.Text = " - m " -- Tampil jika player lokal mati
            end
            distanceLabel.TextColor3 = color
        end
    else
        -- Jika karakter tidak ada, hapus ESP
        removeESP(target)
    end
end

-- Fungsi untuk mematikan ESP
local function stopESP()
    if not espEnabled then return end
    espEnabled = false
    
    if espConnection then
        espConnection:Disconnect()
        espConnection = nil
    end
    
    -- Hapus semua ESP yang tersisa
    for _, v in ipairs(Players:GetPlayers()) do
        removeESP(v) 
    end
end

-- Fungsi untuk menyalakan ESP
local function startESP()
    if espEnabled then return end
    espEnabled = true
    
    espConnection = RunService.Heartbeat:Connect(function()
        local allPlayers = Players:GetPlayers()
        local activeESPPlayers = {}

        for _, v in ipairs(allPlayers) do
            if v ~= player then
                local color = ESP_USE_TEAM_COLOR and v.TeamColor.Color or 
                             ((player.TeamColor == v.TeamColor) and ESP_FRIEND_COLOR or ESP_ENEMY_COLOR)
                updateESP(v, color)
                activeESPPlayers[v.Name] = true
            else
                removeESP(v) -- Selalu hapus ESP dari diri sendiri
            end
        end

        -- Cleanup untuk GUI pemain yang keluar
        for _, child in ipairs(espHolder:GetChildren()) do
            if child:IsA("BillboardGui") then
                local playerName = string.gsub(child.Name, "_NameTag", "")
                if not activeESPPlayers[playerName] then
                    child:Destroy()
                end
            end
        end
    end)
end

-- ===================================================================
-- [[ FUNGSI TOGGLE UNTUK UI ]]
-- ===================================================================

local freecamEnabled = false

-- SAYA TAMBAHKAN: Variabel untuk Click Teleport
local clickTeleportEnabled = false
local clickTeleportConnection = nil

local function blockJumpAction(actionName, inputState, inputObject)
    if inputState == Enum.UserInputState.Begin and inputObject.KeyCode == Enum.KeyCode.Space then
        -- Blokir spasi selama freecam
        return Enum.ContextActionResult.Sink
    end
    return Enum.ContextActionResult.Pass
end

local function toggleFreecam(state)
    if state == freecamEnabled then return end
    
    local result
    if state then
        -- Matikan fitur yang konflik sebelum mengaktifkan freecam
        if flyEnabled then
            toggleFly(false)
        end
        
        result = FreecamModule.ToggleFreecam()
        freecamEnabled = result
        
        -- Blokir spasi menggunakan ContextActionService
        ContextActionService:BindActionAtPriority("BlockFreecamJump", blockJumpAction, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Space)
        
        WindUI:Notify({ Title = "Freecam", Content = "Freecam enabled!" })
    else
        result = FreecamModule.ToggleFreecam()
        freecamEnabled = result
        
        -- Hapus blokir spasi
        ContextActionService:UnbindAction("BlockFreecamJump")
        
        -- Reset lainnya
        task.wait(0.1)
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        
        local StarterGui = game:GetService("StarterGui")
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, true)
        
        WindUI:Notify({ Title = "Freecam", Content = "Freecam disabled!" })
    end
    return result
end

local function toggleFly(state)
    if state == flyEnabled then return end -- Prevent duplicate toggles
    
    if state then
        startFly()
        flyEnabled = true
        WindUI:Notify({ Title = "Fly", Content = "Fly enabled - Use W/A/S/D/Q/E to move" })
    else
        stopFly()
        flyEnabled = false
        WindUI:Notify({ Title = "Fly", Content = "Fly disabled" })
    end
end

local function toggleESP(state)
    if state then
        startESP()
        WindUI:Notify({ Title = "ESP", Content = "ESP enabled - Showing player names and distances" })
    else
        stopESP()
        WindUI:Notify({ Title = "ESP", Content = "ESP disabled" })
    end
end

-- ===================================================================
-- [[ SAYA TAMBAHKAN: FITUR CLICK TELEPORT ]]
-- ===================================================================

-- Pastikan fungsi Anda persis seperti ini
local function toggleClickTeleport(state)
    if state == clickTeleportEnabled then return end -- Mencegah duplikat
    clickTeleportEnabled = state

    -- Baris ini penting untuk mengontrol skrip eksternal JIKA telanjjur berjalan
    _G.WRDClickTeleport = state

    if state then
        -- Aktifkan Click Teleport
        if clickTeleportConnection then
            clickTeleportConnection:Disconnect() -- Hapus koneksi lama jika ada
        end
        
        if not mouse then
            WindUI:Notify({ Title = "Error", Content = "Mouse instance not found!" })
            return
        end

        clickTeleportConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end -- Jangan proses jika game sudah memproses input
            
            -- Cek apakah toggle-nya aktif (dari variabel lokal)
            if clickTeleportEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
                -- Cek apakah LeftControl ditekan
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    if player.Character then
                        -- Gunakan MoveTo, dan mouse.Hit.Position (Vector3)
                        player.Character:MoveTo(mouse.Hit.Position) 
                    end
                end
            end
        end)
        
        WindUI:Notify({ Title = "Click Teleport", Content = "Enabled - Hold Left Ctrl + Click to teleport" })

    else
        -- Matikan Click Teleport
        if clickTeleportConnection then
            clickTeleportConnection:Disconnect()
            clickTeleportConnection = nil
        end
        WindUI:Notify({ Title = "Click Teleport", Content = "Disabled" })
    end
end

-- ===================================================================
-- [[ PERBAIKAN KEYBINDS GLOBAL ]]
-- ===================================================================

-- Variabel untuk melacak status
local flyKeybindEnabled = false
local freecamKeybindEnabled = false

-- Fungsi untuk menangani input global
local function handleGlobalInput(input, gameProcessed)
    if gameProcessed then return end
    
    -- Fly keybind (V)
    if input.KeyCode == Enum.KeyCode.V then
        local newState = not flyEnabled
        toggleFly(newState)
        
        -- Update UI toggle secara silent
        if flyToggle then
            flyToggle:Set(newState, true) -- true = jangan panggil callback
        end
    end
    
    -- Freecam keybind (Shift + P)
    if input.KeyCode == Enum.KeyCode.P and 
       (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or 
        UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) then
        local newState = not freecamEnabled
        toggleFreecam(newState)
        
        -- Update UI toggle secara silent
        if freecamToggle then
            freecamToggle:Set(newState, true) -- true = jangan panggil callback
        end
    end
    
    -- Infinite Jump keybind (Space) - DITAMBAHKAN
    if input.KeyCode == Enum.KeyCode.Space and infiniteJumpEnabled then
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end

-- Daftarkan event listener untuk input global
local globalInputConnection = UserInputService.InputBegan:Connect(handleGlobalInput)

-- ===================================================================
-- [[ KODE UNTUK FLING ]]
-- ===================================================================

if not getgenv().FPDH then
     getgenv().FPDH = workspace.FallenPartsDestroyHeight
end

local Message = function(_Title, _Text, Time)
    if WindUI and WindUI.Notify then
        WindUI:Notify({
            Title = _Title,
            Content = _Text,
            Duration = Time or 5
        })
    else
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time or 5})
    end
end

local SkidFling = function(TargetPlayer)
    local Character = player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart
    local TCharacter = TargetPlayer.Character
    local THumanoid
    local TRootPart
    local THead
    local Accessory
    local Handle

    if TCharacter:FindFirstChildOfClass("Humanoid") then
        THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    end
    if THumanoid and THumanoid.RootPart then
        TRootPart = THumanoid.RootPart
    end
    if TCharacter:FindFirstChild("Head") then
        THead = TCharacter.Head
    end
    if TCharacter:FindFirstChildOfClass("Accessory") then
        Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    end
    if Accessory and Accessory:FindFirstChild("Handle") then
        Handle = Accessory.Handle
    end

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end

        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif not THead and Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end

        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end

        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end

        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end

        workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
        BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

        if TRootPart and THead then
            if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart and not THead then
            SFBasePart(TRootPart)
        elseif not TRootPart and THead then
            SFBasePart(THead)
        elseif not TRootPart and not THead and Accessory and Handle then
            SFBasePart(Handle)
        else
            return Message("Error Occurred", "Target is missing everything", 5)
        end

        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid

        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
            Humanoid:ChangeState("GettingUp")
            table.foreach(Character:GetChildren(), function(_, x)
                if x:IsA("BasePart") then
                    x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                end
            end)
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("Error Occurred", "Random error", 5)
    end
end

-- ===================================================================
-- [[ VARIABEL UNTUK PLAYER FEATURES ]]
-- ===================================================================

-- Infinite Jump
local infiniteJumpEnabled = false
local infiniteJumpConnection

-- Noclip
local noclipEnabled = false
local noclipConnection

-- God Mode (Manual Toggle)
local godModeEnabled = false
local godModeConnection

-- ===================================================================
-- [[ FUNGSI PLAYER FEATURES ]]
-- ===================================================================

-- Infinite Jump Function
local function toggleInfiniteJump(state)
    infiniteJumpEnabled = state
    if state then
        infiniteJumpConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                if infiniteJumpEnabled and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end)
    WindUI:Notify({ Title = "Infinite Jump", Content = "Infinite Jump enabled" })
    else
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
            infiniteJumpConnection = nil
        end
        WindUI:Notify({ Title = "Infinite Jump", Content = "Infinite Jump disabled" })
    end
end

-- Noclip Function
local function toggleNoclip(state)
    noclipEnabled = state
    
    if state then
        -- Noclip ON
        if noclipConnection then -- Hentikan loop lama jika ada
            noclipConnection:Disconnect()
            noclipConnection = nil
        end

        -- Ini adalah loop yang memaksa noclip
        noclipConnection = RunService.Stepped:Connect(function()
            if noclipEnabled and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        -- Paksa SEMUA part (termasuk HumanoidRootPart) 
                        -- untuk tidak bisa ditabrak
                        part.CanCollide = false
                    end
                end
            end
        end)
        WindUI:Notify({ Title = "Noclip", Content = "Noclip enabled" })

    else
        -- Noclip OFF
        if noclipConnection then
            -- Hentikan loop yang memaksa noclip
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        -- Penting: Reset CanCollide ke kondisi normal
        if player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- Reset semua part agar bisa collide lagi
                    part.CanCollide = true 
                end
            end
            
            -- Pengecualian: HumanoidRootPart HARUS CanCollide = false
            -- agar karakter bisa berjalan normal dan tidak nyangkut di tanah
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CanCollide = false
            end
        end
        WindUI:Notify({ Title = "Noclip", Content = "Noclip disabled" })
    end
end

-- God Mode Function (Manual Toggle)
local function toggleGodMode(state)
    godModeEnabled = state
    local character = player.Character
    if not character or not character:FindFirstChild("Humanoid") then return end
    
    local humanoid = character.Humanoid
    if state then
        humanoid.Health = humanoid.MaxHealth
        if godModeConnection then godModeConnection:Disconnect() end
        godModeConnection = humanoid.HealthChanged:Connect(function()
            if godModeEnabled then
                humanoid.Health = humanoid.MaxHealth
            else
                if godModeConnection then
                    godModeConnection:Disconnect()
                    godModeConnection = nil
                end
            end
        end)
    else
        if godModeConnection then
            godModeConnection:Disconnect()
            godModeConnection = nil
        end
    end
end

-- ===================================================================
-- [[ WINDOW SETUP ]]
-- ===================================================================

WindUI.TransparencyValue = 0.0
WindUI:SetTheme("Dark")

-- */  Window  /* --
local Window = WindUI:CreateWindow({
    Title = "AsuHub",
    Author = "by @yogurutto",
	Icon = "crown",
    Folder = "AsuHub",
    
    Size = UDim2.fromOffset(640, 480),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 175,
    BackgroundImageTransparency = 0.9,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    HidePanelBackground = false,

    Background = "https://media.discordapp.net/attachments/803264561334583296/1308689432836177951/25A5D0DE-A790-4D23-92D1-9EFFDED9440A.jpg?ex=69158303&is=69143183&hm=afb765eaefb13cfabf0c8f463e7bb4504fe6aab9dbb2efcdf636c6db62a147a3&=&format=webp&width=966&height=960",
	
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "User Profile",
                Content = "User profile clicked!",
                Duration = 3
            })
        end,
    },

    KeySystem = { 
        Key = { "1234", "5678" },  
        Note = "Example Key System. With platoboost, etc.",
        URL = "https://github.com/Footagesus/WindUI",
        --    Thumbnail = {
        --        Image = "https://media.discordapp.net/attachments/803264561334583296/1308689432836177951/25A5D0DE-A790-4D23-92D1-9EFFDED9440A.jpg?ex=69158303&is=69143183&hm=afb765eaefb13cfabf0c8f463e7bb4504fe6aab9dbb2efcdf636c6db62a147a3&=&format=webp&width=966&height=960",
        --        Width = 200, -- default 200
        --    },
    --     API = {
    --         {   
    --             -- Title = "Platoboost", -- optional 
    --             -- Desc = "Click to copy.", -- optional
    --             -- Icon = "rbxassetid://", -- optional
    
    --             Type = "platoboost", -- type: platoboost, ...
    --             ServiceId = 5541, -- service id
    --             Secret = "1eda3b70-aab4-4394-82e4-4e7f507ae198", -- platoboost secret
    --         },
    --         {   
    --             -- Title = "Other service", -- optional 
    --             -- Desc = nil, -- optional
    --             -- Icon = "rbxassetid://", -- optional
    
    --             Type = "pandadevelopment", -- type: platoboost, ...
    --             ServiceId = "windui", -- service id
    --         },
    --         {   
    --             Type = "luarmor",
    --             ScriptId = "...",
    --             Discord = "https://discord.com/invite/...",
    --         },
    --         { -- Custom service 
    --             Type = "mysuperservicetogetkey",
    --             ServiceId = 42,
    --         }
    --     },
        SaveKey = true,
    },

    OpenButton = {
        Title = "Open YoruHub",
        CornerRadius = UDim.new(1,0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = true,
        
        Color = ColorSequence.new(
            Color3.fromHex("#30FF6A"), 
            Color3.fromHex("#e7ff2f")
        )
    }
})

Window:SetIconSize(32)

-- Tag untuk Ping
local PingTag = Window:Tag({
    Title = "Ping: --",
    Radius = 13,
    Color = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#FF0F7B"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#F89B29"), Transparency = 0 },
    }, {
        Rotation = 45,
    }),
})

-- Tag untuk FPS
local FpsTag = Window:Tag({
    Title = "FPS: --",
    Radius = 13,
    Color = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#FF0F7B"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#F89B29"), Transparency = 0 },
    }, {
        Rotation = 45,
    }),
})

local TimeTag = Window:Tag({
    Title = "--:--",
    Radius = 13, -- from 0 to 13
    Color = WindUI:Gradient({
        ["0"]   = { Color = Color3.fromHex("#FF0F7B"), Transparency = 0 },
        ["100"] = { Color = Color3.fromHex("#F89B29"), Transparency = 0 },
    }, {
        Rotation = 45,
    }),
})

local hue = 0

-- Tentukan offset waktu dalam detik (WIB = 7 jam)
local wib_offset_detik = 7 * 3600

-- Rainbow effect & Time 
task.spawn(function()
	while true do
		-- 1. Dapatkan waktu UTC saat ini (universal)
		local timestamp_utc = os.time()
		
		-- 2. Tambahkan offset untuk mendapatkan waktu WIB
		local timestamp_wib = timestamp_utc + wib_offset_detik
		
		-- 3. Format waktu WIB (HH:MM) menggunakan format 24 jam
		local time_string = os.date("!%H:%M", timestamp_wib) .. " WIB"

		-- 4. Hitung warna pelangi (Kecerahan RENDAH / GELAP 0.5)
		hue = (hue + 0.01) % 1
		local color1 = Color3.fromHSV(hue, 1, 0.5) 
		local color2 = Color3.fromHSV((hue + 0.1) % 1, 1, 0.5)

		-- 5. Buat objek gradien baru
		local new_gradient = WindUI:Gradient({
			["0"]   = { Color = color1, Transparency = 0 },
			["100"] = { Color = color2, Transparency = 0 },
		}, {
			Rotation = 45,
		})
		
		-- 6. Terapkan waktu dan gradien baru
		TimeTag:SetTitle(time_string)
		TimeTag:SetColor(new_gradient) -- Terapkan ke TimeTag
		FpsTag:SetColor(new_gradient)
		PingTag:SetColor(new_gradient)

		task.wait(0.06)
	end
end)

-- ===================================================================
-- [[ Update FPS/Ping Stabil ]]
-- ===================================================================
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local pingValueItem = Stats.Network.ServerStatsItem["Data Ping"]

-- Variabel untuk "throttle" (pelambatan) update UI
local updateInterval = 0.5 -- Update UI setiap 0.5 detik
local accumulatedTime = 0
local frameCounter = 0

RunService.RenderStepped:Connect(function(deltaTime)
    -- Akumulasikan waktu dan frame
    accumulatedTime = accumulatedTime + deltaTime
    frameCounter = frameCounter + 1
    
    -- Periksa apakah sudah waktunya untuk memperbarui teks UI
    if accumulatedTime >= updateInterval then
        -- Hitung FPS rata-rata selama interval
        local averageFps = math.round(frameCounter / accumulatedTime)
        
        -- Perbarui teks UI
        FpsTag:SetTitle("FPS: " .. averageFps)
        
        -- ==========================================================
        -- [[ PERUBAHAN DI SINI: Mengambil nilai Ping mentah ]]
        -- ==========================================================
        if pingValueItem then
            -- GetValue() sepertinya SUDAH dalam milidetik
            local currentPingMs = pingValueItem:GetValue()
            
            -- Format ke "XX.XX ms" menggunakan string.format
            local formattedPing = string.format("%.2f", currentPingMs)
            PingTag:SetTitle("Ping: " .. formattedPing .. " ms")
        else
            PingTag:SetTitle("Ping: N/A")
        end
        -- ==========================================================
        -- [[ AKHIR DARI PERUBAHAN ]]
        -- ==========================================================
        
        -- Reset penghitung
        accumulatedTime = 0
        frameCounter = 0
    end
end)

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Theme Changed",
        Content = "Current theme: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

WindUI:Notify({
    Title = "YoruHub",
    Content = "Script Berhasil dijalankan...",
    Duration = 5,
    Icon = "badge-check",
})

Window:OnClose(function()
    print("Window closed")
    
    if ConfigManager and configFile then
        configFile:Set("playerData", MyPlayerData)
        configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
        configFile:Save()
        print("Config auto-saved on close")
    end
end)

Window:OnDestroy(function()
    print("Window destroyed - Membersihkan semua fitur...")

    -- 1. Hentikan semua fitur toggle
    -- (Pengecekan 'if ... then' penting agar tidak error jika fungsi tidak ada)
    
    -- Player Features
    if toggleFly then toggleFly(false) end
    if toggleFreecam then toggleFreecam(false) end -- Akan memanggil stop internal
    if toggleInfiniteJump then toggleInfiniteJump(false) end
    if toggleNoclip then toggleNoclip(false) end
    if toggleGodMode then toggleGodMode(false) end
    
    -- Visual Features
    if toggleESP then toggleESP(false) end
    
    -- Teleport Features
    if toggleClickTeleport then toggleClickTeleport(false) end

    -- 2. Hentikan loop kustom (Rainbow Tag)
    timeTagActive = false

    -- 3. Disconnect event global (Keybinds)
    if globalInputConnection then
        globalInputConnection:Disconnect()
        globalInputConnection = nil
        print("Global keybinds disconnected.")
    end

    -- 4. Disconnect event animasi (jika ada)
    if animCharacterAddedConnection then
        animCharacterAddedConnection:Disconnect()
        animCharacterAddedConnection = nil
        print("Animation respawn event disconnected.")
    end

    -- 5. Hapus sisa-sisa GUI (ESP Holder)
    if espHolder and espHolder.Parent then
        espHolder:Destroy()
        print("ESP Holder destroyed.")
    end
    
    -- 6. Reset hal-hal yang mungkin diubah
    -- (stopFly dan stopESP sudah menangani ini, tapi untuk keamanan)
    if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    
    -- Reset kamera jika freecam gagal
    pcall(function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        workspace.CurrentCamera.CameraSubject = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    end)

    print("AsuHub cleanup complete.")
end)

Window:OnOpen(function()
    print("Window opened")
end)

-- ===================================================================
-- [[ TAB 1: INFORMATION ]]
-- ===================================================================

Window:Divider()

local InfoTab = Window:Tab({
    Title = "Information",
    Icon = "info",
})

Window:Divider()

-- About AsuHub
InfoTab:Section({
    Title = "Tentang AsuHub",
})

InfoTab:Paragraph({
    Title = "Selamat Datang di AsuHub!",
    Desc = "Skrip all-in-one untuk Member Maen Asu. Beragam fitur-fitur terbaik yang dibuat secara mandiri. Selemat Menikmati Temanku!\n\n⚠️ Jika ada kendala Laporkan langsung ke Discord dan Tag @Yogurutto",
})

-- Discord Server
InfoTab:Section({
    Title = "Server Discord",
})

InfoTab:Paragraph({
    Title = "Gabung Discord",
    Desc = "Bergabunglah dengan komunitas kami untuk update dan support.",
    Buttons = {
        {
            Title = "Salin Link Discord",
            Icon = "link",
            Callback = function()
                setclipboard("https://discord.gg/")
                WindUI:Notify({Title = "Discord", Content = "Link disalin!"})
            end
        }
    }
})

-- Changelog
InfoTab:Section({
    Title = "Changelog",
})

InfoTab:Paragraph({
    Title = "📢 Versi 1.1 (Diperbaiki)",
    Desc = [[
• Memperbaiki fitur player yang error
• Memperbarui kontrol gerakan (Fly, Freecam, dll)
• Menambahkan fitur ESP untuk player
• Menambahkan konfigurasi save/load sistem
• Menambahkan fitur paket animasi (R15)
• Memperbaiki Keybinds dan Search Player
• Menambahkan fitur copy avatar (popmall/catalog)]]
})

-- ===================================================================
-- [[ TAB 2: PLAYER ]]
-- ===================================================================

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user",
})

-- Controls Section yang lebih rapi
PlayerTab:Section({
    Title = "Quick Controls",
})

PlayerTab:Paragraph({
    Title = "Keyboard Shortcuts",
    Desc = [[
• Fly: Press V
• Freecam: Hold Shift + P  
• Movement: W/A/S/D/Q/E ]]
})

-- Movement Section
PlayerTab:Section({ 
    Title = "Movement" 
})

local defaultWalkspeed = 16
local defaultJumpPower = 50
local defaultGravity = Workspace.Gravity
local defaultFlySpeed = 50 

local walkspeedSlider = PlayerTab:Slider({
    Title = "WalkSpeed",
    Step = 1,
    Value = { Min = 1, Max = 500, Default = defaultWalkspeed },
    Callback = function(value)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end
})

local jumpSlider = PlayerTab:Slider({
    Title = "Jump Power",
    Step = 1,
    Value = { Min = 1, Max = 500, Default = defaultJumpPower },
    Callback = function(value)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end
})

local gravitySlider = PlayerTab:Slider({
    Title = "Gravity",
    Step = 1,
    Value = { Min = 1, Max = 500, Default = defaultGravity },
    Callback = function(value)
        Workspace.Gravity = value
    end
})

-- SAYA TAMBAHKAN: Slider untuk Fly Speed
local flySpeedSlider = PlayerTab:Slider({
    Title = "Fly Speed",
    Step = 1,
    Value = { Min = 50, Max = 500, Default = defaultFlySpeed },
    Callback = function(value)
        flyBaseSpeed = value -- Memperbarui variabel global flyBaseSpeed
    end
})

PlayerTab:Button({
    Title = "Reset to Default",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = defaultWalkspeed
            player.Character.Humanoid.JumpPower = defaultJumpPower
        end
        Workspace.Gravity = defaultGravity
        flyBaseSpeed = defaultFlySpeed -- SAYA TAMBAHKAN: Reset logika fly speed
        
        walkspeedSlider:Set(defaultWalkspeed)
        jumpSlider:Set(defaultJumpPower)
        gravitySlider:Set(defaultGravity)
        flySpeedSlider:Set(defaultFlySpeed) -- SAYA TAMBAHKAN: Reset UI slider fly speed
        
        -- SAYA UBAH: Notifikasi diperbarui
        WindUI:Notify({ Title = "Reset", Content = "Walkspeed, Jump, Gravity, dan Fly Speed direset" })
    end
})

-- Modes Section
PlayerTab:Section({
    Title = "Modes",
})

PlayerTab:Toggle({
    Title = "Infinite Jump",
    Desc = "Press SPACE to jump mid-air",
    Default = false,
    Callback = function(state)
        toggleInfiniteJump(state)
    end
})

-- Fly Toggle
flyToggle = PlayerTab:Toggle({
    Title = "Fly",
    Desc = "Toggle flying mode | Press V to toggle",
    Default = false,
    Callback = function(state)
        toggleFly(state)
    end
})

PlayerTab:Toggle({
    Title = "Noclip",
    Default = false,
    Callback = function(state)
        toggleNoclip(state)
    end
})

PlayerTab:Toggle({
    Title = "God Mode",
    Default = false,
    Callback = function(state)
        toggleGodMode(state)
    end
})

-- Freecam Toggle  
freecamToggle = PlayerTab:Toggle({
    Title = "FreeCam", 
    Desc = "Toggle free camera mode | Hold Shift + P to toggle",
    Default = false,
    Callback = function(state)
        toggleFreecam(state)
    end
})

-- Character Section
PlayerTab:Section({
    Title = "Character",
})

PlayerTab:Toggle({
    Title = "Player ESP",
    Default = false,
    Callback = function(state)
        toggleESP(state)
    end
})

PlayerTab:Button({
    Title = "Reset Character",
    Icon = "refresh-cw",
    Callback = function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
    end
})

-- ===================================================================
-- [[ TAB 3: TELEPORT ]]
-- ===================================================================

local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "navigation",
})

-- SAYA TAMBAHKAN: Section untuk Click Teleport
TeleportTab:Section({
    Title = "World Teleport",
})

TeleportTab:Toggle({
    Title = "Click Teleport",
    Desc = "Hold Left Ctrl + Left Click (cursor) to teleport",
    Default = false,
    Callback = function(state)
        toggleClickTeleport(state) -- Panggil fungsi toggle yang baru
    end
})

local function getPlayerList()
    local playerList = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then 
            table.insert(playerList, {
                Title = p.Name,
                Icon = "user",
                PlayerObject = p
            })
        end
    end
    table.sort(playerList, function(a, b) return a.Title < b.Title end)
    return playerList
end

-- Teleport Player Section
TeleportTab:Section({
    Title = "Teleport Player",
})

local tpSelectedPlayer = nil
local tpPlayerDropdown = nil
local tpSearchInput = nil
local tpIsRefreshing = false
local spectateToggle = nil
local isSpectating = false

tpSearchInput = TeleportTab:Input({
    Title = "Search Player",
    Icon = "search",
    Placeholder = "Search...",
    Callback = function(searchText)
        local fullPlayerList = getPlayerList()
        local filteredList = {}
        local searchTextLower = string.lower(searchText)
        
        for _, playerInfo in ipairs(fullPlayerList) do
            local playerNameLower = string.lower(playerInfo.Title)
            if string.find(playerNameLower, searchTextLower) then
                table.insert(filteredList, playerInfo)
            end
        end
        
        tpIsRefreshing = true
        tpPlayerDropdown:Refresh(filteredList)
        tpSelectedPlayer = nil
        tpIsRefreshing = false
    end
})

tpPlayerDropdown = TeleportTab:Dropdown({
    Title = "Select Player",
    Values = getPlayerList(),
    Callback = function(option)
        if option.PlayerObject and option.PlayerObject.Parent then
            tpSelectedPlayer = option.PlayerObject
            if not tpIsRefreshing then
                WindUI:Notify({ Title = "Player", Content = "Selected " .. option.Title })
            end
            
            if isSpectating then
                local camera = workspace.CurrentCamera
                if tpSelectedPlayer and tpSelectedPlayer.Character and tpSelectedPlayer.Character:FindFirstChild("Humanoid") then
                    camera.CameraSubject = tpSelectedPlayer.Character.Humanoid
                end
            end
        end
    end
})

TeleportTab:Button({
    Title = "Refresh Player List",
    Icon = "refresh-cw",
    Callback = function()
        tpIsRefreshing = true
        tpPlayerDropdown:Refresh(getPlayerList())
        if tpSearchInput then tpSearchInput:Set("", true) end
        tpSelectedPlayer = nil
        WindUI:Notify({ Title = "Player", Content = "List refreshed" })
        tpIsRefreshing = false
    end
})

TeleportTab:Button({
    Title = "Teleport to Player",
    Icon = "navigation",
    Callback = function()
        if tpSelectedPlayer and tpSelectedPlayer.Character then tpSelectedPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetPos = tpSelectedPlayer.Character.HumanoidRootPart.CFrame
            teleportCharacter(player.Character, targetPos.Position + Vector3.new(0, 3, 0))
            WindUI:Notify({ Title = "Teleport", Content = "Teleported to " .. tpSelectedPlayer.Name })
        else
            WindUI:Notify({ Title = "Error", Content = "Cannot teleport to that player" })
        end
    end
})

spectateToggle = TeleportTab:Toggle({
    Title = "Spectate Player",
    Icon = "eye",
    Default = false,
    Callback = function(state)
        isSpectating = state
        local camera = workspace.CurrentCamera
        
        if state then
            if tpSelectedPlayer and tpSelectedPlayer.Character and tpSelectedPlayer.Character:FindFirstChild("Humanoid") then
                camera.CameraSubject = tpSelectedPlayer.Character.Humanoid
                camera.CameraType = Enum.CameraType.Track
                WindUI:Notify({ Title = "Spectate", Content = "Spectating " .. tpSelectedPlayer.Name })
            else
                WindUI:Notify({ Title = "Error", Content = "Select a valid player first" })
                isSpectating = false
                if spectateToggle then spectateToggle:Set(false, true) end
            end
        else
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                camera.CameraSubject = player.Character.Humanoid
                camera.CameraType = Enum.CameraType.Custom
            end
            WindUI:Notify({ Title = "Spectate", Content = "Stopped spectating" })
        end
    end
})

-- ===================================================================
-- [[ TAB 4: FITUR TROLLING ]]
-- ===================================================================

local TrollingTab = Window:Tab({
    Title = "Trolling",
    Icon = "skull",
})

-- Trolling Section
TrollingTab:Section({
    Title = "Trolling",
})

local selectedPlayer = nil
local playerDropdown = nil
local searchInput = nil
local isRefreshingDropdown = false
local flingDebounce = false

searchInput = TrollingTab:Input({
    Title = "Search Player",
    Icon = "search",
    Placeholder = "Search...",
    Callback = function(searchText)
        local fullPlayerList = getPlayerList()
        local filteredList = {}
        local searchTextLower = string.lower(searchText)
        
        for _, playerInfo in ipairs(fullPlayerList) do
            local playerNameLower = string.lower(playerInfo.Title)
            if string.find(playerNameLower, searchTextLower) then
                table.insert(filteredList, playerInfo)
            end
        end
        
        isRefreshingDropdown = true
        playerDropdown:Refresh(filteredList)
        selectedPlayer = nil
        isRefreshingDropdown = false
    end
})

playerDropdown = TrollingTab:Dropdown({
    Title = "Select Player",
    Values = getPlayerList(),
    Callback = function(option)
        if option.PlayerObject and option.PlayerObject.Parent then
            selectedPlayer = option.PlayerObject
            if not isRefreshingDropdown then
                WindUI:Notify({ Title = "Player", Content = "Selected " .. option.Title })
            end
        end
    end
})

TrollingTab:Button({
    Title = "Refresh Player List",
    Icon = "refresh-cw",
    Callback = function()
        isRefreshingDropdown = true
        playerDropdown:Refresh(getPlayerList())
        if searchInput then searchInput:Set("", true) end
        selectedPlayer = nil
        WindUI:Notify({ Title = "Player", Content = "List refreshed" })
        isRefreshingDropdown = false
    end
})

TrollingTab:Button({
    Title = "Fling",
    Icon = "zap",
    Callback = function()
        if flingDebounce then
            WindUI:Notify({ Title = "Fling", Content = "Please wait..." })
            return
        end
        
        if not selectedPlayer or not selectedPlayer.Character then
            WindUI:Notify({ Title = "Error", Content = "Select a valid player first!" })
            return
        end
        
        flingDebounce = true
        WindUI:Notify({ Title = "Fling", Content = "Flinging " .. selectedPlayer.Name })
        
        task.spawn(function()
            pcall(function()
                SkidFling(selectedPlayer)
            end)
            task.wait(1)
            flingDebounce = false
        end)
    end
})

-- ===================================================================
-- [[ TAB 7: SETTING ]]
-- ===================================================================

local SettingTab = Window:Tab({
    Title = "Setting",
    Icon = "settings",
})

Window:Divider()

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local canchangetheme = true
local canchangedropdown = true

-- Theme Section
SettingTab:Section({
    Title = "Theme",
})

SettingTab:Dropdown({
    Title = "UI Theme",
    Values = themes,
    SearchBarEnabled = true,
    Value = "Dark",
    Callback = function(theme)
        canchangedropdown = false
        WindUI:SetTheme(theme)
        WindUI:Notify({ Title = "Theme Applied", Content = theme, Icon = "palette", Duration = 2 })
        canchangedropdown = true
    end
})

local transparencySlider = SettingTab:Slider({
    Title = "Image Transparency",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.9,
    },
    Step = 0.1,
    Callback = function(value)
        local numValue = tonumber(value)
        
        -- DIPERBAIKI (Hipotesis Baru):
        -- Memanggil metode 'Set' alih-alih mengatur properti secara langsung.
        Window:SetBackgroundImageTransparency(numValue)
        
        -- Logika ini seharusnya sudah benar dari sebelumnya:
        -- Jika value adalah 1 (transparan penuh), sembunyikan gambar (false).
        -- Jika value kurang dari 1, tampilkan gambar (true).
        Window:ToggleBackgroundImage(numValue < 1)
    end
})

local bgtransparencySlider = SettingTab:Slider({
    Title = "Background Transparency",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.0,
    },
    Step = 0.1,
    Callback = function(value)
        WindUI.TransparencyValue = tonumber(value)
        Window:ToggleTransparency(tonumber(value) > 0)
    end
})

local ThemeToggle = SettingTab:Toggle({
    Title = "Enable Dark Mode",
    Desc = "Use dark color scheme",
    Value = true,
    Callback = function(state)
        if canchangetheme then
            WindUI:SetTheme(state and "Dark" or "Light")
        end
        if canchangedropdown then
            themeDropdown:Select(state and "Dark" or "Light")
        end
    end
})

WindUI:OnThemeChange(function(theme)
    canchangetheme = false
    ThemeToggle:Set(theme == "Dark")
    canchangetheme = true
end)

SettingTab:Keybind({
    Title = "Hide GUI Keybind",
    Value = "G",
    Callback = function(key)
        if Enum.KeyCode[key] then
            Window:SetToggleKey(Enum.KeyCode[key])
            WindUI:Notify({ Title = "Keybind", Content = "GUI toggle key set to " .. key })
        end
    end
})

-- Config Section
SettingTab:Section({
    Title = "Config",
})

local ConfigManager = Window.ConfigManager
local ConfigName = "default"

local ConfigNameInput = SettingTab:Input({
    Title = "Config Name",
    Icon = "file-cog",
    Value = ConfigName,
    Callback = function(value)
        ConfigName = value
    end
})

local AllConfigs = ConfigManager:AllConfigs()
local DefaultValue = table.find(AllConfigs, ConfigName) and ConfigName or nil

local ConfigDropdown = SettingTab:Dropdown({
    Title = "All Configs",
    Values = AllConfigs,
    Value = DefaultValue,
    Callback = function(value)
        ConfigName = value
        ConfigNameInput:Set(value)
    end
})

SettingTab:Button({
    Title = "Refresh Config List",
    Icon = "refresh-cw",
    Callback = function()
        local newConfigs = ConfigManager:AllConfigs()
        ConfigDropdown:Refresh(newConfigs)
        WindUI:Notify({ Title = "Config", Content = "Config list refreshed" })
    end
})

SettingTab:Space()

SettingTab:Button({
    Title = "Save Config",
    Icon = "save",
    Callback = function()
        Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
        if Window.CurrentConfig:Save() then
            WindUI:Notify({
                Title = "Config Saved",
                Content = "Config '" .. ConfigName .. "' saved",
            })
            local newConfigs = ConfigManager:AllConfigs()
            ConfigDropdown:Refresh(newConfigs)
            ConfigDropdown:Set(ConfigName)
        end
    end
})

SettingTab:Button({
    Title = "Load Config",
    Icon = "folder-open",
    Callback = function()
        Window.CurrentConfig = ConfigManager:CreateConfig(ConfigName)
        if Window.CurrentConfig:Load() then
            WindUI:Notify({
                Title = "Config Loaded",
                Content = "Config '" .. ConfigName .. "' loaded",
            })
        end
    end
})

SettingTab:Button({
    Title = "Delete Config",
    Icon = "trash-2",
    Color = Color3.fromHex("#ff4830"),
    Callback = function()
        if ConfigManager:DeleteConfig(ConfigName) then
            WindUI:Notify({
                Title = "Config Deleted",
                Content = "Config '" .. ConfigName .. "' deleted",
            })
            local newConfigs = ConfigManager:AllConfigs()
            ConfigDropdown:Refresh(newConfigs)
            ConfigName = "default"
            ConfigNameInput:Set(ConfigName)
            ConfigDropdown:Set(nil)
        else
            WindUI:Notify({
                Title = "Error",
                Content = "Cannot delete config '" .. ConfigName .. "'",
            })
        end
    end
})
