extends Node2D

@onready var key_icon = $CanvasLayer/Key
@onready var key_label = $CanvasLayer/keylabel
@onready var puzzle_icon = $CanvasLayer/Puzzle
@onready var puzzle_label = $CanvasLayer/puzzlelabel
@onready var puzzle_check = $AnimatedSprite2D

var key_count: int = 0 
var max_puzzle = 4
func _ready():
	key_icon.visible = false
	key_label.visible = false
	puzzle_icon.visible = false
	puzzle_label.visible = false
	puzzle_check.visible = false

func update_ui():
	if QuestGlobal.collected_puzzles > 0:
		if QuestGlobal.collected_puzzles == max_puzzle:
			puzzle_icon.visible = true
			puzzle_label.visible = true
			puzzle_label.text = str(QuestGlobal.collected_puzzles) + "/" + str(max_puzzle)
			puzzle_check.visible = true
			puzzle_check.play("Check")
			await get_tree().create_timer(2.0).timeout
			puzzle_check.visible = false
			puzzle_icon.visible = false
			puzzle_label.visible = false
		else:
			puzzle_icon.visible = true
			puzzle_label.visible = true
			print(QuestGlobal.collected_puzzles)
			puzzle_label.text = str(QuestGlobal.collected_puzzles) + "/" + str(max_puzzle)

func collect_key():
	key_count += 1
	key_icon.visible = true
	key_label.visible = true
	key_label.text = str(key_count)

func use_key():
	key_count = 0
	key_icon.visible = false
	key_label.visible = false

func collect_puzzle():
	QuestGlobal.collected_puzzles += 1
	update_ui()
