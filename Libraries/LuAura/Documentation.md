Hello, this document will show you how to use the LuAura library.
If you need any help please join our discord server: *https://discord.gg/gucEWABwKC*

Be warned, English isn't my first language and I am pretty bad at explaining stuff, so this documentation may be hard to follow, so I recommend you also experiment on your own to learn the library fully.


# Window Class

## NewWindow method

To create a new window object, use the **NewWindow** method, example:

``` lua
local Window = LuAura:NewWindow("Test UI", "2.4", 1.1, {
	DragSmoothness = 25;
})
```

The first argument is the name of the window (this is required),
the second argument is the version of the script (this is optional and if set to nil will remove the version text),
the third argument is the scale of the window (the size of the window will be multiplied by this number),
the fourth argument is the custom config table, you can change custom settings like:

* **Theme:** The theme color of the window.
* **Font:** The main font of text.
* **DragSmoothness:** The smoothness of dragging the frame.
* **DefaultTabIconID:** The default tab icon, I recommend not changing this.

The default config settings are:
``` lua
{
	Theme = Color3.fromRGB(50, 50, 50);
	Font = "rbxasset://fonts/families/Montserrat.json";
	DragSmoothness = 50;
	DefaultTabIconID = 18132434045;
}
```

## NewTab method

To create a new tab/page object in the window, use the **NewTab** method, example:

``` lua
local Tab = Window:NewTab("Home", 17340198495)
```

The first argument is the name of the tab/page (this is required),
the second argument is the tab icon ID (this is optional), make sure you copied the Asset ID correctly, this will overwrite the **DefaultTabIconID**.

## Notify method

You can send notifications using the **Notify** method, example:

``` lua
Window:Notify("Success", "The UI has loaded successfully.", 5)
```

The first argument is the title of the notification, keep in mind that the word "LuAura: " will be behind the title, so the code above will result in the title being "LuAura: Success",
the second argument is the description of the notification,
the third argument is the amount of time the notification will stay on screen (will be set to 3 seconds if not provided).

**Be warned, the notification system isn't perfect and has some bugs.**

## Destroy method

To remove the window completely, use the **Destroy** method, **keep in mind this will only remove the window and wont stop your script.**


# Tab Class

## NewButton method

To create a new button action in a tab, use the **NewButton** method, example:

``` lua
Tab:NewButton("Reset", function()
	local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

	Humanoid.Health = 0
end)
```

The first argument is the name/title of the action,
the second argument is the function that will be executed when the button is clicked.

## NewToggle method

To create a new toggle action in a tab, use the **NewToggle** method, example:

``` lua
Tab:NewToggle("Super Jump", false, function(Enabled)
	local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	
	Humanoid.UseJumpPower = true
	
	if Enabled == true then
		Humanoid.JumpPower = 100
	else
		Humanoid.JumpPower = 50
	end
end)
```

The first argument is the name/title of the action,
the second argument is the default state of the toggle (whether enabled or disabled),
the third argument is the function that will be executed when the toggle state is changed.

The first argument of the function will return the new state of the toggle.

## NewInput method

To create a new input action in a tab, use the **NewInput** method, example:

``` lua
Tab:NewInput("Chat message", false, function(Value, Entered)
	if Entered == true then
		game.Players.LocalPlayer:Chat(Value)
	end
end)
```

The first argument is the name/title of the action,
the second argument will control whether the TextBox input will be big or small, if set to true, the TextBox input will be big and the text will not be removed when clicking on it, if set to false then the TextBox input will be small and the text will be removed when clicking on it,
the third argument is the function that will be executed when clicking off the TextBox input or pressing enter.

The first argument of the function will return the value/input,
the second argument will return whether enter was pressed or not.

## NewSlider method

To create a new slider action in a tab, use the **NewSlider** method, example:

``` lua
Tab:NewSlider("Speed", 10, 50, 10, function(Value:number)
	local Humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

	Humanoid.WalkSpeed = Value
end)
```

