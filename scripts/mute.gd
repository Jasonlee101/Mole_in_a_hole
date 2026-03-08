extends CanvasLayer

@onready var button = $TextureButton

func _ready():
	update_icon()
	button.pressed.connect(_on_toggled)
	
func _on_toggled():
	Global.is_muted = !Global.is_muted
	
	AudioServer.set_bus_mute(0, Global.is_muted)
	
	update_icon()
	
func update_icon():
	button.button_pressed = Global.is_muted
