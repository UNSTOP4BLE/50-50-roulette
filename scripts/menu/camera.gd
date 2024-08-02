extends Camera3D

var LOOKAROUND_SPEED = 0.1
var CAMERA_SPEED = 10.0

func _process(delta):  
	var mouse_pos = get_viewport().get_mouse_position()
	
	rotation_degrees.y = lerp(float(rotation_degrees.y), float(-mouse_pos.x), float(delta * LOOKAROUND_SPEED))
	rotation_degrees.x = lerp(float(rotation_degrees.x), float(-mouse_pos.y), float(delta * LOOKAROUND_SPEED))
