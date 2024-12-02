extends AudioState

func Enter():
	if audio_player:
		audio_player.stop()

func Update(delta: float, is_running: bool, is_moving: bool):
	if is_moving:
		if is_running:
			emit_signal("Transitioned", "audiorun")
		else:
			emit_signal("Transitioned", "audiowalk")
