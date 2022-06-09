extends Control


export var _main_menu_resource: Resource


func _ready():
	# Deactivate input detection through process. 
	# Otherwise, the menu would open and immediately close again in game.
	set_process(false)


func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		_resume_game()


func show_pause_menu():
	$Buttons/Resume.grab_focus()
	set_process(true)
	show()


func _on_resume_pressed():
	_resume_game()


func _on_main_menu_pressed():
	get_tree().paused = false
	SceneController.change_scene(_main_menu_resource)


func _resume_game():
	hide()
	set_process(false)
	get_tree().paused = false
