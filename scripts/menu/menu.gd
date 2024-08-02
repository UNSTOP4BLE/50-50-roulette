extends Node3D

@export var camera : Camera3D
@export var arrowl : AnimatedSprite2D
@export var arrowr : AnimatedSprite2D
@export var arrAreaL : Area2D
@export var arrAreaR : Area2D

var camPos = Vector3(0, 2, 0)

var lastCamX = 0
var lastCamY = 0
var cameraX = 0
var cameraY = 0

var selection = 0
var changecam = false

var menu_state = 0

var MENU_STATE_HOME = 0
var MENU_STATE_OPTSELECTED = 1

func _ready():
	print("test start")   
	selection = 0
	menu_state = 0
	changecam = false
	
	camPos = Vector3(0, 2, 0)
	lastCamX = 0
	lastCamY = 0
	cameraX = 0
	cameraY = 0
	pass
	
func updateCamera(delta):
	camera.position.x = lerp(float(camera.position.x), float(camPos.x), float(delta * camera.CAMERA_SPEED/2))
	camera.position.y = lerp(float(camera.position.y), float(camPos.y), float(delta * camera.CAMERA_SPEED/2))
	camera.position.z = lerp(float(camera.position.z), float(camPos.z), float(delta * camera.CAMERA_SPEED/2))
	camera.rotation_degrees.y = lerp(float(camera.rotation_degrees.y), float(cameraX), float(delta * camera.CAMERA_SPEED/2))
	camera.rotation_degrees.x = lerp(float(camera.rotation_degrees.x), float(cameraY), float(delta * camera.CAMERA_SPEED/2))

func _process(delta: float) -> void:
	arrow_playAnim(arrowl, arrAreaL);
	arrow_playAnim(arrowr, arrAreaR);

	#back/accept
	if Input.is_action_just_pressed("ui_accept"):
		if (menu_state == MENU_STATE_HOME):
			menu_state = MENU_STATE_OPTSELECTED;
		else:
			menu_state = MENU_STATE_HOME
		arrow_togglevisible();
		
	if (menu_state == MENU_STATE_OPTSELECTED):
		if selection == 0: #play
			if !changecam:
				camera.rotation_degrees.y = 0;
				cameraX = camera.rotation_degrees.y;
				lastCamX = cameraX;
				changecam = true;
			camPos = Vector3(0, 2, -6.5)
			cameraX = 90;
		elif selection == 1: #options			
			if !changecam:
				camera.rotation_degrees.y = -90
				cameraX = camera.rotation_degrees.y;
				lastCamX = cameraX;
				changecam = true;
			camPos = Vector3(6.5, 2, 0)
			cameraX = -180;
		elif selection == 2: #exit
			camPos = Vector3(0, 2, 2.5)
			cameraY = -20
		elif selection == 3: #credits
			if !changecam:
				camera.rotation_degrees.y = -270
				cameraX = camera.rotation_degrees.y
				lastCamX = cameraX;
				changecam = true
			camPos = Vector3(-6.5, 2, 0)
			cameraX = -180;
			
	#reset
	if (menu_state == MENU_STATE_HOME):
		#options
		if (cameraX == 0 or cameraX == -360): #play
			selection = 0;
		elif (cameraX == -90 or cameraX == 270): #options
			selection = 1;
		elif (cameraX == 180 or cameraX == -180): #exit
			selection = 2;
		elif (cameraX == 90 or cameraX == -270): #credits
			selection = 3;
		
		cameraX = lastCamX
		cameraY = lastCamY
		camPos = Vector3(0, 2, 0)
		changecam = false;
		
		#input
		if arrAreaL.justclicked or Input.is_action_just_pressed("ui_left"):
			if (cameraX > 360-90):
				camera.rotation_degrees.y = 0
				cameraX = 0
				selection = 0
			cameraX += 90
			lastCamX = cameraX;
		elif arrAreaR.justclicked or Input.is_action_just_pressed("ui_right"):
			if (cameraX < -360+90): 
				camera.rotation_degrees.y = 0
				cameraX = 0
				selection = 0
			cameraX -= 90
			lastCamX = cameraX;
	
	#update camera
	updateCamera(delta)

	pass

#arrow functions 
func arrow_togglevisible():	
	arrowl.visible = !arrowl.visible;
	arrowr.visible = !arrowr.visible;

func arrow_playAnim(arrow : AnimatedSprite2D, area : Area2D):
	if (area.is_hovered):
		arrow.play("default", 1, false)
	else:
		arrow.stop()
