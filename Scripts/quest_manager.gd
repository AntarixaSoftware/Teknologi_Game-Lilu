class_name QuestManager extends Node2D

@onready var QuestBox : CanvasLayer = GameManager.get_node('QuestBox')
@onready var QuestTitle : RichTextLabel = GameManager.get_node('QuestBox').get_node('QuestName')
@onready var QuestDescripton : RichTextLabel = GameManager.get_node('QuestBox').get_node('QuestDesc')

@export_group("Quest Settings")
@export var quest_name : String
@export var quest_desc : String
@export var reached_goal_text : String

var current_quest_index: int = 0
var quests: Array = []

enum QuestStatus{
	available,
	started,
	reached_goal,
	finished,
}
@export var quest_status : QuestStatus = QuestStatus.available

func _ready():
	var quest1 = get_tree().root.get_node("Main Scene/House/house_area/house")
	var quest2 = get_tree().root.get_node("Main Scene/Map/Puzzle")
	quests.append(quest1)
	quests.append(quest2)
	await get_tree().create_timer(2.0).timeout
	start_first_quest()

func start_first_quest():
	if quests.size() > 0:
		quests[current_quest_index].start_quest()

func next_quest():
	if current_quest_index < quests.size() - 1:
		current_quest_index += 1
		quests[current_quest_index].start_quest()
