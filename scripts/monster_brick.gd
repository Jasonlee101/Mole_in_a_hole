extends StaticBody2D 

# This allows you to pick the specific monster node directly from the Inspector
@export var parent_monster: Node2D
@onready var break_sound = $BreakSound
@onready var animation_player = $AnimationPlayer
@onready var animation = $AnimatedSprite2D

func _ready() -> void:
	if parent_monster:
		if parent_monster.has_signal("monster_died"):
			parent_monster.monster_died.connect(_on_parent_monster_died)
		else:
			# Alternative safety check: monitor the node directly if it doesn't have signals
			printerr("Warning: ", parent_monster.name, " is missing the 'monster_died' signal.")
	else:
		printerr("Monster Block Error: No parent monster linked in the Inspector!")

func _on_parent_monster_died() -> void:
	animation.play("break")
	animation_player.play("break")
