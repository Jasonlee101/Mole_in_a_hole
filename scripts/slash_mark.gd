extends Sprite2D

@export var slash_textures: Array[Texture2D]

func setup_slash(spawn_offset: Vector2, tint: Color = Color.WHITE):
	region_enabled = false 
	z_index = 100
	
	if slash_textures.size() > 0:
		texture = slash_textures.pick_random() 

	scale = Vector2(1, 1) 

	modulate = tint

	flip_h = spawn_offset.x < 0
	flip_v = spawn_offset.y > 0
	
	var tween = create_tween()
	var travel_pos = global_position + (spawn_offset.normalized() * 6.0) 

	tween.parallel().tween_property(self, "global_position", travel_pos, 0.2)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.2).set_delay(0.2)

	tween.tween_callback(queue_free)
