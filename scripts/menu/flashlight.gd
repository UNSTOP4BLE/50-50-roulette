extends SpotLight3D

# References to the nodes
@export var camera : Camera3D
@export var spotlight : SpotLight3D
@export var raycast : RayCast3D

var brightness = 0
func _ready():
	brightness = spotlight.light_energy;

func flicker():
	var rng = RandomNumberGenerator.new()
	if (rng.randi_range(0, 5) == 1):
		spotlight.light_energy = brightness
	if (rng.randi_range(0, 10) == 1):
		spotlight.light_energy = rng.randf_range(0.1, brightness)

func _process(delta: float) -> void:
	# Get the mouse position
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Convert mouse position to a ray in the 3D space
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 1000  # The large multiplier is to ensure the ray goes far enough
	
	# Set the raycast to the correct positions
	raycast.global_transform.origin = from
	raycast.target_position = to

	# Cast the ray
	raycast.force_raycast_update()

	if (raycast.is_colliding()):
		# Get the collision point
		var collision_point = raycast.get_collision_point()
		
		# Make the spotlight look at the collision point
		spotlight.look_at(collision_point, Vector3.UP)
	else:
		# If there's no collision, the spotlight can look in the direction of the raycast
		spotlight.look_at(to, Vector3.UP)
	pass
