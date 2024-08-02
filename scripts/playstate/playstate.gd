extends Node3D

var rustyshell = false

func _ready():
	rustyshell = false
	shell_randomizeRust()
	pass
	
func _process(delta):
	pass

func shell_randomizeRust():
	var rng = RandomNumberGenerator.new()
	if (rng.randi_range(0, 10) == 1):
		rustyshell = true
		print("shell_is_rusty")
	else:
		rustyshell = false
		print("shell_is_normal")
	
