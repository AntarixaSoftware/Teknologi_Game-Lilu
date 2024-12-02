extends AudioState

@export var run_audio: AudioStream

func Enter():
	if audio_player:
		audio_player.stream = run_audio
		audio_player.play()

func Update(delta: float, is_running: bool, is_moving: bool):
	if not is_moving:
		emit_signal("Transitioned", "audioidle")
	elif not is_running:
		emit_signal("Transitioned", "audiowalk")
