extends Area3D

@export var main_scene_path : String = "res://main_scene.tscn"

func _on_body_entered(body):
	if body.name == "Main Character":
		call_deferred("load_main_scene")

func load_main_scene() -> void:
	var main_scene = load(main_scene_path) as PackedScene
	var saved_state = GameState.load_state()
	print("Saved state: ", saved_state)
	get_tree().change_scene_to_packed(main_scene)
