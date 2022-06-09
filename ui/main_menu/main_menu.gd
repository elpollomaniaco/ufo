extends Control


const LEVEL_PATH: String = "res://level/level.tscn"

export var _background_music: AudioStream

var _loader: ResourceInteractiveLoader
var _level_ressource: Resource


func _ready():
	_set_background_music()
	_init_preload()


func _process(_delta):
	_pre_load_level()


func _on_start_pressed():
	_change_level()


func _on_exit_pressed():
	get_tree().quit()


func _show_buttons():
	yield(get_tree().create_timer(0.5), "timeout")
	$Buttons/AnimationPlayer.play("buttons_slide_in")
	yield($Buttons/AnimationPlayer, "animation_finished")
	$Buttons/Start.grab_focus()


func _set_background_music():
	AudioController.change_background_music(_background_music)


func _init_preload():
	_loader = ResourceLoader.load_interactive(LEVEL_PATH)


func _pre_load_level():
	if _loader == null: # Done loading.
		return
	
	var state = _loader.poll()
	
	if state == ERR_FILE_EOF: 
		_level_ressource = _loader.get_resource()
		_loader = null
		$Loading.hide()
		_show_buttons()
	elif state == OK:
		var progress = 100 * float(_loader.get_stage()) / _loader.get_stage_count()
		$Loading/Progress.value = progress


func _change_level():
	var level_scene = _level_ressource.instance()
	get_node("/root").add_child(level_scene)
	queue_free()
