extends CharacterBody3D
class_name Enemy

func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * 1
	move_and_slide()

func _facing_direction():
	return self.direction
