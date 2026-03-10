extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var label = $Label
@onready var save_sound = $SaveSound

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
	Global.last_checkpoint_pos = global_position
	Global.has_checkpoint = true
	
	var fog_node = get_tree().get_first_node_in_group("fog")
	if fog_node:
		var anim_player: AnimationPlayer = fog_node.get_node("AnimationPlayer")
		var anim: Animation = anim_player.get_animation("fog down")
		
		var current_time = anim_player.current_animation_position
		var safe_time = current_time
		
		# SETTINGS
		var min_safe_distance = 500.0 # Pixels of gap required
		var time_step = 0.1           # How many seconds to jump back per check
		
		# Get the track index for the Killzone's position
		# (In your fog.tscn, this was track 1)
		var track_idx = anim.find_track("Killzone:position", Animation.TYPE_VALUE)
		
		# LOOP: Keep rewinding time until the distance is safe
		# We use max(0.0, ...) to ensure we don't rewind before the start of the game
		while safe_time > 0.0:
			# Sample the animation to see where the Killzone would be at 'safe_time'
			var fog_pos_at_time = anim.value_track_interpolate(track_idx, safe_time)
			
			# Calculate the vertical distance
			# Note: We compare against the checkpoint's Y
			var dist_y = abs(global_position.y - (fog_node.global_position.y + fog_pos_at_time.y))
			
			if dist_y >= min_safe_distance:
				break # The distance is now safe!
				
			safe_time -= time_step
			
		Global.fog_save_offset = safe_time
		print("Checkpoint: Fog safety rewind applied. New save time: ", safe_time)

	animated_sprite.play("activating")

	show_save_message()
	save_sound.play()

	await animated_sprite.animation_finished
	if animated_sprite.animation == "activating":
		animated_sprite.play("active")

func show_save_message():
	# Reset the label state
	label.modulate.a = 0     # Start fully transparent
	label.visible = true     # Make it exist
	label.position.y = -50   # Starting height
	
	# Create a Tween (Godot's animation tool for code)
	var tween = create_tween()
	
	# Move the label up 20 pixels over 1 second
	tween.tween_property(label, "position:y", -70, 1.0).set_trans(Tween.TRANS_SINE)
	
	# Fade the label in and then out
	# Parallel() means "do this at the same time as the movement above"
	var fade_tween = create_tween()
	fade_tween.tween_property(label, "modulate:a", 1.0, 0.2) # Fade in quick
	fade_tween.tween_interval(0.6)                          # Stay visible
	fade_tween.tween_property(label, "modulate:a", 0.0, 0.2) # Fade out quick
	
	# Hide the label when finished so it doesn't block clicks
	fade_tween.tween_callback(func(): label.visible = false)
