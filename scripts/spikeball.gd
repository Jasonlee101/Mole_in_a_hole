extends Node2D

# Added "Still" to the dropdown options
@export_enum("UpDown", "LeftRight", "Still") var spikeball_type: String = "UpDown"
const SPEED = 60

var direction = -1
@onready var ray_cast_1 = $RayCast1
@onready var ray_cast_2 = $RayCast2

func _ready():
	# If it's a still spikeball, turn off raycasts and stop here
	if spikeball_type == "Still":
		ray_cast_1.enabled = false
		ray_cast_2.enabled = false
		return 

	# For moving spikeballs, ensure raycasts are active
	ray_cast_1.enabled = true
	ray_cast_2.enabled = true
	
	if spikeball_type == "LeftRight":
		# Point Ray 1 Left, Ray 2 Right
		ray_cast_1.target_position = Vector2(-15, 0)
		ray_cast_2.target_position = Vector2(15, 0)
	elif spikeball_type == "UpDown":
		# Point Ray 1 Up, Ray 2 Down
		ray_cast_1.target_position = Vector2(0, -15)
		ray_cast_2.target_position = Vector2(0, 15)

func _process(delta):
	# If it's a still spikeball, completely skip the movement code
	if spikeball_type == "Still":
		return 

	# Detection Logic: Only switch if we hit something in our current path
	if direction == -1 and ray_cast_1.is_colliding():
		direction = 1
	elif direction == 1 and ray_cast_2.is_colliding():
		direction = -1

	if spikeball_type == "UpDown":
		position.y += direction * SPEED * delta
	elif spikeball_type == "LeftRight":
		position.x += direction * SPEED * delta
