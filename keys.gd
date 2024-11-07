extends StaticBody3D

var toggle = false
var interactable = true

@onready var chara : CharacterBody3D = $"../Main Character"

func interact():
	if interactable == true:
		interactable = false
		toggle = !toggle
		if toggle == true:
			self.visible = false
		await get_tree().create_timer(1.0, false).timeout
		interactable = true

func _process(delta: float) -> void:
	var collide = get_collider()
	
func collect():
	chara.add_to_inventory("key")
	queue_free()
	chara.flashlight.visible = false
	print("kontol")
