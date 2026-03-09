extends AudioStreamPlayer2D


func  start_music():
	if !playing:
		play()
		print("Music: music started")
		
func stop_muscic():
	stop()
