extends Area2D
@onready var game_manager: Node = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	var death = body.dead
	if not death: 
		Stats.score += 1
		animation_player.play("pickup")
