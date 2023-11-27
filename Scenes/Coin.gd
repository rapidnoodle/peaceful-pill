extends MeshInstance3D

@export var spin_speed := 5

@onready var player := $"../Player"

func _process(delta):
	rotate_y(delta * spin_speed)
	if (position - player.position).length() < 0.5:
		queue_free()
