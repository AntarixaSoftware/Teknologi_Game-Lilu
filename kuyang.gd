extends StaticBody3D

var toggle = false
var interactable = true

@onready var chara : CharacterBody3D = $"../Main Character"

func interact():
	if interactable == true:
		interactable = false
		toggle = !toggle
		if toggle == true:
			queue_free()
		await get_tree().create_timer(1.0, false).timeout
		interactable = true

func collect():
	queue_free()
