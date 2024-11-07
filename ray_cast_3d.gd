extends RayCast3D

@onready var main_character: CharacterBody3D = $"../../.."

func _process(_delta):
	if is_colliding():
		var collide = get_collider()
		if collide.has_method("interact") && Input.is_action_just_pressed("interact"):
			collide.interact()
			if collide is StaticBody3D and collide.name == "keys" :
				collide.collect()
				main_character.add_to_inventory("key")
				main_character.print_inventory()
			if collide is StaticBody3D and collide.name == "keys2" :
				collide.collect()
				main_character.add_to_inventory("key")
				main_character.print_inventory()
			if collide is StaticBody3D and collide.name == "kuyang" :
				collide.collect()
				main_character.add_to_inventory("kuyang")
				main_character.print_inventory()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
