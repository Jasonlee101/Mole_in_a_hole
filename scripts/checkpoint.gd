extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
var is_active = false

func _ready():
	# On load, check if this is already the active checkpoint
	if Global.has_checkpoint and Global.last_checkpoint_pos == global_position:
		is_active = true
		animated_sprite.play("active") # Jump straight to the looping state
	else:
		animated_sprite.play("inactive")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_active:
		activate_checkpoint()

func activate_checkpoint():
	is_active = true
	# 1. Save the data to Global
	Global.last_checkpoint_pos = global_position
	Global.has_checkpoint = true
	
	var fog_node = get_tree().get_first_node_in_group("fog")
	if fog_node:
		var anim_player = fog_node.get_node("AnimationPlayer")
		Global.fog_save_offset = anim_player.current_animation_position
	
	# 2. Start the "Opening" animation
	animated_sprite.play("activating")
	
	# 3. Wait for it to finish, then switch to the looping "active" state
	# This 'await' pauses this function until the signal is sent
	await animated_sprite.animation_finished
	
	# Safety check: make sure we are still playing the right sequence
	if animated_sprite.animation == "activating":
		animated_sprite.play("active")
