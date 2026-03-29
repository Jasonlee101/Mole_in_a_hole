extends Node

func play(sound_name: String):
	var sound_node = get_node_or_null(sound_name)
	
	if sound_node and sound_node is AudioStreamPlayer2D:
		if sound_node.playing:
			sound_node.stop()

		sound_node.play()
	else:
		printerr("SFX Error: No node named '", sound_name)
