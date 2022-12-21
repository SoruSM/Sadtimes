local Run
local FFC,WFC,GetChildren,GetDescendants,IsDescendantOf = game.FindFirstChild,game.WaitForChild,game.GetChildren,game.GetDescendants,game.IsDescendantOf
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local CollectionService = game:GetService("CollectionService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local PlayerGui = WFC(LocalPlayer,"PlayerGui")
local Object = game:GetObjects("rbxassetid://11876978100")[1]
local Useless = {
    "Armis",
    "Trickstus",
    "Armis",
    "Celeritas",
    "Contrarium",
    "Hystericus",
    "Ignis",
    "Nocere",
    "Sagitta Sol",
    "Scrupus",
    "Viribus",
    "Velo",
    "Trahere",
    "Shrieker",
    "Wooden Chair",
    "Sigil Helmet",
    "Lock Manipulation",
    "Life Sense",
    "Intent",
    "Analysis",
    "Mederi",
    "Verto",
    "Vulnere",
    "Gladius",
    "Wallet Swipe",
    "Snowball",
    "Dark Sigil Helmet",
    "HolyFire",
    "IronBody",
    "ScroomSpeech",
    "LordsTraining",
    "Helmet",
    "DragonSpeech",
    
}
function IsStringEmpty(String)
	if type(String) == 'string' then
		return String:match'^%s+$' ~= nil or #String == 0 or String == "" or false
	end
	return false
end
function GetName(Player)
    local Name 
    if IsStringEmpty(Player:GetAttribute("LastName")) then
        Name = Player.Name.. "\n".. Player:GetAttribute("FirstName")
    else
        Name = Player.Name.. "\n".. Player:GetAttribute("FirstName")..  " " .. Player:GetAttribute("LastName")
    end
    return Name
end

function GetSkills(Player)
    local Skills = {}
    if Player.Character then
        for _,v in pairs(GetDescendants(Player.Backpack)) do
            if FFC(v,"Skill") and not table.find(Useless,v.Name) then
                table.insert(Skills,v.Name)
            end
        end
    end
    return Skills
end

function GetSpells(Player)
    local Spells = {}
    if Player.Character then
        for _,v in pairs(GetDescendants(Player.Backpack)) do
            if FFC(v,"Spell") and not table.find(Useless,v.Name) or FFC(v,"SkillSpell") and not table.find(Useless,v.Name) then
                table.insert(Spells,v.Name)
            end
        end
    end
    return Spells
end

function GetHealth(Player)
    local Health
    if Player.Character then
        if FFC(Player.Character,"Humanoid") then
            Health = math.floor(Player.Character.Humanoid.Health).. " / ".. math.floor(Player.Character.Humanoid.MaxHealth)
        else
            Health = "no humanoid?!"
        end
    end
    return Health
end

function CheckEdict(Player)
    if Player.Character then
        local Character = Player.Character
        local FacialMarking = FFC(Character.Head,"FacialMarking")
        if FacialMarking then
            if FacialMarking.Texture == "http://www.roblox.com/asset/?id=4072968006" then
                return "Healer"
            elseif FacialMarking.Texture == "http://www.roblox.com/asset/?id=4072914434" then
                return "Seer"
            elseif FacialMarking.Texture == "http://www.roblox.com/asset/?id=4094417635" then
                return "Jester"
            elseif FacialMarking.Texture == "http://www.roblox.com/asset/?id=4072968656" then
                return "Blademaster"
            elseif FacialMarking.Texture ~= "http://www.roblox.com/asset/?id=4072968656" or FacialMarking.Texture ~= "http://www.roblox.com/asset/?id=4094417635" or FacialMarking.Texture ~= "http://www.roblox.com/asset/?id=4072914434" or FacialMarking.Texture ~= "http://www.roblox.com/asset/?id=4072968006" then
                return "None"
            end
        else
            return "None"
        end
    end
end

function IsMaxEdict(Player)
    if Player.Character then
        if Player:GetAttribute("MaxEdict") == false then
            return false
        elseif Player:GetAttribute("MaxEdict") == true then
            return true
        end
    end
end
function GetArtifact(Player)
    if Player.Character then
        local ArtifactFolder = FFC(Player.Character,"Artifacts")
        if #GetChildren(ArtifactFolder) ~= 0 then
            return ArtifactFolder:FindFirstChildWhichIsA("Folder").Name
        else
            return "None"
        end
    end
end
if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("LeaderboardGui") then
    local NewLB = game.StarterGui:FindFirstChild("LeaderboardGui"):Clone()
    NewLB.Parent = game.Players.LocalPlayer.PlayerGui
    NewLB.ResetOnSpawn = true
    NewLB.Name = "Custom"
    local Connection
    Connection = game.Players.LocalPlayer.CharacterAdded:Connect(function()
        NewLB:Destroy()
        Connection:Disconnect()
        Run()
    end)
end
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("StartMenu") then
    game.Players.LocalPlayer.PlayerGui:FindFirstChild("StartMenu").CopyrightBar:Destroy()
end
--CopyrightBar
workspace.CurrentCamera.CameraType = Enum.CameraType.Custom


Run = function()
    pcall(function()
        shared.SPRLS = script
        shared.SPROC = {}
    
        local Players = game:GetService "Players"
        local UIS = game:GetService "UserInputService"
        local RS = game:GetService "RunService"
        local LocalPlayer = Players.LocalPlayer
        local AdminMode = false
        local Spectating
        local PlayerData = {}

        if not LocalPlayer.Character then
            LocalPlayer.PlayerGui:WaitForChild("Custom"):WaitForChild("LeaderboardClient")
            wait()
        else
            LocalPlayer.PlayerGui:WaitForChild("LeaderboardGui"):WaitForChild("LeaderboardClient")
            wait()
        end

    
        function Find(Upvalues, Function)
            local Constants = {}
            if typeof(Upvalues) == "function" then
                Constants = debug.getconstants(Upvalues)
                Upvalues = debug.getupvalues(Upvalues)
            end
    
            for i, v in pairs(Upvalues) do
                local Env = getfenv(Function)
                Env.Constants = Constants
                setfenv(Function, Env)
                local S, E = pcall(Function, v)
    
                if S and E then
                    local Env = getfenv(2)
                    Env.Value = v
                    Env.Index = i
                    setfenv(2, Env)
                    return v
                end
            end
    
            return false
        end
    
        function InTable(Table, Value)
            for i, v in pairs(Table) do
                if v == Value then
                    return true
                end
            end
    
            return false
        end
    
    
    
    
        function NameRightClick(Player, Label)
            if script ~= shared.SPRLS then
                return false
            end
    
            local Button = Label:FindFirstChild "SPB" or Instance.new("TextButton", Label)
            Button.Name = "SPB"
            Button.Transparency = 1
            Button.Text = ""
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Position = UDim2.new(0, 0, 0, 0)

    
            Button.MouseButton2Click:Connect(function()
                if script ~= shared.SPRLS then
                    return false
                end
    
                if (Spectating == Player or Player == LocalPlayer) and LocalPlayer.Character then
                    Spectating = nil
                    workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                else
                    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                        Spectating = Player
                        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    
                        local T = Spectating.Character:GetDescendants()
                        
                        if LocalPlayer.Character then
                            for i, v in pairs(LocalPlayer.Character:GetDescendants()) do
                                table.insert(T, v)
                            end
                        end
    
                        workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChildOfClass "Humanoid"
                    end
                end
            end)
    
            return Label
        end



        function NameLeftClick(Player, Label)
            if script ~= shared.SPRLS then
                return false
            end
            
            local Button = FFC(Label,"SPB") or Instance.new("TextButton",Label)
            Button.Name = "SPB"
            Button.Transparency = 1
            Button.Text = ""
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Position = UDim2.new(0, 0, 0, 0)

    
            Button.MouseButton1Click:Connect(function()
                if script ~= shared.SPRLS then
                    return false
                end
                if not Player.Character then
                    return
                end
                local Clone = FFC(PlayerGui,"Custom") and FFC(PlayerGui.Custom.MainFrame,"PlayerCheck") or FFC(PlayerGui,"LeaderboardGui") and FFC(PlayerGui.LeaderboardGui.MainFrame,"PlayerCheck") or Object:Clone()
                if FFC(PlayerGui,"Custom") and not FFC(PlayerGui.Custom.MainFrame,"PlayerCheck") then
                    Clone.Parent = PlayerGui.Custom.MainFrame
                elseif FFC(PlayerGui,"LeaderboardGui") and not FFC(PlayerGui.LeaderboardGui.MainFrame,"PlayerCheck") then
                    Clone.Parent = PlayerGui.LeaderboardGui.MainFrame
                end
                if Clone.Visible == false then
                    Clone.Visible = true
                end
                local MainFrame = FFC(Clone,"MainFrame")
                local Header = FFC(MainFrame,"Header")
                local Title = FFC(Header,"Title")
                local Name = FFC(Title,"Value")
                local PlayerName = FFC(Title,"Label")
                local Menus = MainFrame.Menus
                local Dropshadow = Menus.Dropshadow
                local Main = Dropshadow.Main
                local FakeFill = Main.FakeFill
                local ScrollingFrame = FakeFill.ScrollingFrame
                local MainLabel = ScrollingFrame.Label
                Clone.Position = UDim2.new(1, -605, 0, 5)

                local NewName = GetName(Player)
                local NewSkills = GetSkills(Player)
                local NewSpells = GetSpells(Player)
                local NewArtifact = GetArtifact(Player)
                local NewEdictTier = IsMaxEdict(Player)
                local Edict = CheckEdict(Player)
                local Underline = {}
                for _,v in pairs(NewSpells) do
                    if v == "Hoppa" or v == "Snarvindur" then
                        table.insert(Underline,v..", ")
                        local a = table.find(NewSpells,v)
                        table.remove(NewSpells,a)
                    end
                end
                if NewEdictTier == true then 
                    MainLabel.Text = (
                    "<b>Skills : </b>"..table.concat(NewSkills, ", ")..
                    "\n \n".."<b>Spells : </b>".."<u>"..table.concat(Underline, ", ").."</u>"..
                    table.concat(NewSpells, ", ")..
                    "\n \n".."<b>Tags : </b>"..table.concat(CollectionService:GetTags(Player.Character) , ", ")..
                    "\n \n".."<b>Artifact : </b>"..NewArtifact..
                    "\n \n".. "<b>Edict : </b>".."<font color='rgb(239, 184, 56)'>".."Tier 3"..Edict.."</font>"
                )
                else
                    MainLabel.Text = (
                    "<b>Skills : </b>"..table.concat(NewSkills, ", ")..
                    "\n \n".."<b>Spells : </b>".."<u>"..table.concat(Underline, ", ").."</u>"..
                    table.concat(NewSpells, ", ")..
                    "\n \n".."<b>Tags : </b>"..table.concat(CollectionService:GetTags(Player.Character) , ", ")..
                    "\n \n".."<b>Artifact : </b>"..NewArtifact..
                    "\n \n".."<b>Edict : </b>"..Edict
                )
                end

                PlayerName.Text = NewName
                if FFC(Player.Character,"Humanoid") then
                    Name.Text = math.floor(Player.Character.Humanoid.Health).." / "..math.floor(Player.Character.Humanoid.MaxHealth)
                else
                    Name.Text = "where the fuck is the humanoid"
                end
            end)
        return Label
    end
    
        for i, v in pairs(getreg()) do
            if typeof(v) == "function" and islclosure(v) and not is_synapse_function(v) then
                local ups = debug.getupvalues(v)
                local scr = getfenv(v).script
    
                if
                    Find(
                        ups,
                        function(x)
                            return scr.Name == "LeaderboardClient" and typeof(x) == "function" and
                                InTable(debug.getconstants(x), "HouseRank")
                        end
                    )
                then
                    local Labels = {}
    
                    if
                        Find(
                            Value,
                            function(x)
                                return typeof(x) == "table" and x[LocalPlayer]
                            end
                        )
                    then
                        Labels = Value
                        for i, v in pairs(Value) do
                            NameRightClick(i, v)
                            NameLeftClick(i,v)
                        end
                    end
    
                    local Index = shared.SPROC[v] and shared.SPROC[v].Index or Index
                    local Original = shared.SPROC[v] and shared.SPROC[v].Function or debug.getupvalues(v)[Index]
                    shared.SPROC[v] = {Index = Index, Function = Original}
    
                    debug.setupvalue(
                        v,
                        Index,
                        function(Player, ...)
                            local Label = Original(Player, ...)
                            local DummyConstant = "HouseRank"
                            local DummyTable = Labels
    
                            NameRightClick(Player, Label)
                            NameLeftClick(Player,Label)
    
                            return Label
                        end
                    )
                end
            end
        end
    end)    
end

Run()