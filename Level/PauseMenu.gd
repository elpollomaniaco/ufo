extends Control



func _on_Resume_pressed():
	hide()
	get_tree().paused = false


func _on_MainMenu_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")
	get_tree().paused = false
