extends Area2D

@export_enum("1", "2", "3", "4", "5", "6", "7", "8") var auto_play_anim: String = "move_hint"
@onready var bubble = $InstructionBubble

func _ready():
	bubble.modulate.a = 0
	bubble.play(auto_play_anim)

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		fade_bubble(1.0)

func _on_body_exited(body):
	if body.is_in_group("player"):
		fade_bubble(0.0) # Fade out

func fade_bubble(target_alpha: float):
	var tween = create_tween()
	tween.tween_property(bubble, "modulate:a", target_alpha, 0.3).set_trans(Tween.TRANS_SINE)

	if target_alpha > 0:
		var float_tween = create_tween().set_loops()
		float_tween.tween_property(bubble, "position:y", -35, 1)
		float_tween.tween_property(bubble, "position:y", -30 , 1)
