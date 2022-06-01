extends TextureButton


# Make hover event trigger focus event to prevent double focus.
func _on_mouse_entered():
	self.grab_focus()


func _on_focus_entered():
	$SFX/Selected.play()


# On button_down because of directly loading new scene on pressed will interrupt event reaction.
func _on_button_down():
	$SFX/Pressed.play()
