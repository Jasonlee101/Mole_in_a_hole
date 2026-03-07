extends Node2D

const SPEED = 60

var direction = -1

@onready var ray_cast_up = $RayCastUp
@onready var ray_cast_down = $RayCastDown
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	if ray_cast_up.is_colliding():
		direction = 1
	if ray_cast_down.is_colliding():
		direction = -1
	position.y += direction * SPEED * delta 
