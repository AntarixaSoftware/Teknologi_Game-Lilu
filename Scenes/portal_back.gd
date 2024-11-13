extends Area3D

@export var main_scene_path : String = "res://main_scene.tscn"

func _on_body_entered(body):
	if body.name == "Main Character":
		if get_tree().current_scene != null:
			get_tree().current_scene.queue_free()
		
		var main_scene = load(main_scene_path).instantiate()
		get_tree().root.add_child(main_scene)
		
		var saved_state = GameState.load_state()
		
		if saved_state.has("player_position") and main_scene.has_node("Player"):
			var player = main_scene.get_node("Player") as CharacterBody3D
			player.global_transform.origin = saved_state["player_position"]