The first argument is the name/title of the action,
the second argument is the min value of the slider,
the third argument is the max value of the slider,
the fourth argument is the amount of steps on the slider, meaning if you set this to 5, there will be only 5 numbers that can be selected on the slider, if the amount of steps is infinite `math.huge` then there will be no steps,
the fifth argument is the function that will be executed when ever the slider value changes.

The first argument of the function will return the value of the slider.

## NewDropdown method

To create a new dropdown object in a tab, use the **NewDropdown** method, example:

``` lua
local Dropdown = Tab:NewDropdown("Teleport to place", {"Home", "Island", "Forest"}, nil, true, function(Item, Clicked)
	local RootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

	if Clicked == false then
		if Item == "Home" then
			Window:Notify("Teleport", "Home has been selected.")
		elseif Item == "Island" then
			Window:Notify("Teleport", "Island has been selected.")
		elseif Item == "Forest" then
			Window:Notify("Teleport", "Forest has been selected.")
		end
	elseif Clicked == true then
		if Item == "Home" then
			RootPart.CFrame = CFrame.new(216, 172, 624)
		elseif Item == "Island" then
			RootPart.CFrame = CFrame.new(472, 563, 182)
		elseif Item == "Forest" then
			RootPart.CFrame = CFrame.new(1728, 192, 56)
		end
	end
end)
```

The first argument is the name/title of the action,
the second argument is all the items/things that can be selected,
the third argument is the default item/thing selected (if set to nil then the selected will be "None"),
the fourth argument controls if the items will be sorted alphabetically or not,
the fifth argument is the function that will be executed when clicking the frame or when selecting an item/thing.

The first argument of the function will return what item/thing has been selected,
the second argument of the function will return whether the frame has been clicked or an item/thing has been selected (if its true, then the frame has been clicked, if its false, then an item has been selected).

## NewColorWheel method

To create a new color wheel in a tab, use the **NewColorWheel** method, example:

``` lua
Home:NewColorWheel("Change head color", function(Color)
	local Head = game.Players.LocalPlayer.Character:FindFirstChild("Head")

	Head.Color = Color
end)
```

The first argument is the name/title of the action,
the second argument is the function that will be executed when the color changes.

the first argument of the function will return the color of the wheel.

**This method is limited currently and may get an update in the future.**

## NewSection method

To create a new section/divider in a tab, use the **NewSection** method, example:

``` lua
Tab:NewSection("Other")
```

The first argument is the section name.

**The section name will be between "--", for example: "-- Other --"**.

## NewHint method

To create a new hint in a tab, use the **NewHint** method, example:

``` lua
Tab:NewHint("Library made by Mystery_Mux (novakool on discord).")
```

The first argument is the hint text.

**Note: a hint is like a section/divider but without the "--"**

## NewGap method

To create a new gap to divide actions in a tab, use the **NewGap** method, example:

``` lua
Tab:NewGap(10)
```

The first argument is the length of the gap.

# DropdownClass

The dropdown class has properties like:
1. Action: The function to be executed.
2. Items: The list of all available items in the dropdown.
3. Selected: The current selected item in the dropdown.
4. Open: Whether the dropdown is open or not.

## ChangeItems method

To change dropdown items, use the **ChangeItems** method, example:

``` lua
Dropdown:ChangeItems({
	"Change 1";
	"Change 2";
	"Change 3";
}, true)
```

First argument is the new items table,
second argument controls if the items will be sorted alphabetically or not.

## AddItem method

To add a new item to the dropdown, use the **AddItem** method, example:

``` lua
Dropdown:AddItem("New Item", true)
```

First argument is the new item name,
second argument controls if the item will be sorted alphabetically or not.

## RemoveItem method

To remove an item in the dropdown, use the **RemoveItem** method, example:

``` lua
Dropdown:RemoveItem("New Item") -- Removes item called 'New Item'
Dropdown:RemoveItem(1) -- Removes first item
```

First argument can be either a number or a string,
if it's a number then its going to remove the item with that index,
if it's a string then its going to remove the item named with that string.

# Notes

There may be some bugs with my library, and some methods have been deprecated and removed like the **NewColorPicker** method.
