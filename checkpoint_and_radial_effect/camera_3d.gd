extends Camera3D

@onready var main_character: CharacterBody3D = $"../.."
@onready var anim = $AnimationPlayer

func _ready() -> void:
	pass # Replace with function body.

func take_damage(event):
	anim.play("Blood")
