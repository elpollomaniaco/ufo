extends StaticBody


onready var _light_left: Light = $EmergencyLights/LightL
onready var _light_right: Light = $EmergencyLights/LightR


func _switch_emergency_lights():
	# warning-ignore:standalone_ternary
	_light_left.hide() if _light_left.visible else _light_left.show()
	# warning-ignore:standalone_ternary
	_light_right.hide() if _light_right.visible else _light_right.show()
