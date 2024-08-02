extends Node3D

@export var camera : Camera3D
var cameraX = 0
var selection = 0
var inmenu = false
var changecam = false

func _ready():
	print("test start")   
	selection = 0
	inmenu = false
	changecam = false
	cameraX = 0
	pass
	
func _process(delta: float) -> void:
	if $Camera2D/arrowl/Area2D.is_hovered:
		$Camera2D/arrowl.play("default", 1, false)
	else:
		$Camera2D/arrowl.stop()
		
	if $Camera2D/arrowr/Area2D.is_hovered:
		$Camera2D/arrowr.play("default", 1, false)
	else:
		$Camera2D/arrowr.stop()
	#handle input
	if !inmenu:	
		$Camera2D/arrowl.visible = true
		$Camera2D/arrowr.visible = true
		if $Camera2D/arrowl/Area2D.justclicked:
			if (cameraX > 360-90):
				camera.rotation_degrees.y = 0
				cameraX = 0
				selection = 0
			cameraX += 90
		elif $Camera2D/arrowr/Area2D.justclicked:
			if (cameraX < -360+90):
				camera.rotation_degrees.y = 0
				cameraX = 0
				selection = 0
			cameraX -= 90
	else:
		$Camera2D/arrowl.visible = false
		$Camera2D/arrowr.visible = false
	#options
	if cameraX == 0 or cameraX == -360: #play
		selection = 0
	elif cameraX == -90 or cameraX == 270: #options
		selection = 1
	elif cameraX == 180 or cameraX == -180: #exit
		selection = 2
	elif cameraX == 90 or cameraX == -270: #credits
		selection = 3
		
	print(inmenu, " ")
	
	if Input.is_action_just_pressed("ui_accept"):
		inmenu = !inmenu
		
	if inmenu:
		if selection == 0: #play
			if !changecam:
				camera.rotation_degrees.y = 0
				cameraX = camera.rotation_degrees.y
				changecam = true
			camera.position.z = lerp(float(camera.position.z), float(-6.5), float(delta * camera.CAMERA_SPEED/2))
			camera.rotation_degrees.y = lerp(float(camera.rotation_degrees.y), float(90), float(delta * camera.CAMERA_SPEED/2))
		elif selection == 1: #options
			if !changecam:
				camera.rotation_degrees.y = -90
				cameraX = camera.rotation_degrees.y
				changecam = true
			camera.position.x = lerp(float(camera.position.x), float(6.5), float(delta * camera.CAMERA_SPEED/2))
			camera.rotation_degrees.y = lerp(float(camera.rotation_degrees.y), float(-180), float(delta * camera.CAMERA_SPEED/2))
		elif selection == 2: #exit
			camera.position.z = lerp(float(camera.position.z), float(2.5), float(delta * camera.CAMERA_SPEED/2))
			camera.rotation_degrees.y = lerp(float(camera.rotation_degrees.y), float(cameraX), float(delta * camera.CAMERA_SPEED/2))
			camera.rotation_degrees.x = lerp(float(camera.rotation_degrees.x), float(-80), float(delta * camera.CAMERA_SPEED/2))
		elif selection == 3: #credits
			if !changecam:
				camera.rotation_degrees.y = -270
				cameraX = camera.rotation_degrees.y
				changecam = true
			camera.position.x = lerp(float(camera.position.x), float(-6.5), float(delta * camera.CAMERA_SPEED/2))
			camera.rotation_degrees.y = lerp(float(camera.rotation_degrees.y), float(-180), float(delta * camera.CAMERA_SPEED/2))
	
	print(inmenu)
	#reset
	if !inmenu:
		camera.position.z = lerp(float(camera.position.z), float(0), float(delta * camera.CAMERA_SPEED/2))
		camera.position.x = lerp(float(camera.position.x), float(0), float(delta * camera.CAMERA_SPEED/2))
		camera.rotation_degrees.y = lerp(float(camera.rotation_degrees.y), float(cameraX), float(delta * camera.CAMERA_SPEED/2))
		changecam = false;
	camera.rotation_degrees.x = lerp(float(camera.rotation_degrees.x), float(0),       float(delta * camera.CAMERA_SPEED))
	
	print(camera.position.z)
	pass
