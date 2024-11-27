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
	var quest1 = get_tree().root.get_node("Main Scene/Accident/Accident_area/accident")
	var quest2 = get_tree().root.get_node("Main Scene/Forest/Cabin_area/cabin")
	var quest3 = get_tree().root.get_node("Main Scene/Cabin/Inside_cabin/InCabin")
	var quest4 = get_tree().root.get_node("Main Scene/Clue/Clue_area/clue")
	var quest5 = get_tree().root.get_node("Main Scene/Main Character/InteractionArea/key")
	var quest6 = get_tree().root.get_node("Main Scene/Map/Puzzle")
	var quest7 = get_tree().root.get_node("Main Scene/FinalPath/Final/final")
	var quest8 = get_tree().root.get_node("Main Scene/MansionEntrance/Enter/Mansion")
	quests.append(quest1)
	quests.append(quest2)
	quests.append(quest3)
	quests.append(quest4)
	quests.append(quest5)
	quests.append(quest6)
	quests.append(quest7)
	quests.append(quest8)
	
	await get_tree().create_timer(3.0).timeout
	start_first_quest()

func start_first_quest():
	if quests.size() > 0:
		quests[current_quest_index].start_quest()

func next_quest():
	current_quest_index += 1
	quests[current_quest_index].start_quest()
