extends Control


export var _main_menu_scene: PackedScene


func _ready():
	# Deactivate input detection through process. 
	# Otherwise, the menu would open and immediately close again in game.
	set_process(false)


func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		_resume_game()


func show_pause_menu():
	$Buttons/Resume.grab_focus()
	set_process(true)
	show()


func _on_Resume_pressed():
	_resume_game()


func _on_MainMenu_pressed():
	get_tree().change_scene_to(_main_menu_scene)
	get_tree().paused = false


func _resume_game():
	hide()
	set_process(false)
	get_tree().paused = false
