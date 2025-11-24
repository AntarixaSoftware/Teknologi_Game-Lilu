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
	QuestGlobal.connect("main_scene_loaded", Callable(self, "_on_main_scene_loaded"))
	if GameState.entered:
		print("kntl")
		init()

func _on_main_scene_loaded():
	await get_tree().create_timer(1.0).timeout
	init()

func init():
	var pz1_node = get_tree().root.get_node("Main Scene/Story/Items/Pz1")
	var pz2_node = get_tree().root.get_node("Main Scene/Story/Items/Pz2")
	var pz3_node = get_tree().root.get_node("Main Scene/Story/Items/Pz3")
	var pz4_node = get_tree().root.get_node("Main Scene/Story/Items/Pz4")
	var key_node = get_tree().root.get_node("Main Scene/Story/Items/Key")
	var quest1 = get_tree().root.get_node("Main Scene/Story/Quests/Accident/Accident_area/accident")
	var quest2 = get_tree().root.get_node("Main Scene/Story/Dialogs/Dialog/dialog")
	var quest3 = get_tree().root.get_node("Main Scene/Story/Quests/Cemetry/cemetry_area/cemetry")
	var quest4 = get_tree().root.get_node("Main Scene/Story/Dialogs/Dialog2/dialog2")
	var quest5 = get_tree().root.get_node("Main Scene/Story/Quests/CemetryItem/cemetryitem")
	var quest6 = get_tree().root.get_node("Main Scene/Story/Quests/DeepForest/forest/forest")
	var quest7 = get_tree().root.get_node("Main Scene/Story/Dialogs/Dialog3/dialog3")
	var quest8 = get_tree().root.get_node("Main Scene/Story/Quests/Backhouse/backhouse/backhouse")
	var quest9 = get_tree().root.get_node("Main Scene/Story/Quests/HouseItem/houseitem")
	var quest10 = get_tree().root.get_node("Main Scene/Story/Dialogs/Dialog4/dialog4")
	var quest11 = get_tree().root.get_node("Main Scene/Story/Quests/Cave/cave/cave")
	var quest12 = get_tree().root.get_node("Main Scene/Story/Dialogs/Dialog5/dialog5")
	var quest13 = get_tree().root.get_node("Main Scene/Story/Quests/CaveItem/caveitem")
	var quest14 = get_tree().root.get_node("Main Scene/Story/Quests/Tree/treearea/tree")
	var quest15 = get_tree().root.get_node("Main Scene/Story/Quests/TreeItem/treeitem")
	var quest16 = get_tree().root.get_node("Main Scene/Story/Quests/Forest/Cabin_area/cabin")
	var quest17 = get_tree().root.get_node("Main Scene/Story/Dialogs/Dialog6/dialog6")
	var quest18 = get_tree().root.get_node("Main Scene/Story/Quests/Cabin/Inside_cabin/InCabin")
	var quest19 = get_tree().root.get_node("Main Scene/Story/Dialogs/Dialog7/dialog7")
	var quest20 = get_tree().root.get_node("Main Scene/Story/Quests/Clue/Clue_area/clue")
	var quest21 = get_tree().root.get_node("Main Scene/Main Character/InteractionArea/key")
	var quest22 = get_tree().root.get_node("Main Scene/Story/Quests/FinalPath/Final/final")
	QuestGlobal.quests.clear()
	QuestGlobal.quests.append(quest1)
	QuestGlobal.quests.append(quest2)
	QuestGlobal.quests.append(quest3)
	QuestGlobal.quests.append(quest4)
	QuestGlobal.quests.append(quest5)
	QuestGlobal.quests.append(quest6)
	QuestGlobal.quests.append(quest7)
	QuestGlobal.quests.append(quest8)
	QuestGlobal.quests.append(quest9)
	QuestGlobal.quests.append(quest10)
	QuestGlobal.quests.append(quest11)
	QuestGlobal.quests.append(quest12)
	QuestGlobal.quests.append(quest13)
	QuestGlobal.quests.append(quest14)
	QuestGlobal.quests.append(quest15)
	QuestGlobal.quests.append(quest16)
	QuestGlobal.quests.append(quest17)
	QuestGlobal.quests.append(quest18)
	QuestGlobal.quests.append(quest19)
	QuestGlobal.quests.append(quest20)
	QuestGlobal.quests.append(quest21)
	QuestGlobal.quests.append(quest22)
	QuestGlobal.items.clear()
	QuestGlobal.items.append(pz1_node)
	QuestGlobal.items.append(pz2_node)
	QuestGlobal.items.append(pz3_node)
	QuestGlobal.items.append(pz4_node)
	QuestGlobal.items.append(key_node)
	await get_tree().create_timer(6.0).timeout
	start_first_quest()

func start_first_quest():
	if QuestGlobal.quests.size() > 0:
		if GameState.entered:
			print(QuestGlobal.current_index)
			if QuestGlobal.current_index == 19:
				QuestGlobal.current_index += 1
				QuestGlobal.items[4].visible = true
		else:
			if QuestGlobal.current_index == 0:
				var firstway = get_tree().root.get_node("Main Scene/Story/Quests/Accident/waypoint")
				await get_tree().create_timer(1.0).timeout
				firstway.spawn()
		QuestGlobal.quests[QuestGlobal.current_index].start_quest()

func next_quest():
	QuestGlobal.current_index += 1
	if QuestGlobal.current_index == 4:
		QuestGlobal.items[0].visible = true
	if QuestGlobal.current_index == 8:
		QuestGlobal.items[1].visible = true
	if QuestGlobal.current_index == 12:
		QuestGlobal.items[2].visible = true
	if QuestGlobal.current_index == 14:		
		QuestGlobal.items[3].visible = true
	QuestGlobal.quests[QuestGlobal.current_index].start_quest()
