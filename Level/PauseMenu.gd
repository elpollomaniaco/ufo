extends Control


func _ready():
	set_process(false)


func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		_resume_game()


func _on_Resume_pressed():
	_resume_game()


func _on_MainMenu_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")
	get_tree().paused = false


func _resume_game():
	hide()
	get_tree().paused = false
	set_process(false)
