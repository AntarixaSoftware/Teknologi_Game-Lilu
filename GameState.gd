extends Node

var main_scene_state = {}
var entered : bool = false

func save_state(player_position : Vector3, current_scene_name : String):
	main_scene_state["player_position"] = player_position
	main_scene_state["current_Scene_name"] = current_scene_name
	
func load_state() -> Dictionary:
	return main_scene_state
