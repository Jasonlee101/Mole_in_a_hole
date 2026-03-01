extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
		
	Engine.time_scale = 0.5
	body.get_node('CollisionShape2D').queue_free()
	var anim = body.get_node("AnimatedSprite2D")
	var death = body.dead
	body.dead = true
	anim.play("death")  
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
