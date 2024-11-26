extends Control

@onready var map_control = $"."
var is_map_visible = false
var has_puzzle = false

func _ready():
	map_control.visible = false
	var player_interaction = get_node("/root/Main Scene/Main Character/InteractionArea")
	player_interaction.connect("puzzle_collected", Callable(self, "_on_puzzle_collected"))

func _on_puzzle_collected(new_value: bool):
	has_puzzle = new_value

func _input(event):
	if event.is_action_pressed("map"):
		toggle_map()

func toggle_map():
	if has_puzzle:
		is_map_visible = !is_map_visible
		map_control.visible = is_map_visible
	else :
		print("cari puzzlenya blok")
