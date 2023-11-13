extends RigidBody3D
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_direction := Input.get_vector("left", "right", "forward", "backward")
	var formatted_input := Vector3(input_direction.x, 0, input_direction.y)
	apply_central_force(formatted_input * 1200.0 * delta)
