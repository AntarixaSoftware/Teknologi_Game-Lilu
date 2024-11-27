extends Node2D

@onready var key_icon = $CanvasLayer/Key
@onready var key_label = $CanvasLayer/keylabel
@onready var puzzle_icon = $CanvasLayer/Puzzle
@onready var puzzle_label = $CanvasLayer/puzzlelabel

var key_count: int = 0 
var max_puzzle = 4
var collected_puzzles : int = 0 

func _ready():
	key_icon.visible = false
	key_label.visible = false
	update_ui()

func update_ui():
	if key_count > 0:
		key_icon.visible = true
		key_label.visible = true
		key_label.text = str(key_count)
	else:
		key_icon.visible = false
		key_label.visible = false
		puzzle_icon.visible = false
		puzzle_label.visible = false
	if collected_puzzles > 0:
		if collected_puzzles == max_puzzle:
			puzzle_icon.visible = true
			puzzle_label.visible = true
			puzzle_label.text = str(collected_puzzles) + "/" + str(max_puzzle)
			await get_tree().create_timer(2.0).timeout
			puzzle_icon.visible = false
			puzzle_label.visible = false
		else:
			puzzle_icon.visible = true
			puzzle_label.visible = true
			puzzle_label.text = str(collected_puzzles) + "/" + str(max_puzzle)


func collect_key():
	key_count += 1
	update_ui()

func collect_puzzle():
	collected_puzzles += 1
	update_ui()
