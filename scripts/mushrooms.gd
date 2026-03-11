extends AnimatedSprite2D

# This creates a dropdown menu in the Inspector
@export_enum("Small", "Medium", "Large", 'Long BL', "Long BR", 'Long TL', "Long TR") var mushroom_type: String = "Medium"

func _ready():
	# Construct the animation name, e.g., "red_idle"
	var anim_name = mushroom_type
	
	# Play it!
	if sprite_frames.has_animation(anim_name):
		play(anim_name)
	else:
		print("Warning: Animation ", anim_name, " not found!")
