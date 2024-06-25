Hello, this document will show you how to use the LuAura library.
If you need any help please join our discord server: *https://discord.gg/gucEWABwKC*

# Window Class

## NewWindow method

To create a new window object, use the NewWindow method, example:

``` lua
local Window = LuAura:NewWindow("Test UI", "2.4", 1.1, {
	DragSmoothness = 25;
})
```

The first argument is the name of the window (this is required),
The second argument is the version of the script (this is optional and if set to nil will remove the version text),
The third argument is the scale of the window (the size of the window will be multiplied by this number),
The fourth argument is the custom config table, you can change custom settings like:

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

To create a new tab/page object in the window, use the NewTab method, example:

``` lua
local Home = Window:NewTab("Home", 17340198495)
```

The first argument is the name of the tab/page (this is required),
The second argument is the tab icon ID (this is optional), make sure you copied the Asset ID correctly, this will overwrite the **DefaultTabIconID** setting.
