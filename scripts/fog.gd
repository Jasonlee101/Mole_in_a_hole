extends Node2D

@export var speed = 15.0  # How fast the fog descends
var is_active = false

func _process(delta):
	if is_active:
		# Move the fog downwards
		position.y += speed * delta

func activate():
	is_active = true
