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
Window:Notify("Success", "The UI has loaded successfully.")
```

The first argument is the title of the notification, keep in mind that the word "LuAura: " will be behind the title, so the code above will result in the title being "LuAura: Success".
The second argument is the description of the notification.

Be warned, the notification system isn't perfect and has some bugs.

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
Tab:NewInput("Get string length.", false, function(Value, Entered)
	if Entered == true then
		Window:Notify("Print", "The string provided is "..#Value.." letters long.")
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
