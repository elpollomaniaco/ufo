extends Control


func _ready():
	$Buttons/Start.grab_focus()


func _on_start_pressed():
	# Not via PackedScene because of cyclic dependencies.
	get_tree().change_scene("res://level/level.tscn")


func _on_exit_pressed():
	get_tree().quit()
