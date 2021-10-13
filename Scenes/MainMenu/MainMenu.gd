extends Control


func _ready():
	$Buttons/Start.grab_focus()


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Level/Level.tscn")


func _on_Exit_pressed():
	get_tree().quit()
