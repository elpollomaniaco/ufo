extends Control


signal scene_loaded
signal loading_progress_changed

var _loader: ResourceInteractiveLoader
var _current_scene: Node

var _resource_cache: Dictionary


func _ready():
	_current_scene = get_node("/root").get_child(get_node("/root").get_child_count() -1) # Set first scene as current.

func _process(_delta):
	if _loader == null: # Done loading.
		set_process(false) # Save some resources.
		return
	
	var state = _loader.poll()
	
	if state == ERR_FILE_EOF:
		var scene_resource = _loader.get_resource()
		_resource_cache[scene_resource.resource_path] = scene_resource # Cache resource for next load.
		emit_signal("scene_loaded", scene_resource)
		_loader = null
	elif state == OK:
		var progress = 100 * float(_loader.get_stage()) / _loader.get_stage_count()
		emit_signal("loading_progress_changed", progress)


func load_scene(scene_path: String): 
	if _resource_cache.has(scene_path):
		emit_signal("scene_loaded", _resource_cache[scene_path])
	else:
		_loader = ResourceLoader.load_interactive(scene_path)
		set_process(true)


func change_scene(scene_resource: Resource):
	raise() # Needs to be in foreground.
	var animation_player = $Transition/AnimationPlayer
	animation_player.play("transition_in")
	yield(animation_player, "animation_finished")
	_current_scene.queue_free()
	yield(get_tree(), "idle_frame")
	_current_scene = scene_resource.instance()
	get_node("/root").add_child(_current_scene)
	yield(get_tree(),"idle_frame")
	animation_player.play("transition_out")
	yield(animation_player, "animation_finished")
