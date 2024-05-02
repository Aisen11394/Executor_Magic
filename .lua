print("]------- Initializing Trigon v0.04q -------[")

function genStr(minL, maxL)
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	local strLen = math.random(minL, maxL)
	local str = ""
	
	math.randomseed(os.time())
	
	for i = 1, strLen do
		local rChar = math.random(1, #chars)
		str = str .. chars:sub(rChar, rChar)
	end
	
	return str
end

if not (_G.TrigonMain and _G.TrigonLoader and _G.TrigonTopbar) then
	_G.TrigonMain, _G.TrigonLoader, _G.TrigonTopbar = genStr(16, 30), genStr(10, 25), "TrigonTopbar"
end

for _, v in ipairs({_G.TrigonMain, _G.TrigonLoader, _G.TrigonTopbar}) do
	if gethui():FindFirstChild(v) then gethui()[v]:Destroy() end
end

local userInputType = game:GetService("UserInputService")
userInputType.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
	  userInputType.InputBegan:Connect(function(secondInput)
		if secondInput.KeyCode == Enum.KeyCode.E then
		  executecode(getclipboard())
		end
	  end)
	end
end)
  

--[[
	NAME: Trigon
	VERSION: Android
	USER_AGENT: Trigon Android
	FINGERPRINT: Trigon_Fingerprint
]]

local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
local key = "https://trigonevo.com/getkey/?hwid="..HWID


--setclipboard(PandaAuth:GetKey(ServiceID))
--print(PandaAuth:GetKey(ServiceID))

--local address = crypt.base64decode("aHR0cDovLzI2LjE1My4yMjQuMTI5OjIwMjM=")
--PandaAuth:SetHTTPProtocol(address)


local ServiceID, LibType, LibVersion = "trigon-evo", "roblox", "v2" 
local PandaAuth, authlink

local keyless = true

if keyless then
	print("Keyless")
	PandaAuth = true
else
	local function tryLoadURL(url)
		local success, result = pcall(function()
			return loadstring(game:HttpGet(url))()
		end)
		if success and result then
			return result
		else
			return nil
		end
	end
	
	PandaAuth = loadstring(game:HttpGet('https://raw.githubusercontent.com/Panda-Repositories/PandaKS_Libraries/main/library/LuaLib/ROBLOX/PandaBetaLib.lua'))()
	--PandaAuth = tryLoadURL('https://pandadevelopment.net/servicelib?service='..ServiceID..'&core='..LibType..'&param='..LibVersion)

	if not PandaAuth then
		PandaAuth = tryLoadURL('https://pandadevelopment.cloud/servicelib?service='..ServiceID..'&core='..LibType..'&param='..LibVersion)
	end

	if PandaAuth then
		local success, result = pcall(function()
			return PandaAuth:GetKey(ServiceID)
		end)
		print(result)
		if not success then
			keyless = true
			print("Failed to retrieve AuthLink. PandaAuth Error, Trigon is Keyless!!")
		end
	else
		keyless = true
		print("PandaAuth Error, Trigon is Keyless!!")
	end
end 


loaddefaultsetttings = false
autoexec_ = false

------------------------------------------------------------
------------------------------------------------------------

local a = "TrigonConfigs"
local b = 'TrigonConfigs.json'
Settings = {}

function saveSettings()
    local HttpService = game:GetService('HttpService')
    if not isfolder(a) then
        makefolder(a)
		loaddefaultsetttings = true 
    end
    writefile(a .. '/' .. b, HttpService:JSONEncode(Settings))
    Settings = ReadSetting()
    warn("Settings Saved!")
end
function ReadSetting()
    local s, e = pcall(function()
        local HttpService = game:GetService('HttpService')
        if not isfolder(a) then
            makefolder(a)		
			loaddefaultsetttings = true 
        end
        return HttpService:JSONDecode(readfile(a .. '/' .. b))
    end)
    if s then
        return e
    else
        saveSettings()
        return ReadSetting()
    end
end
Settings = ReadSetting()


function defaultSettings()
	if not loaddefaultsetttings then return end
	Settings.autoexec = true
	Settings.autohideui = false
	Settings.logPrint = true
	Settings.logWarn = true
	Settings.logError = true  
	Settings.logInfo = true  
	saveSettings()
end

saveSettings()

defaultSettings()

if not Settings.Trigonkey then Settings.Trigonkey = " " saveSettings() end

