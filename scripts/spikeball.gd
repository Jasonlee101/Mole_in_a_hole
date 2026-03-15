extends Node2D

@export_enum("UpDown", "LeftRight") var spikeball_type: String = "UpDown"
const SPEED = 60

var direction = -1
@onready var ray_cast_1 = $RayCast1
@onready var ray_cast_2 = $RayCast2

func _ready():
	# Ensure they are active
	ray_cast_1.enabled = true
	ray_cast_2.enabled = true
	
	if spikeball_type == "LeftRight":
		# Point Ray 1 Left, Ray 2 Right
		ray_cast_1.target_position = Vector2(-15, 0)
		ray_cast_2.target_position = Vector2(15, 0)
	else:
		# Point Ray 1 Up, Ray 2 Down
		ray_cast_1.target_position = Vector2(0, -15)
		ray_cast_2.target_position = Vector2(0, 15)

func _process(delta):
	# Detection Logic: Only switch if we hit something in our current path
	if direction == -1 and ray_cast_1.is_colliding():
		direction = 1
	elif direction == 1 and ray_cast_2.is_colliding():
		direction = -1

	if spikeball_type == "UpDown":
		position.y += direction * SPEED * delta
	else:
		position.x += direction * SPEED * delta
