extends Area2D
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	if Global.fog_save_offset != 0.0:
	# Seek the animation to the exact timestamp where the player saved
		anim_player.play("fog down")
		anim_player.seek(Global.fog_save_offset, true)