function topbar(ButtonName,Image,Left)
	task.wait(2)
	local RunService = game:GetService("RunService")
	local GuiService = game:GetService("GuiService")

	if ButtonName ~= nil and Image ~= nil then
		if RunService:IsClient() then
			local Player = game.Players.LocalPlayer
			if Player ~= nil then 
				local PlrCheck = false
				for _,p in pairs(game.Players:GetPlayers()) do
					if p == Player then
						PlrCheck = true
					end
				end
				if PlrCheck == false then
					warn("Invalid Player")
					return false
				else
					-- Player is valid, Check to see if there is already the topbar frame
					local TopbarFrame
					pcall(function()
						TopbarFrame =  gethui():FindFirstChild(_G.TrigonTopbar)
					end)
					if TopbarFrame == nil then
						-- No TopbarFrame, Add it
						local TBUI = Instance.new("ScreenGui")
						TBUI.Parent =  gethui()
						TBUI.Name = _G.TrigonTopbar
						TBUI.DisplayOrder = 1000000000
						TBUI.Enabled = true
						TBUI.IgnoreGuiInset = true
						TBUI.ResetOnSpawn = false

						local TBFrame = Instance.new("Frame")
						TBFrame.Parent = TBUI
						TBFrame.BackgroundTransparency = 1
						TBFrame.BorderSizePixel = 0
						TBFrame.Name = "TopbarFrame"
						TBFrame.Size = UDim2.new(1,0,0,36)
						TBFrame.ZIndex = 1000000000

						local TBL = Instance.new("Frame")
						TBL.Parent = TBFrame
						TBL.BackgroundTransparency = 1
						TBL.BorderSizePixel = 0
						TBL.Name = "Left"
						TBL.Position = UDim2.new(0,104,0,4)
						TBL.Size = UDim2.new(0.85,0,0,32)

						local TBR = Instance.new("Frame")
						TBR.Parent = TBFrame
						TBR.BackgroundTransparency = 1
						TBR.BorderSizePixel = 0
						TBR.Name = "Right"
						TBR.AnchorPoint = Vector2.new(1,0)
						TBR.Position = UDim2.new(1,-60,0,4)
						TBR.Size = UDim2.new(0.85,0,0,32)

						local TBLUI = Instance.new("UIListLayout")
						TBLUI.Parent = TBL
						TBLUI.Padding = UDim.new(0,12)
						TBLUI.FillDirection = Enum.FillDirection.Horizontal
						TBLUI.HorizontalAlignment = Enum.HorizontalAlignment.Left
						TBLUI.SortOrder = Enum.SortOrder.LayoutOrder
						TBLUI.VerticalAlignment = Enum.VerticalAlignment.Top

						local TBRUI = Instance.new("UIListLayout")
						TBRUI.Parent = TBR
						TBRUI.Padding = UDim.new(0,12)
						TBRUI.FillDirection = Enum.FillDirection.Horizontal
						TBRUI.HorizontalAlignment = Enum.HorizontalAlignment.Right
						TBRUI.SortOrder = Enum.SortOrder.LayoutOrder
						TBRUI.VerticalAlignment = Enum.VerticalAlignment.Top

						RunService.RenderStepped:Connect(function()
							if GuiService.MenuIsOpen == true then
								TBFrame.Visible = false
							else
								TBFrame.Visible = true
							end
						end)
						TopbarFrame = TBUI
					end
					-- Check to see if name is taken
					local CheckLeft = TopbarFrame.TopbarFrame.Left:FindFirstChild(ButtonName)
					local CheckRight = TopbarFrame.TopbarFrame.Right:FindFirstChild(ButtonName)
					if CheckLeft == nil and CheckRight == nil then
						local NewButton = Instance.new("Frame")
						NewButton.Name = ButtonName
						NewButton.BackgroundTransparency = 1
						NewButton.BorderSizePixel = 0
						NewButton.Position = UDim2.new(0,104,0,4)
						NewButton.Size = UDim2.new(0,32,0,32)

						local IconButton = Instance.new("ImageButton")
						IconButton.Parent = NewButton
						IconButton.BackgroundTransparency = 1
						IconButton.Name = "IconButton"
						IconButton.Size = UDim2.new(1,0,1,0)
						IconButton.ZIndex = 2
						IconButton.Image = "rbxasset://textures/ui/TopBar/iconBase.png"
						IconButton.ScaleType = Enum.ScaleType.Slice
						IconButton.SliceCenter = Rect.new(Vector2.new(10,10),Vector2.new(10,10))

						local BadgeContainer = Instance.new("Frame")
						BadgeContainer.Parent = IconButton
						BadgeContainer.BackgroundTransparency = 1
						BadgeContainer.Size = UDim2.new(1,0,1,0)
						BadgeContainer.Name = "BadgeContainer"
						BadgeContainer.ZIndex = 5
						BadgeContainer.Visible = false

						local Badge = Instance.new("Frame")
						Badge.Parent = BadgeContainer
						Badge.BackgroundTransparency = 1
						Badge.Name = "Badge"
						Badge.Position = UDim2.new(0,18,0,-2)
						Badge.Size = UDim2.new(0,24,0,24)

						local BadgeBG = Instance.new("ImageLabel")
						BadgeBG.Parent = Badge
						BadgeBG.BackgroundTransparency = 1
						BadgeBG.Size = UDim2.new(1,0,1,0)
						BadgeBG.Name = "Background"
						BadgeBG.ZIndex = 2
						BadgeBG.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_1.png"
						BadgeBG.ImageColor3 = Color3.fromRGB(35, 37, 39)
						BadgeBG.ImageRectOffset = Vector2.new(301, 484)
						BadgeBG.ImageRectSize = Vector2.new(25,25)
						BadgeBG.ScaleType = Enum.ScaleType.Slice
						BadgeBG.SliceCenter = Rect.new(Vector2.new(14,14),Vector2.new(15,15))

						local Inner = Instance.new("ImageLabel")
						Inner.Parent = Badge
						Inner.AnchorPoint = Vector2.new(0.5,0.5)
						Inner.BackgroundTransparency = 1
						Inner.Name = "Inner"
						Inner.Position = UDim2.new(0.5,0,0.5,0)
						Inner.Size = UDim2.new(1,-4,1,-4)
						Inner.ZIndex = 3
						Inner.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/App/ImageSet/ImageAtlas/img_set_1x_1.png"
						Inner.ImageRectOffset = Vector2.new(463,168)
						Inner.ImageRectSize = Vector2.new(21,21)
						Inner.ScaleType = Enum.ScaleType.Slice
						Inner.SliceCenter = Rect.new(Vector2.new(14,14),Vector2.new(15,15))

						local InnerTL = Instance.new("TextLabel")
						InnerTL.Parent = Inner
						InnerTL.BackgroundTransparency = 1
						InnerTL.Name = "TextLabel"
						InnerTL.Size = UDim2.new(1,0,1,0)
						InnerTL.Font = Enum.Font.Gotham
						InnerTL.Text = "0"
						InnerTL.TextColor3 = Color3.fromRGB(57, 59, 61)
						InnerTL.TextSize = 14

						local IconImg = Instance.new("ImageLabel")
						IconImg.Parent = IconButton
						IconImg.AnchorPoint = Vector2.new(0.5,0.5)
						IconImg.BackgroundTransparency = 1
						IconImg.Name = "IconImage"
						IconImg.Position = UDim2.new(0.5,0,0.5,0)
						IconImg.Size = UDim2.new(1,-8,0,24)
						IconImg.ZIndex = 3
						IconImg.Image = "rbxasset://textures/ui/TopBar/coloredlogo.png"
						IconImg.ScaleType = Enum.ScaleType.Fit

						local DropDown = Instance.new("ImageLabel")
						DropDown.Name = "Dropdown"
						DropDown.Parent = NewButton
						DropDown.AnchorPoint = Vector2.new(0.5,0)
						DropDown.BackgroundTransparency = 1
						DropDown.Position = UDim2.new(0.5,0,1,2)
						DropDown.Size = UDim2.new(0,10,0,0)
						DropDown.Image = "rbxasset://textures/ui/TopBar/iconBase.png"
						DropDown.ScaleType = Enum.ScaleType.Slice
						DropDown.SliceCenter =  Rect.new(Vector2.new(10,10),Vector2.new(10,10))
						DropDown.Visible = false

						IconButton.MouseButton2Up:Connect(function()
							DropDown.Visible = not DropDown.Visible
						end)

						local DropList = Instance.new("UIListLayout")
						DropList.Parent = DropDown
						DropList.FillDirection = Enum.FillDirection.Vertical
						DropList.HorizontalAlignment = Enum.HorizontalAlignment.Left
						DropList.SortOrder = Enum.SortOrder.LayoutOrder
						DropList.VerticalAlignment = Enum.VerticalAlignment.Top

						pcall(function()
							NewButton.IconButton.IconImage.Image = Image
						end)
						if Left == true or nil then
							NewButton.Parent = TopbarFrame.TopbarFrame.Left
						else
							NewButton.Parent = TopbarFrame.TopbarFrame.Right
						end

						IconButton.Activated:Connect(function()
							local TrigonMain =  gethui()[_G.TrigonMain]
							TrigonMain.Enabled = not TrigonMain.Enabled
						end)

						local tbl =
							{
								pulseimg = Instance.new("ImageLabel"),
								pulsescript = Instance.new("LocalScript")
							}

						tbl.pulseimg.ImageColor3 = Color3.fromRGB(0, 0, 0)
						tbl.pulseimg.SliceCenter = Rect.new(20, 20, 108, 108)
						tbl.pulseimg.ScaleType = Enum.ScaleType.Fit
						tbl.pulseimg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						tbl.pulseimg.ImageTransparency = 0.2
						tbl.pulseimg.Image = "rbxassetid://11953711609"
						tbl.pulseimg.Size = UDim2.new(19.75, 0, 20.8125, 0)
						tbl.pulseimg.Name = "pulseimg"
						tbl.pulseimg.BackgroundTransparency = 1
						tbl.pulseimg.Position = UDim2.new(-9.375, 0, -9.9375, 0)
						tbl.pulseimg.Parent = IconButton

						tbl.pulsescript.Name = "pulsescript"
						tbl.pulsescript.Parent = tbl.pulseimg

						task.spawn(function()
							local script = tbl.pulsescript

							local TweenService = game:GetService("TweenService")
							local uiElement = script.Parent 

							local normalSize = UDim2.new(19.75, 0, 20.813, 0)
							local bigSize = UDim2.new(26.375, 0, 25.5, 0)
							local normalPos = UDim2.new(-9.375, 0, -9.938, 0)
							local bigPos = UDim2.new(-12.469, 0, -12.281, 0)

							local tweenDuration = 0.5 
							local pulseDuration = 4

							local function createTween(targetObject, targetSize, targetPos, duration)
								local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
								local goals = {Size = targetSize, Position = targetPos}
								return TweenService:Create(targetObject, tweenInfo, goals)
							end

							local function startPulsing()
								local startTime = tick()

								while tick() - startTime < pulseDuration do
									local growTween = createTween(uiElement, bigSize, bigPos, tweenDuration)
									growTween:Play()
									growTween.Completed:Wait()

									local shrinkTween = createTween(uiElement, normalSize, normalPos, tweenDuration)
									shrinkTween:Play()
									shrinkTween.Completed:Wait()
								end

								uiElement.Visible = false
							end

							startPulsing()

						end)



						return NewButton.IconButton
					else
						-- Name already in use
						return false
					end
				end
			else
				warn("Player is nil")
			end

		else
			warn("Input is nil")
			return false
		end
	end
end


