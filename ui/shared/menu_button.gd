extends TextureButton


# Make hover event trigger focus event to prevent double focus.
func _on_mouse_entered():
	self.grab_focus()
