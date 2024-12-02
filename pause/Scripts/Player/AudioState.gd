extends Node
class_name AudioState

signal Transitioned(new_state_name: String)

@export var audio_player: AudioStreamPlayer

func Enter():
	# Override this to define behavior when entering the state
	pass

func Exit():
	# Override this to define behavior when exiting the state
	pass

func Update(_delta: float, _is_running: bool, _is_moving: bool):
	# Override this for per-frame state updates
	pass
