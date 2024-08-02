extends Camera3D

var LOOKAROUND_SPEED = 0.01
var rot_x = 0
var rot_y = 0

func updateCam(x, y):
	# modify accumulated mouse rotation
	rot_x += x * LOOKAROUND_SPEED
	rot_y += y * LOOKAROUND_SPEED
	
	if (rot_y > 1.8):
		rot_y = 1.8
	if (rot_y < -1.8):
		rot_y = -1.8
	transform.basis = Basis() # reset rotation
	rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
	rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in X
	pass
	
func setPos(posx, posy):
	rot_x = posx
	rot_y = posy
	updateCam(posx, posy)
	pass
	
func _input(event):
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#	if event is InputEventMouseMotion:
#		updateCam(-event.relative.x, -event.relative.y)
	pass
