local actfilter = false
local filter1 = ""
local modindex
local modvalue
local modtype
local func

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

function notif()
    OrionLib:MakeNotification({
	Name = "Changes Saved!",
	Content = "",
	Image = "rbxassetid://5078628617",
	Time = 5})
end

local Window = OrionLib:MakeWindow({Name = "Exploit Assistant", HidePremium = false, SaveConfig = false, IntroText = "An Exploiters Tool Set", IntroIcon = "rbxassetid://8229820949"})

local tab = {}

tab.filter = Window:MakeTab({
	Name = "Filter",
	Icon = "rbxassetid://7964618035",
	PremiumOnly = false
})

tab.gc = Window:MakeTab({
	Name = "Garbage",
	Icon = "rbxassetid://3090651711",
	PremiumOnly = false
})

tab.modify = Window:MakeTab({
	Name = "Modify",
	Icon = "rbxassetid://6594776225",
	PremiumOnly = false
})

tab.spy = Window:MakeTab({
	Name = "Remote Spy",
	Icon = "rbxassetid://4460063940",
	PremiumOnly = false
})

tab.credits = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://8733216068",
	PremiumOnly = false
})

tab.gc:AddToggle({
	Name = "Filter",
	Default = false,
	Callback = function(Value)
		actfilter = Value
	end    
})

tab.gc:AddButton({
	Name = "Dump Garbage Collector",
	Callback = function()
	    rconsoleclear()
	    if not actfilter then
          	for i, v in pairs(getgc()) do
          	    if type(v) == "function" and not is_synapse_function(v) and getinfo(v).name and getinfo(v).name ~= "" then
          	        rconsolewarn(getinfo(v).name)
          	    end
          	end
	    end
        
        if actfilter then 
          	for i, v in pairs(getgc()) do
          	    if type(v) == "function" and not is_synapse_function(v) and getinfo(v).name and getinfo(v).name == filter1 then
          	        func = v
          	        rconsolewarn("Basic Info")
          	        rconsolewarn("___________")
          	        for _, info in pairs(getinfo(func)) do
          	            rconsolewarn(tostring(info))
          	        end
      	            rconsolewarn("\n\n")
      	            rconsolewarn("Up Values")
      	            rconsolewarn("___________")
      	            for index, value in pairs(getupvalues(func)) do
      	                rconsolewarn(index .. ":" .. tostring(value))
      	            end
      	            rconsolewarn("\n\n")
      	            rconsolewarn("Constants")
      	            rconsolewarn("___________")
      	            for index, value in pairs(getconstants(func)) do
      	                rconsolewarn(index .. ":" .. tostring(value))
      	            end
          	    end
          	end
	    end
  	end    
})

tab.modify:AddDropdown({
	Name = "Type of Value",
	Default = "CHOOSE",
	Options = {"Upvalue", "Constant"},
	Callback = function(Value)
		modtype = Value
	end    
})

tab.modify:AddTextbox({
	Name = "Index",
	Default = "Input",
	TextDisappear = false,
	Callback = function(Value)
		modindex = Value
	end
})

tab.modify:AddTextbox({
	Name = "Value",
	Default = "Input",
	TextDisappear = false,
	Callback = function(Value)
		modvalue = Value
	end
})

tab.modify:AddButton({
	Name = "Make Changes",
	Callback = function()
      	if modtype == "Upvalue" then
      	    if modvalue:match("^%d+$") then
      	        modvalue =  tonumber(modvalue)
      	    end
  	        
      	    setupvalue(func, tonumber(modindex), modvalue)
      	    notif()
      	end
  	    
  	    if modtype == "Constant" then
  	        if modvalue:match("^%d+$") then
      	        modvalue =  tonumber(modvalue)
      	    end
      	    
  	        setconstant(func, tonumber(modindex), modvalue)
  	        notif()
  	    end
  	end    
})


tab.filter:AddTextbox({
	Name = "Function Name",
	Default = "Input",
	TextDisappear = false,
	Callback = function(Value)
		filter1 = Value
	end	  
})

tab.spy:AddSection({
	Name = "Credit to Intrer#0421"
})


tab.spy:AddButton({
	Name = "Remote Spy",
	Callback = function()
      	loadstring(game:HttpGet("https://raw.githubusercontent.com/SippingSizzurp/turtlespyMODDED/main/main.lua", true))()
  	end    
})

tab.credits:AddLabel("Made By: SippingSizzurp")

OrionLib:Init()
