extends Area2D

@onready var collision_shape = $CollisionShape2D

var clicked = false
var leftclicked = false
var justclicked = false
var justleftclicked = false
var is_hovered = false

func _ready():
	connect("input_event", _on_area2d_input_event)
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _process(delta): 
	justclicked = false;
	justleftclicked = false;
	
func _on_area2d_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT):
		if (event.pressed):
			if (is_hovered):
				leftclicked = true
		else:
			if (leftclicked and is_hovered):
				justleftclicked = true
			leftclicked = false
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		if (event.pressed):
			if (is_hovered):
				clicked = true
		else:
			if (clicked and is_hovered):
				justclicked = true
			clicked = false

func _on_mouse_entered():
	is_hovered = true

func _on_mouse_exited():
	is_hovered = false
	leftclicked = false
	clicked = false
