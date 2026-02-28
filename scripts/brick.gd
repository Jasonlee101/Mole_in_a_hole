extends StaticBody2D

@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D

@export var interaction_range: float = 50.0
@onready var player = get_tree().get_first_node_in_group('player')

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("mine"):
		if player == null:
			player = get_tree().get_first_node_in_group("player")
		   
		# 2. Safety Check: Only proceed if player WAS found
		if player != null:
			var distance = global_position.distance_to(player.global_position)
			if distance <= interaction_range:
				timer.start()
				animated_sprite.play('break')
			else:
				print("Too far!")
		else:
			print("Error: No node found in the 'player' group!")


func _on_timer_timeout() -> void:
	queue_free()
