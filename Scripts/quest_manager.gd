class_name QuestManager extends Node2D

@onready var QuestBox : CanvasLayer = GameManager.get_node('QuestBox')
@onready var QuestTitle : RichTextLabel = GameManager.get_node('QuestBox').get_node('QuestName')
@onready var QuestDescripton : RichTextLabel = GameManager.get_node('QuestBox').get_node('QuestDesc')

@export_group("Quest Settings")
@export var quest_name : String
@export var quest_desc : String
@export var reached_goal_text : String


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
		QuestGlobal.quests.clear()
		QuestGlobal.quests.append(quest1)
		QuestGlobal.quests.append(quest2)
		QuestGlobal.quests.append(quest3)
		QuestGlobal.quests.append(quest4)
		QuestGlobal.quests.append(quest5)
		QuestGlobal.quests.append(quest6)
		QuestGlobal.quests.append(quest7)
		QuestGlobal.quests.append(quest8)
		await get_tree().create_timer(2.0).timeout
		start_first_quest()

func start_first_quest():
	if QuestGlobal.quests.size() > 0:
		if GameState.entered:
			if QuestGlobal.current_index == 3:
				QuestGlobal.current_index += 1
				print("kntl")
		QuestGlobal.quests[QuestGlobal.current_index].start_quest()

func next_quest():
	QuestGlobal.current_index += 1
	QuestGlobal.quests[QuestGlobal.current_index].start_quest()
