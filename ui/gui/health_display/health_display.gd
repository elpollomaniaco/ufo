extends Control


# Not yet secured against changes in player node!
const MAX_HEALTH: int = 100

onready var _progress: TextureProgress = $Vial


func _ready():
	change_value(MAX_HEALTH)


func change_value(new_value: int):
	_change_progress_bar_value(new_value)


func _change_progress_bar_value(new_value: int):
	_progress.value = new_value
