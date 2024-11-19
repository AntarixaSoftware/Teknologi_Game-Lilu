extends Node3D  # atau tipe node root lainnya

func _ready():
	print("Scene ready, applying saved state...")
	var saved_state = GameState.load_state()
	if saved_state.has("player_position"):
		var player = get_node("Main Character")
		if player:
			print("Setting player position to:", saved_state["player_position"])
			player.global_transform.origin = saved_state["player_position"]