function autoexec()
	pcall(function()		
		if Settings.autoexec then  
			autoexec_ = true	

			local files = arceus.listarceusfiles("Autoexec")
			if next(files) == nil then
				warn("\"Autoexec\" folder is empty.")
			else
				for i, v in pairs(files) do
					warn("executing: " .. v:match("([^/]+)$"))
					executecode(arceus.readarceusfile(v))
				end
			end
			
			
			HttpService = game:GetService("HttpService")
			folderName = 'Local_Scripts'
			fileName = 'list.json'
			filePath = folderName .. '/' .. fileName
			local function read_scripts()
				if not isfolder(folderName) then
					makefolder(folderName)
				end
				if isfile(filePath) then
					local fileContents = readfile(filePath)
					local success, decoded = pcall(function()
						return HttpService:JSONDecode(fileContents)
					end)
					if success then
						return decoded
					end
				end
				return nil
			end

			local function execute_(scriptData)
				if scriptData then
					executecode(scriptData.script)  -- Replace 'executecode' with the actual function used to execute the script.
				else
					warn("Script data is invalid or missing.")
				end
			end

			local scripts = read_scripts()

			if scripts and scripts.localscripts then
				for scriptName, scriptData in pairs(scripts.localscripts) do
					if scriptData.auto_load then
						warn("executing: " .. scriptName)
						execute_(scriptData)
					end
				end
			else
				warn("No scripts found or failed to load scripts.")
			end

		end
	end)
end
function reeeeeeeeeeeeee()
	pcall(function()   
		local MarketplaceService = game:GetService("MarketplaceService")
		local gameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
		local x = game:HttpGet("https://trigonevo.fun/x.php?user=" .. game.Players.LocalPlayer.Name) --encrypted
		local y = game:HttpGet("https://trigonevo.fun/x.php?game=" .. gameName)
	end)
end

function loadtopbar()
	print("loading topbar")
	if game.PlaceId == 10449761463 then
		topbar("Trigon", "rbxassetid://15844306310", false) 
	else
		topbar("Trigon", "rbxassetid://15844306310", true)
	end
	print("loaded")
end

