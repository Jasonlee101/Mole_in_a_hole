extends Node2D

@onready var menu_scene: PackedScene = preload("res://scenes/menu.tscn")
@onready var game_scene: PackedScene = preload("res://scenes/game.tscn")

var menu_instance
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Game started, loading title screen...")
	menu_instance = menu_scene.instantiate()
	add_child(menu_instance)
	
	menu_instance.connect("menu_dismissed", Callable(self, "_on_menu_dismissed"))

func _on_menu_dismissed() -> void:
	print("Bootstrap: Signal recieved! Switching to game...")
	if is_instance_valid(menu_instance):
		menu_instance.queue_free()
	
	var game_node = game_scene.instantiate()
	add_child(game_node)
	print("Bootstrap: Game.tcsn should be now visible!")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
