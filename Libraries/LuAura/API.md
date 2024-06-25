Hello, this document will show you how to use the LuAura library.
If you need any help please join our discord server: *https://discord.gg/gucEWABwKC*

# Window Class

To create a new window class, use the NewWindow method, example:

``` lua
local Window = LuAura:NewWindow("Test", "0.11", 1.1, {
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