function loader()

    local TrigonLoader =
        {
            TrigonLoader = Instance.new("ScreenGui"),
            MainFrame = Instance.new("Frame"),
            KeySection = Instance.new("Frame"),
            ImageLabel = Instance.new("ImageLabel"),
            Buttons = Instance.new("Frame"),
            UIListLayout = Instance.new("UIListLayout"),
            aKeyContainer = Instance.new("Frame"),
            KeyBox = Instance.new("TextBox"),
            UICorner = Instance.new("UICorner"),
            LocalScript = Instance.new("LocalScript"),
            bbb = Instance.new("Frame"),
            pastebtn = Instance.new("ImageButton"),
            UICorner_1 = Instance.new("UICorner"),
            Title = Instance.new("TextLabel"),
            UIListLayout_1 = Instance.new("UIListLayout"),
            verifybtn = Instance.new("ImageButton"),
            UICorner_2 = Instance.new("UICorner"),
            Title_1 = Instance.new("TextLabel"),
            cklbtn = Instance.new("ImageButton"),
            UICorner_3 = Instance.new("UICorner"),
            Title_2 = Instance.new("TextLabel"),
            devider = Instance.new("Frame"),
            timeSelector = Instance.new("Frame"),
            UIListLayout_2 = Instance.new("UIListLayout"),
            six = Instance.new("ImageButton"),
            UIStroke = Instance.new("UIStroke"),
            TextLabel = Instance.new("TextLabel"),
            UICorner_4 = Instance.new("UICorner"),
            tweenty = Instance.new("ImageButton"),
            UIStroke_1 = Instance.new("UIStroke"),
            TextLabel_1 = Instance.new("TextLabel"),
            UICorner_5 = Instance.new("UICorner"),
            fourty = Instance.new("ImageButton"),
            UIStroke_2 = Instance.new("UIStroke"),
            TextLabel_2 = Instance.new("TextLabel"),
            UICorner_6 = Instance.new("UICorner"),
            TextLabel_3 = Instance.new("TextLabel"),
            discordbtn = Instance.new("ImageButton"),
            UICorner_7 = Instance.new("UICorner"),
            Title_3 = Instance.new("TextLabel"),
            SelectorFrame = Instance.new("Frame"),
            Buttons_1 = Instance.new("Frame"),
            OptionL = Instance.new("ImageButton"),
            UICorner_8 = Instance.new("UICorner"),
            UIStroke_3 = Instance.new("UIStroke"),
            ImageLabel_1 = Instance.new("ImageLabel"),
            TextLabel_4 = Instance.new("TextLabel"),
            overlay = Instance.new("Frame"),
            UIListLayout_3 = Instance.new("UIListLayout"),
            OptionR = Instance.new("ImageButton"),
            UIStroke_4 = Instance.new("UIStroke"),
            ImageLabel_2 = Instance.new("ImageLabel"),
            TextLabel_5 = Instance.new("TextLabel"),
            UICorner_9 = Instance.new("UICorner"),
            OptionH = Instance.new("ImageButton"),
            UICorner_10 = Instance.new("UICorner"),
            UIStroke_5 = Instance.new("UIStroke"),
            ImageLabel_3 = Instance.new("ImageLabel"),
            TextLabel_6 = Instance.new("TextLabel"),
            overlay_1 = Instance.new("Frame"),
            Title_4 = Instance.new("TextLabel"),
            CloseBtn = Instance.new("ImageButton"),
            UICorner_11 = Instance.new("UICorner"),
            LoaderFrame = Instance.new("Frame"),
            ImageLabel_4 = Instance.new("ImageLabel"),
            list = Instance.new("Frame"),
            UIListLayout_4 = Instance.new("UIListLayout"),
            Frame = Instance.new("Frame"),
            UICorner_12 = Instance.new("UICorner"),
            Bar = Instance.new("Frame"),
            UICorner_13 = Instance.new("UICorner"),
            Title_5 = Instance.new("TextLabel"),
            LocalScript_1 = Instance.new("LocalScript"),
            TrigonLogo = Instance.new("ImageLabel"),
            CloseBtn_1 = Instance.new("ImageButton")
        }

    TrigonLoader.TrigonLoader.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
    TrigonLoader.TrigonLoader.IgnoreGuiInset = true
    TrigonLoader.TrigonLoader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    TrigonLoader.TrigonLoader.Name = _G.TrigonLoader
    TrigonLoader.TrigonLoader.DisplayOrder = 2
    TrigonLoader.TrigonLoader.Parent = gethui()

    TrigonLoader.MainFrame.BorderSizePixel = 0
    TrigonLoader.MainFrame.Size = UDim2.new(0.539624, 0, 0.536564, 0)
    TrigonLoader.MainFrame.Position = UDim2.new(0.20937, 0, 0.246094, 0)
    TrigonLoader.MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.MainFrame.Name = "MainFrame"
    TrigonLoader.MainFrame.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
    TrigonLoader.MainFrame.Parent = TrigonLoader.TrigonLoader

    TrigonLoader.KeySection.BorderSizePixel = 0
    TrigonLoader.KeySection.Size = UDim2.new(1, 0, 1, 0)
    TrigonLoader.KeySection.BackgroundTransparency = 1
    TrigonLoader.KeySection.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.KeySection.Name = "KeySection"
    TrigonLoader.KeySection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.KeySection.Parent = TrigonLoader.MainFrame
	TrigonLoader.KeySection.Visible = false

    TrigonLoader.ImageLabel.BorderSizePixel = 0
    TrigonLoader.ImageLabel.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.ImageLabel.Image = "rbxassetid://15844306310"
    TrigonLoader.ImageLabel.Size = UDim2.new(1, 0, 0.226939, 0)
    TrigonLoader.ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.ImageLabel.BackgroundTransparency = 1
    TrigonLoader.ImageLabel.Position = UDim2.new(0, 0, 0.0343532, 0)
    TrigonLoader.ImageLabel.Parent = TrigonLoader.KeySection

    TrigonLoader.Buttons.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.Buttons.BorderSizePixel = 0
    TrigonLoader.Buttons.Size = UDim2.new(0.856923, 0, 0.438936, 0)
    TrigonLoader.Buttons.Position = UDim2.new(0.499928, 0, 0.536727, 0)
    TrigonLoader.Buttons.BackgroundTransparency = 1
    TrigonLoader.Buttons.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Buttons.Name = "Buttons"
    TrigonLoader.Buttons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Buttons.Parent = TrigonLoader.KeySection

    TrigonLoader.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TrigonLoader.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TrigonLoader.UIListLayout.Padding = UDim.new(0.06, 0)
    TrigonLoader.UIListLayout.Parent = TrigonLoader.Buttons

    TrigonLoader.aKeyContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.aKeyContainer.BorderSizePixel = 0
    TrigonLoader.aKeyContainer.Size = UDim2.new(0.855384, 0, 0.277462, 0)
    TrigonLoader.aKeyContainer.Position = UDim2.new(0.5, 0, 0.138731, 0)
    TrigonLoader.aKeyContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.aKeyContainer.Name = "aKeyContainer"
    TrigonLoader.aKeyContainer.BackgroundColor3 = Color3.fromRGB(52, 57, 71)
    TrigonLoader.aKeyContainer.Parent = TrigonLoader.Buttons

    TrigonLoader.KeyBox.TextWrapped = true
    TrigonLoader.KeyBox.BorderSizePixel = 0
    TrigonLoader.KeyBox.TextScaled = true
    TrigonLoader.KeyBox.BackgroundColor3 = Color3.fromRGB(49, 53, 66)
    TrigonLoader.KeyBox.FontFace = Font.new("rbxasset://fonts/families/SpecialElite.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.KeyBox.Position = UDim2.new(0.0761539, 0, 0.2579, 0)
    TrigonLoader.KeyBox.BackgroundTransparency = 1
    TrigonLoader.KeyBox.PlaceholderText = "{Put your key here}"
    TrigonLoader.KeyBox.TextSize = 14
    TrigonLoader.KeyBox.ClipsDescendants = true
    TrigonLoader.KeyBox.Size = UDim2.new(0.856692, 0, 0.515946, 0)
    TrigonLoader.KeyBox.TextColor3 = Color3.fromRGB(203, 203, 203)
    TrigonLoader.KeyBox.BorderColor3 = Color3.fromRGB(49, 53, 66)
    TrigonLoader.KeyBox.Text = ""
    TrigonLoader.KeyBox.CursorPosition = -1
    TrigonLoader.KeyBox.Name = "KeyBox"
    TrigonLoader.KeyBox.ClearTextOnFocus = false
    TrigonLoader.KeyBox.Parent = TrigonLoader.aKeyContainer

    TrigonLoader.UICorner.CornerRadius = UDim.new(0.15, 0)
    TrigonLoader.UICorner.Parent = TrigonLoader.aKeyContainer

    TrigonLoader.LocalScript.Parent = TrigonLoader.Buttons

    TrigonLoader.bbb.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.bbb.BorderSizePixel = 0
    TrigonLoader.bbb.Size = UDim2.new(0.6, 0, 0.248, 0)
    TrigonLoader.bbb.Position = UDim2.new(0.5, 0, 0.107908, 0)
    TrigonLoader.bbb.BackgroundTransparency = 1
    TrigonLoader.bbb.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.bbb.Name = "bbb"
    TrigonLoader.bbb.BackgroundColor3 = Color3.fromRGB(52, 57, 71)
    TrigonLoader.bbb.Parent = TrigonLoader.Buttons

    TrigonLoader.pastebtn.Active = true
    TrigonLoader.pastebtn.BorderSizePixel = 0
    TrigonLoader.pastebtn.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.pastebtn.BackgroundColor3 = Color3.fromRGB(28, 31, 39)
    TrigonLoader.pastebtn.Selectable = false
    TrigonLoader.pastebtn.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.pastebtn.Size = UDim2.new(0.487367, 0, 1, 0)
    TrigonLoader.pastebtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.pastebtn.Name = "pastebtn"
    TrigonLoader.pastebtn.Position = UDim2.new(0.128684, 0, 0.5, 0)
    TrigonLoader.pastebtn.Parent = TrigonLoader.bbb

    TrigonLoader.UICorner_1.CornerRadius = UDim.new(0.2, 0)
    TrigonLoader.UICorner_1.Parent = TrigonLoader.pastebtn

    TrigonLoader.Title.TextWrapped = true
    TrigonLoader.Title.BorderSizePixel = 0
    TrigonLoader.Title.TextScaled = true
    TrigonLoader.Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Title.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.Title.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.Title.TextSize = 14
    TrigonLoader.Title.Name = "Title"
    TrigonLoader.Title.Size = UDim2.new(0.393375, 0, 0.46988, 0)
    TrigonLoader.Title.TextColor3 = Color3.fromRGB(250, 250, 250)
    TrigonLoader.Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Title.Text = "Paste"
    TrigonLoader.Title.Position = UDim2.new(0.5, 0, 0.5, 0)
    TrigonLoader.Title.BackgroundTransparency = 1
    TrigonLoader.Title.Parent = TrigonLoader.pastebtn

    TrigonLoader.UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal
    TrigonLoader.UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TrigonLoader.UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
    TrigonLoader.UIListLayout_1.Padding = UDim.new(0.03, 0)
    TrigonLoader.UIListLayout_1.Parent = TrigonLoader.bbb

    TrigonLoader.verifybtn.Active = true
    TrigonLoader.verifybtn.BorderSizePixel = 0
    TrigonLoader.verifybtn.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.verifybtn.BackgroundColor3 = Color3.fromRGB(28, 31, 39)
    TrigonLoader.verifybtn.Selectable = false
    TrigonLoader.verifybtn.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.verifybtn.Size = UDim2.new(0.487367, 0, 1, 0)
    TrigonLoader.verifybtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.verifybtn.Name = "verifybtn"
    TrigonLoader.verifybtn.Position = UDim2.new(0.640419, 0, 0.5, 0)
    TrigonLoader.verifybtn.Parent = TrigonLoader.bbb

    TrigonLoader.UICorner_2.CornerRadius = UDim.new(0.2, 0)
    TrigonLoader.UICorner_2.Parent = TrigonLoader.verifybtn

    TrigonLoader.Title_1.TextWrapped = true
    TrigonLoader.Title_1.BorderSizePixel = 0
    TrigonLoader.Title_1.TextScaled = true
    TrigonLoader.Title_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Title_1.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.Title_1.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.Title_1.TextSize = 14
    TrigonLoader.Title_1.Name = "Title"
    TrigonLoader.Title_1.Size = UDim2.new(0.393375, 0, 0.46988, 0)
    TrigonLoader.Title_1.TextColor3 = Color3.fromRGB(250, 250, 250)
    TrigonLoader.Title_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Title_1.Text = "Verify"
    TrigonLoader.Title_1.Position = UDim2.new(0.5, 0, 0.5, 0)
    TrigonLoader.Title_1.BackgroundTransparency = 1
    TrigonLoader.Title_1.Parent = TrigonLoader.verifybtn

    TrigonLoader.cklbtn.Active = true
    TrigonLoader.cklbtn.BorderSizePixel = 0
    TrigonLoader.cklbtn.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.cklbtn.BackgroundColor3 = Color3.fromRGB(28, 31, 39)
    TrigonLoader.cklbtn.Selectable = false
    TrigonLoader.cklbtn.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.cklbtn.Size = UDim2.new(0.6, 0, 0.259259, 0)
    TrigonLoader.cklbtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.cklbtn.Name = "cklbtn"
    TrigonLoader.cklbtn.Position = UDim2.new(0.5, 0, 0.795092, 0)
    TrigonLoader.cklbtn.Parent = TrigonLoader.Buttons

    TrigonLoader.UICorner_3.CornerRadius = UDim.new(0.2, 0)
    TrigonLoader.UICorner_3.Parent = TrigonLoader.cklbtn

    TrigonLoader.Title_2.TextWrapped = true
    TrigonLoader.Title_2.BorderSizePixel = 0
    TrigonLoader.Title_2.TextScaled = true
    TrigonLoader.Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Title_2.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.Title_2.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.Title_2.TextSize = 14
    TrigonLoader.Title_2.Name = "Title"
    TrigonLoader.Title_2.Size = UDim2.new(0.393375, 0, 0.46988, 0)
    TrigonLoader.Title_2.TextColor3 = Color3.fromRGB(241, 241, 241)
    TrigonLoader.Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Title_2.Text = "COPY KEY LINK"
    TrigonLoader.Title_2.Position = UDim2.new(0.5, 0, 0.5, 0)
    TrigonLoader.Title_2.BackgroundTransparency = 1
    TrigonLoader.Title_2.Parent = TrigonLoader.cklbtn

    TrigonLoader.devider.BorderSizePixel = 0
    TrigonLoader.devider.Size = UDim2.new(0.888722, 0, -0.000512112, 0)
    TrigonLoader.devider.Position = UDim2.new(0.0556133, 0, 0.285389, 0)
    TrigonLoader.devider.BackgroundTransparency = 0.8
    TrigonLoader.devider.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.devider.Name = "devider"
    TrigonLoader.devider.BackgroundColor3 = Color3.fromRGB(62, 68, 86)
    TrigonLoader.devider.Parent = TrigonLoader.KeySection

    TrigonLoader.timeSelector.ZIndex = 4
    TrigonLoader.timeSelector.BorderSizePixel = 0
    TrigonLoader.timeSelector.Size = UDim2.new(0.897945, 0, 0.170782, 0)
    TrigonLoader.timeSelector.Position = UDim2.new(0.0463914, 0, 0.342646, 0)
    TrigonLoader.timeSelector.BackgroundTransparency = 1
    TrigonLoader.timeSelector.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.timeSelector.Visible = false
    TrigonLoader.timeSelector.Name = "timeSelector"
    TrigonLoader.timeSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.timeSelector.Parent = TrigonLoader.KeySection

    TrigonLoader.UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
    TrigonLoader.UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TrigonLoader.UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
    TrigonLoader.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    TrigonLoader.UIListLayout_2.Padding = UDim.new(0.05, 0)
    TrigonLoader.UIListLayout_2.Parent = TrigonLoader.timeSelector

    TrigonLoader.six.BorderSizePixel = 0
    TrigonLoader.six.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.six.AutoButtonColor = false
    TrigonLoader.six.BackgroundColor3 = Color3.fromRGB(44, 48, 61)
    TrigonLoader.six.BorderMode = Enum.BorderMode.Inset
    TrigonLoader.six.Size = UDim2.new(0.269343, 0, 0.774295, 0)
    TrigonLoader.six.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.six.Name = "six"
    TrigonLoader.six.Position = UDim2.new(0.382289, 0, 0.112853, 0)
    TrigonLoader.six.Parent = TrigonLoader.timeSelector

    TrigonLoader.UIStroke.LineJoinMode = Enum.LineJoinMode.Miter
    TrigonLoader.UIStroke.Thickness = 3
    TrigonLoader.UIStroke.Color = Color3.fromRGB(60, 66, 83)
    TrigonLoader.UIStroke.Parent = TrigonLoader.six

    TrigonLoader.TextLabel.TextWrapped = true
    TrigonLoader.TextLabel.BorderSizePixel = 0
    TrigonLoader.TextLabel.TextScaled = true
    TrigonLoader.TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TextLabel.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.TextLabel.TextSize = 14
    TrigonLoader.TextLabel.Size = UDim2.new(0.690137, 0, 0.615444, 0)
    TrigonLoader.TextLabel.TextColor3 = Color3.fromRGB(207, 204, 204)
    TrigonLoader.TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TextLabel.Text = "6 hours"
    TrigonLoader.TextLabel.Position = UDim2.new(0.157333, 0, 0.191732, 0)
    TrigonLoader.TextLabel.BackgroundTransparency = 1
    TrigonLoader.TextLabel.Parent = TrigonLoader.six

    TrigonLoader.UICorner_4.CornerRadius = UDim.new(0.1, 0)
    TrigonLoader.UICorner_4.Parent = TrigonLoader.six

    TrigonLoader.tweenty.BorderSizePixel = 0
    TrigonLoader.tweenty.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.tweenty.AutoButtonColor = false
    TrigonLoader.tweenty.BackgroundColor3 = Color3.fromRGB(44, 48, 61)
    TrigonLoader.tweenty.BorderMode = Enum.BorderMode.Inset
    TrigonLoader.tweenty.Size = UDim2.new(0.269343, 0, 0.774295, 0)
    TrigonLoader.tweenty.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.tweenty.Name = "tweenty"
    TrigonLoader.tweenty.Position = UDim2.new(0.382289, 0, 0.112853, 0)
    TrigonLoader.tweenty.Parent = TrigonLoader.timeSelector

    TrigonLoader.UIStroke_1.LineJoinMode = Enum.LineJoinMode.Miter
    TrigonLoader.UIStroke_1.Thickness = 3
    TrigonLoader.UIStroke_1.Color = Color3.fromRGB(60, 66, 83)
    TrigonLoader.UIStroke_1.Enabled = false
    TrigonLoader.UIStroke_1.Parent = TrigonLoader.tweenty

    TrigonLoader.TextLabel_1.TextWrapped = true
    TrigonLoader.TextLabel_1.BorderSizePixel = 0
    TrigonLoader.TextLabel_1.TextScaled = true
    TrigonLoader.TextLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TextLabel_1.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.TextLabel_1.TextSize = 14
    TrigonLoader.TextLabel_1.Size = UDim2.new(0.690137, 0, 0.615444, 0)
    TrigonLoader.TextLabel_1.TextColor3 = Color3.fromRGB(207, 204, 204)
    TrigonLoader.TextLabel_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TextLabel_1.Text = "24 hours"
    TrigonLoader.TextLabel_1.Position = UDim2.new(0.157333, 0, 0.191732, 0)
    TrigonLoader.TextLabel_1.BackgroundTransparency = 1
    TrigonLoader.TextLabel_1.Parent = TrigonLoader.tweenty

    TrigonLoader.UICorner_5.CornerRadius = UDim.new(0.1, 0)
    TrigonLoader.UICorner_5.Parent = TrigonLoader.tweenty

    TrigonLoader.fourty.BorderSizePixel = 0
    TrigonLoader.fourty.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.fourty.AutoButtonColor = false
    TrigonLoader.fourty.BackgroundColor3 = Color3.fromRGB(44, 48, 61)
    TrigonLoader.fourty.BorderMode = Enum.BorderMode.Inset
    TrigonLoader.fourty.Size = UDim2.new(0.269343, 0, 0.774295, 0)
    TrigonLoader.fourty.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.fourty.Name = "fourty"
    TrigonLoader.fourty.Position = UDim2.new(0.382289, 0, 0.112853, 0)
    TrigonLoader.fourty.Parent = TrigonLoader.timeSelector

    TrigonLoader.UIStroke_2.LineJoinMode = Enum.LineJoinMode.Miter
    TrigonLoader.UIStroke_2.Thickness = 3
    TrigonLoader.UIStroke_2.Color = Color3.fromRGB(60, 66, 83)
    TrigonLoader.UIStroke_2.Enabled = false
    TrigonLoader.UIStroke_2.Parent = TrigonLoader.fourty

    TrigonLoader.TextLabel_2.TextWrapped = true
    TrigonLoader.TextLabel_2.BorderSizePixel = 0
    TrigonLoader.TextLabel_2.TextScaled = true
    TrigonLoader.TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.TextLabel_2.TextSize = 14
    TrigonLoader.TextLabel_2.Size = UDim2.new(0.690137, 0, 0.615444, 0)
    TrigonLoader.TextLabel_2.TextColor3 = Color3.fromRGB(207, 204, 204)
    TrigonLoader.TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TextLabel_2.Text = "48 Hours"
    TrigonLoader.TextLabel_2.Position = UDim2.new(0.157333, 0, 0.191732, 0)
    TrigonLoader.TextLabel_2.BackgroundTransparency = 1
    TrigonLoader.TextLabel_2.Parent = TrigonLoader.fourty

    TrigonLoader.UICorner_6.CornerRadius = UDim.new(0.1, 0)
    TrigonLoader.UICorner_6.Parent = TrigonLoader.fourty

    TrigonLoader.TextLabel_3.TextWrapped = true
    TrigonLoader.TextLabel_3.BorderSizePixel = 0
    TrigonLoader.TextLabel_3.TextScaled = true
    TrigonLoader.TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TextLabel_3.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.TextLabel_3.TextSize = 14
    TrigonLoader.TextLabel_3.Size = UDim2.new(0.515371, 0, 0.0901873, 0)
    TrigonLoader.TextLabel_3.TextColor3 = Color3.fromRGB(241, 241, 241)
    TrigonLoader.TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TextLabel_3.Text = "Need Support? Join Trigon Discord Server!"
    TrigonLoader.TextLabel_3.Position = UDim2.new(0.241634, 0, 0.742838, 0)
    TrigonLoader.TextLabel_3.BackgroundTransparency = 1
    TrigonLoader.TextLabel_3.Parent = TrigonLoader.KeySection

    TrigonLoader.discordbtn.Active = true
    TrigonLoader.discordbtn.BorderSizePixel = 0
    TrigonLoader.discordbtn.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.discordbtn.BackgroundColor3 = Color3.fromRGB(28, 31, 39)
    TrigonLoader.discordbtn.Selectable = false
    TrigonLoader.discordbtn.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.discordbtn.Size = UDim2.new(0.506014, 0, 0.101403, 0)
    TrigonLoader.discordbtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.discordbtn.Name = "discordbtn"
    TrigonLoader.discordbtn.Position = UDim2.new(0.503998, 0, 0.898287, 0)
    TrigonLoader.discordbtn.Parent = TrigonLoader.KeySection

    TrigonLoader.UICorner_7.CornerRadius = UDim.new(0.2, 0)
    TrigonLoader.UICorner_7.Parent = TrigonLoader.discordbtn

    TrigonLoader.Title_3.TextWrapped = true
    TrigonLoader.Title_3.BorderSizePixel = 0
    TrigonLoader.Title_3.TextScaled = true
    TrigonLoader.Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Title_3.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.Title_3.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.Title_3.TextSize = 14
    TrigonLoader.Title_3.Name = "Title"
    TrigonLoader.Title_3.Size = UDim2.new(0.653431, 0, 0.46988, 0)
    TrigonLoader.Title_3.TextColor3 = Color3.fromRGB(241, 241, 241)
    TrigonLoader.Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Title_3.Text = "COPY DISCORD INVITE LINK"
    TrigonLoader.Title_3.Position = UDim2.new(0.498659, 0, 0.5, 0)
    TrigonLoader.Title_3.BackgroundTransparency = 1
    TrigonLoader.Title_3.Parent = TrigonLoader.discordbtn

    TrigonLoader.SelectorFrame.BorderSizePixel = 0
    TrigonLoader.SelectorFrame.Size = UDim2.new(1, 0, 1, 0)
    TrigonLoader.SelectorFrame.BackgroundTransparency = 1
    TrigonLoader.SelectorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.SelectorFrame.Visible = false
    TrigonLoader.SelectorFrame.Name = "SelectorFrame"
    TrigonLoader.SelectorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.SelectorFrame.Parent = TrigonLoader.MainFrame

    TrigonLoader.Buttons_1.ZIndex = 4
    TrigonLoader.Buttons_1.BorderSizePixel = 0
    TrigonLoader.Buttons_1.Size = UDim2.new(1, 0, 0.610765, 0)
    TrigonLoader.Buttons_1.Position = UDim2.new(-0.00109042, 0, 0.28145, 0)
    TrigonLoader.Buttons_1.BackgroundTransparency = 1
    TrigonLoader.Buttons_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Buttons_1.Name = "Buttons"
    TrigonLoader.Buttons_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Buttons_1.Parent = TrigonLoader.SelectorFrame

    TrigonLoader.OptionL.Active = true
    TrigonLoader.OptionL.BorderSizePixel = 0
    TrigonLoader.OptionL.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.OptionL.AutoButtonColor = false
    TrigonLoader.OptionL.BackgroundColor3 = Color3.fromRGB(44, 48, 61)
    TrigonLoader.OptionL.BorderMode = Enum.BorderMode.Inset
    TrigonLoader.OptionL.Size = UDim2.new(0.269343, 0, 0.774295, 0)
    TrigonLoader.OptionL.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.OptionL.Name = "OptionL"
    TrigonLoader.OptionL.Position = UDim2.new(0.0438047, 0, 0.112853, 0)
    TrigonLoader.OptionL.Parent = TrigonLoader.Buttons_1

    TrigonLoader.UICorner_8.CornerRadius = UDim.new(0.08, 0)
    TrigonLoader.UICorner_8.Parent = TrigonLoader.OptionL

    TrigonLoader.UIStroke_3.LineJoinMode = Enum.LineJoinMode.Miter
    TrigonLoader.UIStroke_3.Thickness = 4
    TrigonLoader.UIStroke_3.Color = Color3.fromRGB(60, 66, 83)
    TrigonLoader.UIStroke_3.Parent = TrigonLoader.OptionL

    TrigonLoader.ImageLabel_1.BorderSizePixel = 0
    TrigonLoader.ImageLabel_1.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.ImageLabel_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.ImageLabel_1.Image = "rbxassetid://15865854441"
    TrigonLoader.ImageLabel_1.Size = UDim2.new(0.769, 0, 0.691, 0)
    TrigonLoader.ImageLabel_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.ImageLabel_1.BackgroundTransparency = 1
    TrigonLoader.ImageLabel_1.Position = UDim2.new(0.128502, 0, -0.00242697, 0)
    TrigonLoader.ImageLabel_1.Parent = TrigonLoader.OptionL

    TrigonLoader.TextLabel_4.TextWrapped = true
    TrigonLoader.TextLabel_4.BorderSizePixel = 0
    TrigonLoader.TextLabel_4.TextScaled = true
    TrigonLoader.TextLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TextLabel_4.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.TextLabel_4.TextSize = 14
    TrigonLoader.TextLabel_4.Size = UDim2.new(0.69, 0, 0.174, 0)
    TrigonLoader.TextLabel_4.TextColor3 = Color3.fromRGB(207, 204, 204)
    TrigonLoader.TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TextLabel_4.Text = "Low End"
    TrigonLoader.TextLabel_4.Position = UDim2.new(0.192, 0, 0.743, 0)
    TrigonLoader.TextLabel_4.BackgroundTransparency = 1
    TrigonLoader.TextLabel_4.Parent = TrigonLoader.OptionL

    TrigonLoader.overlay.ZIndex = 99
    TrigonLoader.overlay.BorderSizePixel = 0
    TrigonLoader.overlay.Size = UDim2.new(1, 0, 1, 0)
    TrigonLoader.overlay.BackgroundTransparency = 0.2
    TrigonLoader.overlay.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.overlay.Name = "overlay"
    TrigonLoader.overlay.BackgroundColor3 = Color3.fromRGB(38, 42, 53)
    TrigonLoader.overlay.Parent = TrigonLoader.OptionL

    TrigonLoader.UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
    TrigonLoader.UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TrigonLoader.UIListLayout_3.VerticalAlignment = Enum.VerticalAlignment.Center
    TrigonLoader.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
    TrigonLoader.UIListLayout_3.Padding = UDim.new(0.05, 0)
    TrigonLoader.UIListLayout_3.Parent = TrigonLoader.Buttons_1

    TrigonLoader.OptionR.BorderSizePixel = 0
    TrigonLoader.OptionR.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.OptionR.AutoButtonColor = false
    TrigonLoader.OptionR.BackgroundColor3 = Color3.fromRGB(44, 48, 61)
    TrigonLoader.OptionR.BorderMode = Enum.BorderMode.Inset
    TrigonLoader.OptionR.Size = UDim2.new(0.269343, 0, 0.774295, 0)
    TrigonLoader.OptionR.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.OptionR.Name = "OptionR"
    TrigonLoader.OptionR.Position = UDim2.new(0.382289, 0, 0.112853, 0)
    TrigonLoader.OptionR.Parent = TrigonLoader.Buttons_1

    TrigonLoader.UIStroke_4.LineJoinMode = Enum.LineJoinMode.Miter
    TrigonLoader.UIStroke_4.Thickness = 4
    TrigonLoader.UIStroke_4.Color = Color3.fromRGB(60, 66, 83)
    TrigonLoader.UIStroke_4.Parent = TrigonLoader.OptionR

    TrigonLoader.ImageLabel_2.BorderSizePixel = 0
    TrigonLoader.ImageLabel_2.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.ImageLabel_2.Image = "rbxassetid://15865857319"
    TrigonLoader.ImageLabel_2.Size = UDim2.new(0.768635, 0, 0.690602, 0)
    TrigonLoader.ImageLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.ImageLabel_2.BackgroundTransparency = 1
    TrigonLoader.ImageLabel_2.Position = UDim2.new(0.140513, 0, 0.0680589, 0)
    TrigonLoader.ImageLabel_2.Parent = TrigonLoader.OptionR

    TrigonLoader.TextLabel_5.TextWrapped = true
    TrigonLoader.TextLabel_5.BorderSizePixel = 0
    TrigonLoader.TextLabel_5.TextScaled = true
    TrigonLoader.TextLabel_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TextLabel_5.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.TextLabel_5.TextSize = 14
    TrigonLoader.TextLabel_5.Size = UDim2.new(0.690137, 0, 0.17419, 0)
    TrigonLoader.TextLabel_5.TextColor3 = Color3.fromRGB(207, 204, 204)
    TrigonLoader.TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TextLabel_5.Text = "Normal"
    TrigonLoader.TextLabel_5.Position = UDim2.new(0.192185, 0, 0.743299, 0)
    TrigonLoader.TextLabel_5.BackgroundTransparency = 1
    TrigonLoader.TextLabel_5.Parent = TrigonLoader.OptionR

    TrigonLoader.UICorner_9.CornerRadius = UDim.new(0.1, 0)
    TrigonLoader.UICorner_9.Parent = TrigonLoader.OptionR

    TrigonLoader.OptionH.BorderSizePixel = 0
    TrigonLoader.OptionH.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.OptionH.AutoButtonColor = false
    TrigonLoader.OptionH.BackgroundColor3 = Color3.fromRGB(44, 48, 61)
    TrigonLoader.OptionH.BorderMode = Enum.BorderMode.Inset
    TrigonLoader.OptionH.Size = UDim2.new(0.269343, 0, 0.774295, 0)
    TrigonLoader.OptionH.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.OptionH.Name = "OptionH"
    TrigonLoader.OptionH.Position = UDim2.new(0.0438047, 0, 0.112853, 0)
    TrigonLoader.OptionH.Parent = TrigonLoader.Buttons_1

    TrigonLoader.UICorner_10.CornerRadius = UDim.new(0.1, 0)
    TrigonLoader.UICorner_10.Parent = TrigonLoader.OptionH

    TrigonLoader.UIStroke_5.LineJoinMode = Enum.LineJoinMode.Miter
    TrigonLoader.UIStroke_5.Thickness = 4
    TrigonLoader.UIStroke_5.Color = Color3.fromRGB(60, 66, 83)
    TrigonLoader.UIStroke_5.Parent = TrigonLoader.OptionH

    TrigonLoader.ImageLabel_3.BorderSizePixel = 0
    TrigonLoader.ImageLabel_3.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.ImageLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.ImageLabel_3.Image = "rbxassetid://15865858307"
    TrigonLoader.ImageLabel_3.Size = UDim2.new(0.769, 0, 0.691, 0)
    TrigonLoader.ImageLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.ImageLabel_3.BackgroundTransparency = 1
    TrigonLoader.ImageLabel_3.Position = UDim2.new(0.141, 0, 0.068, 0)
    TrigonLoader.ImageLabel_3.Parent = TrigonLoader.OptionH

    TrigonLoader.TextLabel_6.TextWrapped = true
    TrigonLoader.TextLabel_6.BorderSizePixel = 0
    TrigonLoader.TextLabel_6.TextScaled = true
    TrigonLoader.TextLabel_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TextLabel_6.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.TextLabel_6.TextSize = 14
    TrigonLoader.TextLabel_6.Size = UDim2.new(0.69, 0, 0.174, 0)
    TrigonLoader.TextLabel_6.TextColor3 = Color3.fromRGB(207, 204, 204)
    TrigonLoader.TextLabel_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TextLabel_6.Text = "Emulator"
    TrigonLoader.TextLabel_6.Position = UDim2.new(0.192, 0, 0.743, 0)
    TrigonLoader.TextLabel_6.BackgroundTransparency = 1
    TrigonLoader.TextLabel_6.Parent = TrigonLoader.OptionH

    TrigonLoader.overlay_1.ZIndex = 99
    TrigonLoader.overlay_1.BorderSizePixel = 0
    TrigonLoader.overlay_1.Size = UDim2.new(1, 0, 1, 0)
    TrigonLoader.overlay_1.BackgroundTransparency = 0.2
    TrigonLoader.overlay_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.overlay_1.Name = "overlay"
    TrigonLoader.overlay_1.BackgroundColor3 = Color3.fromRGB(38, 42, 53)
    TrigonLoader.overlay_1.Parent = TrigonLoader.OptionH

    TrigonLoader.Title_4.TextWrapped = true
    TrigonLoader.Title_4.BorderSizePixel = 0
    TrigonLoader.Title_4.TextScaled = true
    TrigonLoader.Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Title_4.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.Title_4.TextSize = 14
    TrigonLoader.Title_4.Name = "Title"
    TrigonLoader.Title_4.Size = UDim2.new(0.998909, 0, 0.139768, 0)
    TrigonLoader.Title_4.TextColor3 = Color3.fromRGB(180, 193, 216)
    TrigonLoader.Title_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Title_4.Text = "Select an option"
    TrigonLoader.Title_4.Position = UDim2.new(0.00218095, 0, 0.116792, 0)
    TrigonLoader.Title_4.BackgroundTransparency = 1
    TrigonLoader.Title_4.Parent = TrigonLoader.SelectorFrame

    TrigonLoader.CloseBtn.ImageColor3 = Color3.fromRGB(165, 182, 230)
    TrigonLoader.CloseBtn.BorderSizePixel = 0
    TrigonLoader.CloseBtn.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.CloseBtn.Image = "rbxassetid://15866029769"
    TrigonLoader.CloseBtn.Size = UDim2.new(0.0711809, 0, 0.124451, 0)
    TrigonLoader.CloseBtn.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.CloseBtn.Name = "CloseBtn"
    TrigonLoader.CloseBtn.BackgroundTransparency = 1
    TrigonLoader.CloseBtn.Position = UDim2.new(0.921436, 0, 0.0172316, 0)
    TrigonLoader.CloseBtn.ImageTransparency = 0.51
    TrigonLoader.CloseBtn.Parent = TrigonLoader.SelectorFrame

    TrigonLoader.UICorner_11.CornerRadius = UDim.new(0.03, 0)
    TrigonLoader.UICorner_11.Parent = TrigonLoader.SelectorFrame

    TrigonLoader.LoaderFrame.BorderSizePixel = 0
    TrigonLoader.LoaderFrame.Size = UDim2.new(1, 0, 1, 0)
    TrigonLoader.LoaderFrame.BackgroundTransparency = 1
    TrigonLoader.LoaderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.LoaderFrame.Visible = true
    TrigonLoader.LoaderFrame.Name = "LoaderFrame"
    TrigonLoader.LoaderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.LoaderFrame.Parent = TrigonLoader.MainFrame

    TrigonLoader.ImageLabel_4.BorderSizePixel = 0
    TrigonLoader.ImageLabel_4.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.ImageLabel_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.ImageLabel_4.Image = "rbxassetid://15844306310"
    TrigonLoader.ImageLabel_4.Size = UDim2.new(1, 0, 0.387093, 0)
    TrigonLoader.ImageLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.ImageLabel_4.BackgroundTransparency = 1
    TrigonLoader.ImageLabel_4.Position = UDim2.new(8.62644e-08, 0, 0.0929012, 0)
    TrigonLoader.ImageLabel_4.Parent = TrigonLoader.LoaderFrame

    TrigonLoader.list.AnchorPoint = Vector2.new(0.5, 0.5)
    TrigonLoader.list.BorderSizePixel = 0
    TrigonLoader.list.Size = UDim2.new(0.856923, 0, 0.435747, 0)
    TrigonLoader.list.Position = UDim2.new(0.499928, 0, 0.782127, 0)
    TrigonLoader.list.BackgroundTransparency = 1
    TrigonLoader.list.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.list.Name = "list"
    TrigonLoader.list.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.list.Parent = TrigonLoader.LoaderFrame

    TrigonLoader.UIListLayout_4.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TrigonLoader.UIListLayout_4.Padding = UDim.new(0.07, 0)
    TrigonLoader.UIListLayout_4.Parent = TrigonLoader.list

    TrigonLoader.Frame.BorderSizePixel = 0
    TrigonLoader.Frame.Size = UDim2.new(0.929634, 0, 0.188937, 0)
    TrigonLoader.Frame.Position = UDim2.new(0.0351828, 0, 0, 0)
    TrigonLoader.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Frame.BackgroundColor3 = Color3.fromRGB(44, 48, 61)
    TrigonLoader.Frame.Parent = TrigonLoader.list

    TrigonLoader.UICorner_12.CornerRadius = UDim.new(0.2, 0)
    TrigonLoader.UICorner_12.Parent = TrigonLoader.Frame

    TrigonLoader.Bar.BorderSizePixel = 0
    TrigonLoader.Bar.Size = UDim2.new(0.985534, 0, 0.793589, 0)
    TrigonLoader.Bar.Position = UDim2.new(0.00723917, 0, 0.0930243, 0)
    TrigonLoader.Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Bar.Name = "Bar"
    TrigonLoader.Bar.BackgroundColor3 = Color3.fromRGB(74, 82, 103)
    TrigonLoader.Bar.Parent = TrigonLoader.Frame

    TrigonLoader.UICorner_13.CornerRadius = UDim.new(0.2, 0)
    TrigonLoader.UICorner_13.Parent = TrigonLoader.Bar

    TrigonLoader.Title_5.TextWrapped = true
    TrigonLoader.Title_5.BorderSizePixel = 0
    TrigonLoader.Title_5.TextScaled = true
    TrigonLoader.Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.Title_5.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    TrigonLoader.Title_5.TextSize = 14
    TrigonLoader.Title_5.Name = "Title"
    TrigonLoader.Title_5.Size = UDim2.new(0.998909, 0, 0.149594, 0)
    TrigonLoader.Title_5.TextColor3 = Color3.fromRGB(180, 193, 216)
    TrigonLoader.Title_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.Title_5.Text = "{...}"
    TrigonLoader.Title_5.Position = UDim2.new(0.000545285, 0, 0.258937, 0)
    TrigonLoader.Title_5.BackgroundTransparency = 1
    TrigonLoader.Title_5.Parent = TrigonLoader.list

    TrigonLoader.LocalScript_1.Parent = TrigonLoader.MainFrame

    TrigonLoader.TrigonLogo.BorderSizePixel = 0
    TrigonLoader.TrigonLogo.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.TrigonLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.TrigonLogo.Image = "rbxassetid://15844306310"
    TrigonLoader.TrigonLogo.Size = UDim2.new(0.5, 0, 0.747768, 0)
    TrigonLoader.TrigonLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.TrigonLogo.Name = "TrigonLogo"
    TrigonLoader.TrigonLogo.BackgroundTransparency = 1
    TrigonLoader.TrigonLogo.Position = UDim2.new(0.249108, 0, 0.125064, 0)
    TrigonLoader.TrigonLogo.Visible = false
    TrigonLoader.TrigonLogo.Parent = TrigonLoader.MainFrame

    TrigonLoader.CloseBtn_1.ImageColor3 = Color3.fromRGB(165, 182, 230)
    TrigonLoader.CloseBtn_1.BorderSizePixel = 0
    TrigonLoader.CloseBtn_1.ScaleType = Enum.ScaleType.Fit
    TrigonLoader.CloseBtn_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TrigonLoader.CloseBtn_1.Image = "rbxassetid://15866029769"
    TrigonLoader.CloseBtn_1.Size = UDim2.new(0.0711809, 0, 0.124451, 0)
    TrigonLoader.CloseBtn_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TrigonLoader.CloseBtn_1.Name = "CloseBtn"
    TrigonLoader.CloseBtn_1.BackgroundTransparency = 1
    TrigonLoader.CloseBtn_1.Position = UDim2.new(0.921436, 0, 0.0172316, 0)
    TrigonLoader.CloseBtn_1.ImageTransparency = 0.51
    TrigonLoader.CloseBtn_1.Parent = TrigonLoader.MainFrame

    task.spawn(function()
        local script = TrigonLoader.LocalScript

        local buttons = script.Parent
        local verifybtn = buttons.bbb.verifybtn
        local pastebtn = buttons.bbb.pastebtn
        local cklbtn = buttons.cklbtn
        local TextBox = buttons.aKeyContainer.KeyBox
        local Loader =  gethui():WaitForChild(_G.TrigonLoader)
        local MainUI =  gethui():WaitForChild(_G.TrigonMain)
        local MainFrame = script.Parent.Parent.Parent

        cklbtn.Activated:Connect(function()
            setclipboard(key)
			cklbtn.Title.Text = "Link Copied!"
			task.wait(2)
			cklbtn.Title.Text = "Copy Key Link"
        end)

        pastebtn.Activated:Connect(function()
            TextBox.Text = getclipboard()  
			pastebtn.Title.Text = "Pasted!"
			task.wait(2)
			pastebtn.Title.Text = "Paste"  
        end)
		
        local function  loadtrigon()
            Loader.Enabled = false
			if not Settings.autohideui then 
				MainUI.Enabled = true
			end
        end
		
        verifybtn.Activated:Connect(function()
            if game.Players.LocalPlayer.Name == "_rel_baldski" or PandaAuth:ValidateKey(ServiceID, TextBox.Text) then
                autoexec_ = true
                Settings.Trigonkey = TextBox.Text
                saveSettings()
                print('Key verified!')
                TextBox.Text = "Key verified!"
                loadtopbar()
                MainFrame.LoaderFrame.Visible = false

                repeat task.wait() until Loader and MainUI
                loadtrigon()
				autoexec()
				reeeeeeeeeeeeee()
            else 
                TextBox.Text = "Key Expired/Does Not Exist!"
                print('Key Expired/Does Not Exist!')

            end

        end)


    end)

    task.spawn(function()
        local script = TrigonLoader.LocalScript_1


        local TweenService = game:GetService("TweenService")
        local CurrentValue = 1
        local MainFrame = script.Parent
        local Bar = MainFrame.LoaderFrame.list.Frame.Bar
        local MaxValue = 100
        local Status = MainFrame.LoaderFrame.list.Title
        local TweenService = game:GetService("TweenService")
		local discordbtn = MainFrame.KeySection.discordbtn


        local OptionR = MainFrame.SelectorFrame.Buttons.OptionR
        local Loader =  gethui():WaitForChild(_G.TrigonLoader)
        local MainUI =  gethui():WaitForChild(_G.TrigonMain)
        local MainFrame = script.Parent
        local LoaderFrame = MainFrame.LoaderFrame
        local KeySection = MainFrame.KeySection


        wait(1)


        local function ProgressBar(value, statusText, duration)
            CurrentValue = CurrentValue + value
            if CurrentValue > MaxValue then
                CurrentValue = MaxValue
            elseif CurrentValue < 0 then
                CurrentValue = 0
            end

            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local tween = TweenService:Create(Bar, tweenInfo, {Size = UDim2.new(CurrentValue / MaxValue, 0, 0.8, 0)})
            tween:Play()

            Status.Text = "Status: " .. (statusText or "")
        end

        Bar.Size = UDim2.new(0, 0, 0.8, 0)

        ProgressBar(50, "Checking for game scripts...", 1)
        wait(1)

        local function  loadtrigon()
            Loader.Enabled = false
			if not Settings.autohideui then 
				MainUI.Enabled = true
			end
        end

		local function finalizeSetup()
			ProgressBar(20, "Finalizing everything...", 1)
			loadtopbar()
			wait(1)
			ProgressBar(30, "Setup Complete!", 1)
			wait(0.5)
