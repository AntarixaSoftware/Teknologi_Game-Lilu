extends Control

@onready var map_control = $"."
var is_map_visible = false

func _ready():
	map_control.visible = false
	var player_interaction = get_node("/root/Main Character/InteractionArea")  # Ganti sesuai path


func _input(event):
	if event.is_action_pressed("map"):
		
		toggle_map()

func toggle_map():
	is_map_visible = !is_map_visible
	map_control.visible = is_map_visible
	
	
	
