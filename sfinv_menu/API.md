API for sfinv_menu

# Registering a button
This method registers a button on the 'More' tab of the inventory

```
sfinv_menu.register_button("mymod:name", {
	title = "Title", -- Title displayed on the button
	icon = "image.png", -- Image file (needs to be square)
	privs = {}, -- OPTIONAL | Required privs
	func = function(player) end, -- Function performed when button is clicked
})
```
