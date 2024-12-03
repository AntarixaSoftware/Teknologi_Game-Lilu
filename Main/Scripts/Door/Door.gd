extends StaticBody3D

var toggle = false
var interactable = true
@onready var animation: AnimationPlayer = $"../AnimationPlayer"

func interact():
	if interactable == true:
		interactable = false
		toggle = !toggle
		
		if toggle == false:
			animation.play("Close")
			$CollisionShape3D2/Doorclose.play()
		if toggle == true:
			animation.play("Open")
			$CollisionShape3D2/Dooropen.play()
		await get_tree().create_timer(1.0, false).timeout
		interactable = true
