extends RayCast3D

@onready var keys: StaticBody3D = $"../../../../keys"

func _process(_delta):
	if is_colliding():
		var collide = get_collider()
		if collide.has_method("interact") && Input.is_action_just_pressed("interact"):
			collide.interact()
			if collide is StaticBody3D and collide.name == "keys" :
				collide.collect()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
