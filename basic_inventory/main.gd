extends Node3D  # atau tipe node root lainnya

func _ready():
	var saved_state = GameState.load_state()
	if saved_state.has("player_position"):
		var last_position = saved_state["player_position"]
		
		last_position.x -= 0.1
		last_position.z -= 0.1
		
		var player = get_tree().current_scene.get_node("Main Character")
		if player:
			player.global_transform.origin = last_position
			print("Player position updated to:", last_position)
		else:
			print("Error: Player node tidak ditemukan di main scene.")
