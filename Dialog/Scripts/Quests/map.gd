extends Control

@onready var map_control = $"."
@export var quest: Quest
@export var map_sound: AudioStreamPlayer
@export var wayafter : Node3D
var is_map_visible = false
var has_puzzle = false

func _ready():
	map_control.visible = false

func _input(event):
	if event.is_action_pressed("map"):
		toggle_map()

func toggle_map():
	if QuestGlobal.has_puzzle:
		is_map_visible = !is_map_visible
		map_control.visible = is_map_visible
		if map_sound:
			map_sound.play()
	else :
		print("complete the puzzle!")
