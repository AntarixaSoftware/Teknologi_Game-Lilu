extends RayCast3D

func _process(_delta):
	if is_colliding():
		var collide = get_collider()
		if collide.has_method("interact") && Input.is_action_just_pressed("interact"):
			collide.interact()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
