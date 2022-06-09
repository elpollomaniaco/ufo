extends Control


const LEVEL_PATH: String = "res://level/level.tscn"

export var _background_music: AudioStream

var _loader: ResourceInteractiveLoader
var _level_resource: Resource


func _ready():
	_set_background_music()
	SceneController.connect("loading_progress_changed", self, "_on_loading_progress_changed")
	SceneController.connect("scene_loaded", self, "_on_scene_loaded")
	SceneController.load_scene(LEVEL_PATH)


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


func _change_level():
	SceneController.change_scene(_level_resource)


func _on_loading_progress_changed(progress: float):
	$Loading/Progress.value = progress


func _on_scene_loaded(level_resource: Resource):
	_level_resource = level_resource
	$Loading.hide()
	_show_buttons()
