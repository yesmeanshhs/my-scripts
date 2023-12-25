-- Fly Library by yesmeanshhs
-- Mobile PC Support

local W = game:GetService"Workspace"
local C = W.CurrentCamera
local UIS =
game:GetService"UserInputService"
local RS = game:GetService"RunService"
local P = game:GetService"Players"
local LP = P.LocalPlayer

local VectorHuge = Vector3.new(math.huge,math.huge,math.huge)
local VectorZero = Vector3.new(0,0,0)

local Flying = false
local Speed = 30

local Connections = {}

function RandomString()
local Result = game:GetService"HttpService":GenerateGUID()
return tostring(Result)
end

local VName = RandomString()
local GName = RandomString()

function CreateVelocity(RootSelected,Type)
if Type == "1" then
if RootSelected then
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.Name = VName
BodyVelocity.MaxForce = VectorZero
BodyVelocity.Velocity = VectorZero
BodyVelocity.Parent = RootSelected
end
elseif Type == "2" then
if RootSelected then
local BodyGyro = Instance.new("BodyGyro")
BodyGyro.Name = GName
BodyGyro.MaxTorque = VectorZero
BodyGyro.P = 1000
BodyGyro.D = 50
BodyGyro.Parent = RootSelected
end
end
end

function GetRoot()
if LP and LP.Character then
local Root = LP.Character:FindFirstChild("HumanoidRootPart") or LP.Character:FindFirstChild("Torso") or LP.Character:FindFirstChild("UpperTorso")
return Root
end
end

function Toggle(Bool)
Flying = Bool
end

function DestroyLibrary()
for _, x in pairs(Connections) do
x:Disconnect()
end
Flying = false
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true):Destroy()
end
if LP and LP.Character and LP.Character:FindFirstChild(GName,true) then
LP.Character:FindFirstChild(GName,true):Destroy()
end
if LP and LP.Character and LP.Character:FindFirstChildOfClass"Humanoid" and LP.Character:FindFirstChildOfClass"Humanoid".PlatformStand == true then
LP.Character:FindFirstChildOfClass"Humanoid".PlatformStand = false
end
end

Connections["VelocityMonitor"] = RS.Heartbeat:Connect(function()
if Flying == false then
if LP and LP.Character and LP.Character:FindFirstChildOfClass"Humanoid" then
LP.Character:FindFirstChildOfClass"Humanoid".PlatformStand = false
end
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).MaxForce = VectorZero
end
if LP and LP.Character and LP.Character:FindFirstChild(GName,true) then
LP.Character:FindFirstChild(GName,true).MaxTorque = VectorZero
end
end
if Flying == true then
if LP and LP.Character and LP.Character:FindFirstChildOfClass"Humanoid" then
LP.Character:FindFirstChildOfClass"Humanoid".PlatformStand = true
end
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).MaxForce = VectorHuge
end
if LP and LP.Character and LP.Character:FindFirstChild(GName,true) then
LP.Character:FindFirstChild(GName,true).MaxTorque = VectorHuge
end
end

if Flying == true then
if LP and LP.Character and LP.Character:FindFirstChild(GName,true) then
LP.Character:FindFirstChild(GName,true).CFrame = C.CoordinateFrame
end
if LP and LP.Character and not LP.Character:FindFirstChild(VName,true) then
CreateVelocity(GetRoot(),"1")
end
if LP and LP.Character and not LP.Character:FindFirstChild(GName,true) then
CreateVelocity(GetRoot(),"2")
end
end
end)

function PFly()
repeat task.wait() until LP and LP.Character and GetRoot()
local KeyState = {W = false, A = false, S = false, D = false}
local KeySpeed = {W = 0, A = 0, S = 0, D = 0}
local Root = GetRoot()
CreateVelocity(Root,"1")
CreateVelocity(Root,"2")
if LP and LP.Character and LP.Character:FindFirstChildOfClass"Humanoid" then
LP.Character:FindFirstChildOfClass"Humanoid".PlatformStand = true
end
Connections["PCBegan"] = UIS.InputBegan:Connect(function(Input,Chat)
if Chat then return end
for _, x in pairs(KeyState) do
if Input.KeyCode == Enum.KeyCode[_] then
KeyState[_] = true
KeySpeed[_] = Speed
end
end
end)
Connections["PCEnded"] = UIS.InputEnded:Connect(function(Input,Chat)
if Chat then return end
for _, x in pairs(KeyState) do
if Input.KeyCode == Enum.KeyCode[_] then
KeyState[_] = false
KeySpeed[_] = 0
end
end
end)
Connections["PCFly"] = RS.PostSimulation:Connect(function()
if Flying == true then
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = Vector3.new()
end

if KeyState.W  then
if KeySpeed.W ~= 0 then
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = C.CoordinateFrame.LookVector * KeySpeed.W
end
else
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = VectorZero
end
end
end
if KeyState.A then
if KeySpeed.A ~= 0 then
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = C.CoordinateFrame.RightVector * -KeySpeed.A
end
else
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = VectorZero
end
end
end
if KeyState.S then
if KeySpeed.S ~= 0 then
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = C.CoordinateFrame.LookVector * -KeySpeed.S
end
else
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = VectorZero
end
end
end
if KeyState.D then
if KeySpeed.D ~= 0 then
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = C.CoordinateFrame.RightVector * KeySpeed.D
end
else
if LP and LP.Character and LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = VectorZero
end
end
end
end
end)
Toggle(true)
end

function MFly()
repeat task.wait() until LP and LP.Character and GetRoot()
local CM = require(LP:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))

local Root = GetRoot()
CreateVelocity(GetRoot(),"1")
CreateVelocity(GetRoot(),"2")

Connections["MobileBegin"] = RS.RenderStepped:Connect(function()
if Flying then
if LP and LP.Character then
if LP.Character:FindFirstChild(GName,true) then
Lp.Character:FindFirstChild(GName,true).CFrame = C.CoordinateFrame
end
local Dir = CM:GetMoveVector()
if LP.Character:FindFirstChild(VName,true) then
LP.Character:FindFirstChild(VName,true).Velocity = Vector3.new()
if direction.X > 0 then
LP.Character:FindFirstChild(VName,true).Velocity = LP.Character:FindFirstChild(VName,true).Velocity + C.CFrame.RightVector*(direction.X*Speed)
end
if direction.X < 0 then
LP.Character:FindFirstChild(VName,true).Velocity = LP.Character:FindFirstChild(VName,true).Velocity + C.CFrame.RightVector*(direction.X*Speed)
end
if direction.Z > 0 then
LP.Character:FindFirstChild(VName,true).Velocity = LP.Character:FindFirstChild(VName,true).Velocity - C.CFrame.LookVector*(direction.Z*Speed)
end
if direction.Z < 0 then
LP.Character:FindFirstChild(VName,true).Velocity = LP.Character:FindFirstChild(VName,true).Velocity - C.CFrame.LookVector*(direction.Z*Speed)
end
end
end
end
end)
Toggle(true)
end
