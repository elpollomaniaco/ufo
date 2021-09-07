extends Control


func _on_Start_pressed():
	get_tree().change_scene("res://Level/Level.tscn")


func _on_Exit_pressed():
	get_tree().quit()
