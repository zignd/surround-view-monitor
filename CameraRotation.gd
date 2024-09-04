extends Node3D

@export var rotation_speed: float = 1.0  # Speed of rotation
@export var zoom_speed: float = 10.0     # Speed of zoom
@export var min_distance: float = 2.0    # Minimum distance from the pivot
@export var max_distance: float = 20.0   # Maximum distance from the pivot

var distance: float = 10.0  # Current distance from the pivot

var mouse_pressed: bool = false
var last_mouse_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Initialize the distance based on the camera's initial position
	var camera: Camera3D = $Camera3D
	#prints(camera.get_method_list())
	#distance = -camera.transform.origin.z
	
	# distance = camera.transform.origin.length()
	# prints("distance", distance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		prints("event key", event)
		if Input.is_key_pressed(KEY_LEFT):
			var rotation_angle: float = 10.0  # Degrees
			rotate_y(deg_to_rad(rotation_angle))
		if Input.is_key_pressed(KEY_RIGHT):
			var rotation_angle: float = -10.0  # Degrees
			rotate_y(deg_to_rad(rotation_angle))
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				mouse_pressed = true
				last_mouse_position = event.position # stores the initial mouse position
			else:
				mouse_pressed = false
	
	if event is InputEventMouseMotion and mouse_pressed:
		var mouse_delta: Vector2 = event.position - last_mouse_position
		
		if abs(mouse_delta.x) > 0:
			rotate_y(deg_to_rad(-mouse_delta.x * rotation_speed * 0.1))
		
		last_mouse_position = event.position
			#rotate_y(deg_to_rad((-event.relative.x * rotation_speed)))
			#var vertical_rotation: float = deg_to_rad(-event.relative.y * rotation_speed)
			#var new_rotation_x: float = $Camera3D.rotation_degrees.x + rad_to_deg(vertical_rotation)
			#
			## Limit vertical rotation to prevent flipping the camera
			#if new_rotation_x > -80.0 and new_rotation_x < 80.0:
				#$Camera3D.rotate_x(vertical_rotation)
	
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			#distance -= zoom_speed * get_process_delta_time()
		#elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#distance += zoom_speed * get_process_delta_time()
		
		update_camera_position()

func update_camera_position() -> void:
	# Clamp the distance to stay within min and max bounds
	distance = clamp(distance, min_distance, max_distance)
	prints("new distance", distance)
	var camera: Camera3D = $Camera3D
	var x: float = camera.transform.origin.x
	var y: float = camera.transform.origin.y
	camera.transform.origin = Vector3(x, y, distance)
