extends Node3D

@export var musik : AudioStreamPlayer

func _ready() -> void:
	if musik:
		musik.play()
