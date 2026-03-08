extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		 # Save the current position and fog state to the Global singleton
		Global.last_checkpoint_pos = global_position
		# If your fog script has a 'position' or 'progress' variable, save it here
		var fog_node = get_tree().get_first_node_in_group("fog")
		if fog_node:
			Global.fog_save_offset = fog_node.get_node("AnimationPlayer").current_animation_position
			#animated_sprite.play("activated")
			print("Checkpoint saved!")
