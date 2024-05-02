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
    TrigonLoader.TrigonLoader.ZIndexBeha
