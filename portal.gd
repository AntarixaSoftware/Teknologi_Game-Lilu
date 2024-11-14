extends Area3D

@export var alam_lain_path : String = "res://Scenes/alam_lain.tscn"
@export var main_scene : Node 
# Called when the node enters the scene tree for the first time.

	
func _on_body_entered(body):
	if body.name == "Main Character":
		GameState.save_state(body.global_transform.origin, get_tree().current_scene.name)
		
		call_deferred("change_scene_to_alam_lain")

func change_scene_to_alam_lain():
	var new_scene = load(alam_lain_path) as PackedScene
	get_tree().change_scene_to_packed(new_scene)
