extends RigidBody3D

@export var mouse_sensitivity := 0.005
@export var zoom_sensitivity := 0.5
@export var min_zoom := 0
@export var max_zoom := 10
@export var speed := 2000

@onready var camera_pivot := $CameraPivot
@onready var camera := $CameraPivot/Camera3D

var mouse_input := Vector3.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	var input_direction := Input.get_vector("left", "right", "forward", "backward").normalized()
	var three_dimentional_input := Vector3(input_direction.x, 0, input_direction.y)
	apply_central_force(three_dimentional_input * speed * delta)
	
	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector3.UP * 10)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if not mouse_input == Vector3.ZERO:
		camera_pivot.rotation.x += mouse_input.y
		camera_pivot.rotation.x = clamp(
			camera_pivot.rotation.x,
			deg_to_rad(-90),
			deg_to_rad(90)
		)
		camera_pivot.rotation.y += mouse_input.x
		camera.position.z += mouse_input.z
		camera.position.z = clamp(
			camera.position.z,
			position.z + min_zoom,
			position.z + max_zoom
		)
		mouse_input = Vector3.ZERO


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			mouse_input.x = - event.relative.x * mouse_sensitivity
			mouse_input.y = - event.relative.y * mouse_sensitivity
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			mouse_input.z = zoom_sensitivity
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			mouse_input.z = - zoom_sensitivity
