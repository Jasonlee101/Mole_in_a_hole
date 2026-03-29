extends CanvasLayer

@onready var anim: AnimationPlayer = get_node_or_null("AnimationPlayer")

func play(anim_name: String):
	if anim:
		if anim.has_animation(anim_name):
			anim.play(anim_name)
			await anim.animation_finished
		else:
			printerr("SceneTransition Error: Animation '", anim_name, "' not found!")

func reload_scene():
	await play("death_fade")
	Engine.time_scale = 1
	stats.reset_score()
	get_tree().reload_current_scene()
	play("spawn_fade")
