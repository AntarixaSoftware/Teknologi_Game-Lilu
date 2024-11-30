extends Control

@onready var map_control = $"."
@export var quest: Quest
@export var map_sound: AudioStreamPlayer
@export var wayafter : Node3D
var is_map_visible = false
var has_puzzle = false

func _ready():
	map_control.visible = false
	var player_interaction = get_node("/root/Main Scene/Main Character/InteractionArea")
	player_interaction.connect("puzzle_collected", Callable(self, "_on_puzzle_collected"))

func _on_puzzle_collected(new_value: bool):
	has_puzzle = new_value
	if quest.quest_status == quest.QuestStatus.started:
		quest.reached_goal()
		await get_tree().create_timer(3.0).timeout
		if quest.quest_status == quest.QuestStatus.reached_goal:
			quest.finished_quest()
			wayafter.spawn()

func _input(event):
	if event.is_action_pressed("map"):
		toggle_map()

func toggle_map():
	if has_puzzle:
		is_map_visible = !is_map_visible
		map_control.visible = is_map_visible
		if map_sound:
			map_sound.play()
	else :
		print("complete the puzzle!")
