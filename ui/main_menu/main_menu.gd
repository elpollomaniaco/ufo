extends Control


func _ready():
	$Buttons/Start.grab_focus()


func _on_Start_pressed():
	# Not via PackedScene because of cyclic dependencies.
	get_tree().change_scene("res://level/level.tscn")


func _on_Exit_pressed():
	get_tree().quit()
