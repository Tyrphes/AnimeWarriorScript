
local UI_Library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Player = game.Players.LocalPlayer

UI_Library:MakeNotification({
	Name = "Asha HUB",
	Content = "Welcome to Asha HUB",
	Image = "rbxassetid://4483345998",
	Time = 5
})
local workspace = workspace
local huge = math.huge
local task = task

local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")
local Services = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.4.7"):WaitForChild("knit"):WaitForChild("Services")

RemoteEvent:FireServer({{"!", "EnemyRender", 500}})

local HumanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")

local Enemies = {"Closest Enemy"}





local Window = UI_Library:MakeWindow({Name = "Asha HUB", HidePremium = false, SaveConfig = false, IntroEnabled = true, IntroText = "Tyrphes Presents"})


local Main = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483362458",
    PreniumOnly = false
})
local Section = Main:AddSection({Name = "Attacking"})
for i,v in pairs(workspace.ClientEnemies:GetChildren()) do
	local HealthBar = v:FindFirstChild("EnemyHealthBar", true)
	if HealthBar then
		local EnemyName = HealthBar.Title.Text
		if not table.find(Enemies, EnemyName) then
			table.insert(Enemies, EnemyName)
			
		end
	end
end
local EnemyDropdown = Main:AddDropdown({
	Name = "👾 Enemy",
    Default = "Closest Enemy",
	Options = Enemies,
	Flag = "Enemy",
	Callback = function()end,
})
function EnemyTable(v)
	local HealthBar = v:FindFirstChild("EnemyHealthBar", true)
    
	if HealthBar then
		local EnemyName = HealthBar.Title.Text
		if not table.find(Enemies, EnemyName) then
			table.insert(Enemies, EnemyName)
            
			
		end
	end
end
game.Workspace.ClientEnemies.ChildAdded:Connect(function(v)
    Enemies = {"Closest Enemy"}
    for i,v3 in pairs(workspace.ClientEnemies:GetChildren()) do
        EnemyTable(v3)
    end
    EnemyDropdown:Refresh(Enemies,true)
end)
game.Workspace.ClientEnemies.ChildRemoved:Connect(function(v)
    Enemies = {"Closest Enemy"}
    for i,v3 in pairs(workspace.ClientEnemies:GetChildren()) do
        EnemyTable(v3)
    end
    EnemyDropdown:Refresh(Enemies,true)
end)

Main:AddToggle({
	Name = "🗡 Auto Attack",
	Default = false,
	Flag = "Attack",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if UI_Library.Flags["Attack"].Value then
			local Number = huge
			local Enemy

			if UI_Library.Flags["Enemy"].Value ~= "Closest Enemy" then
				for i,v in pairs(workspace.ClientEnemies:GetChildren()) do
					if v and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("EnemyHealthBar") and v.HumanoidRootPart.EnemyHealthBar.Title.Text:match(UI_Library.Flags["Enemy"].Value) then
						local Magnitude = (HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
						if Magnitude < Number then
							Number = Magnitude
							Enemy = v
						end
					end
				end
			end

			if not Enemy then
				for i,v in pairs(workspace.ClientEnemies:GetChildren()) do
					if v and v:FindFirstChild("HumanoidRootPart") then
						local Magnitude = (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
						if Magnitude < Number then
							Number = Magnitude
							Enemy = v
						end
					end
				end
			end

			if Enemy then
				if UI_Library.Flags["Teleport"].Value then
					HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame
				end
				
				RemoteEvent:FireServer({{"&", Enemy.Name, true}})

				repeat task.wait() until not Enemy or not Enemy.Parent or not UI_Library.Flags["Attack"].Value
			end
		end
	end
end)

Main:AddToggle({
	Name = "💨 Teleport to Enemy",
	Default = false,
	Flag = "Teleport",
	Callback = function()end,
})
local Section = Main:AddSection({Name = "Farming"})

Main:AddToggle({
	Name = "🖱 Auto Click",
	Default = false,
	Flag = "Click",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if UI_Library.Flags["Click"].Value then
			RemoteEvent:FireServer({{"'"}})
		end
	end
end)

Main:AddToggle({
	Name = "💴 Auto Collect",
	Default = false,
	Flag = "Collect",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if UI_Library.Flags["Collect"].Value then
			for i,v in pairs(workspace.Drops:GetChildren()) do
				v.CFrame = HumanoidRootPart.CFrame
			end
		end
	end
end)

Main:AddToggle({
	Name = "📜 Auto Quest",
	Default = false,
	Flag = "Quest",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if UI_Library.Flags["Quest"].Value then
			for i,v in pairs(workspace.Maps:GetChildren()) do
				RemoteEvent:FireServer({{"@", v.Components:FindFirstChild("NPC", true).Parent.Name}})
			end
		end
	end
end)

local Section = Main:AddSection({Name = "Units"})

Main:AddToggle({
	Name = "🐣 Auto Open",
	Default = false,
	Flag = "Open",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if UI_Library.Flags["Open"].Value then
			local Number = huge
			local Egg

			for i,v in pairs(workspace.Maps:GetChildren()) do
				for i,v in pairs(v.Eggs:GetChildren()) do
					if v.PrimaryPart and v.Egg:FindFirstChild("PriceBillboard") and v.Egg.PriceBillboard.Yen.Icon.Image ~= "rbxassetid://9126788621" then
						local Magnitude = (HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude
						if Magnitude < Number then
							Number = Magnitude
							Egg = v
						end
					end
				end
			end

			if Egg then
				local EggCFrame = Egg.PrimaryPart.CFrame

				if (HumanoidRootPart.Position - EggCFrame.Position).Magnitude > 4 then
					HumanoidRootPart.CFrame = EggCFrame + EggCFrame.LookVector * 3
				end

				Services.EggService.RF.Open:InvokeServer(Egg.Name, (Egg:FindFirstChild("Bottom") and 2 or false))
			end
		end
	end
end)
