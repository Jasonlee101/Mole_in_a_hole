extends Area2D

@export_multiline var dialogue_text: String = "Replace this text in the inspector!"

@onready var canvas_layer = $CanvasLayer
@onready var label = $CanvasLayer/Label

func _ready() -> void:
	canvas_layer.hide()
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not get_tree().paused:
		label.text = dialogue_text
		canvas_layer.show()
		get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if get_tree().paused and canvas_layer.visible:
		if event.is_action_pressed("interact"):
			get_tree().paused = false
			queue_free() 
			get_viewport().set_input_as_handled()
