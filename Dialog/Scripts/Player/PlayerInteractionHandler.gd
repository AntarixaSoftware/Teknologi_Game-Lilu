extends Area3D

signal display4
@export var ItemTypes : Array[ItemData] = []
@export var quest : Quest
@export var quest2 : Quest
@export var quest3 : Quest
@export var quest4 : Quest
@export var quest5 : Quest
@onready var Item = $"../ItemUi"
@export var key_sound: AudioStreamPlayer
@export var puzzle_sound: AudioStreamPlayer
@export var wayafter : Node3D
@export var wayafter2 : Node3D
@export var wayafter3 : Node3D
@export var wayafter4 : Node3D
@export var wayafter5 :Node3D
@export var quest_dialog: Quest
@export var dialog: RichTextLabel

var NearbyBodies : Array[InteractableItem]
var has_key : bool = false





func _input(event : InputEvent) -> void:
	if (event.is_action_pressed("interact")):
		PickupNearestItem()

func PickupNearestItem():
	var nearestItem : InteractableItem = null
	var nearestItemDistance : float = INF
	for item in NearbyBodies:
		if (item.global_position.distance_to(global_position) < nearestItemDistance):
			nearestItemDistance = item.global_position.distance_to(global_position)
			nearestItem = item
	
	if (nearestItem != null):
		nearestItem.queue_free()
		NearbyBodies.remove_at(NearbyBodies.find(nearestItem))
		var itemPrefab = nearestItem.scene_file_path
		for i in ItemTypes.size():
			if (ItemTypes[i].ItemModelPrefab != null and ItemTypes[i].ItemModelPrefab.resource_path == itemPrefab):
				print("Item id:" + str(i) + " ItemName:" + ItemTypes[i].ItemName)
				if ItemTypes[i].ItemName == "Key":
					has_key = true
					if key_sound:
						key_sound.play()
					Item.collect_key()
					if quest.quest_status == quest.QuestStatus.started:
						quest.reached_goal()
						await get_tree().create_timer(3.0).timeout
						if quest.quest_status == quest.QuestStatus.reached_goal:
							quest.finished_quest()
							wayafter5.spawn()
				elif QuestGlobal.REQUIRED_PUZZLE_ITEMS.has(ItemTypes[i].ItemName):
					AddPuzzleItem(ItemTypes[i].ItemName)
					if ItemTypes[i].ItemName == "Pz1":
						if quest2.quest_status == quest.QuestStatus.started:
							quest2.reached_goal()
							await get_tree().create_timer(3.0).timeout
							if quest2.quest_status == quest.QuestStatus.reached_goal:
								quest2.finished_quest()
								wayafter.spawn()
					elif ItemTypes[i].ItemName == "Pz2":
						if quest3.quest_status == quest.QuestStatus.started:
							quest3.reached_goal()
							await get_tree().create_timer(3.0).timeout
							if quest3.quest_status == quest.QuestStatus.reached_goal:
								quest3.finished_quest()
						if quest_dialog.quest_status == quest_dialog.QuestStatus.started:
							emit_signal("display4")
							quest_dialog.reached_goal()
							await get_tree().create_timer(10.0).timeout
							if quest_dialog.quest_status == quest_dialog.QuestStatus.reached_goal:
								quest_dialog.finished_quest()
								dialog.visible = false
								wayafter2.spawn()
					elif ItemTypes[i].ItemName == "Pz3":
						if quest4.quest_status == quest.QuestStatus.started:
							quest4.reached_goal()
							await get_tree().create_timer(3.0).timeout
							if quest4.quest_status == quest.QuestStatus.reached_goal:
								quest4.finished_quest()
								wayafter3.spawn()
					elif ItemTypes[i].ItemName == "Pz4":
						if quest5.quest_status == quest.QuestStatus.started:
							quest5.reached_goal()
							await get_tree().create_timer(3.0).timeout
							if quest5.quest_status == quest.QuestStatus.reached_goal:
								quest5.finished_quest()
								wayafter4.spawn()
				return
		
		printerr("Item not found")

func AddPuzzleItem(item_name : String):
	if not QuestGlobal.collected_puzzle_items.has(item_name):
		QuestGlobal.collected_puzzle_items.append(item_name)
		print("Puzzle item diambil: " + item_name)
		if puzzle_sound:
			puzzle_sound.play()
		Item.collect_puzzle()
		CheckPuzzleCompletion()

func CheckPuzzleCompletion():
	if QuestGlobal.collected_puzzle_items.size() == QuestGlobal.REQUIRED_PUZZLE_ITEMS.size():
		QuestGlobal.has_puzzle = true
		await get_tree().create_timer(3.0).timeout

func OnObjectEnteredArea(body : Node3D ):
	if (body is InteractableItem):
		body.GainFocus()
		NearbyBodies.append(body)

func OnObjectExitedArea(body : Node3D):
	if (body is InteractableItem and NearbyBodies.has(body)):
		body.LoseFocus()
		NearbyBodies.remove_at(NearbyBodies.find(body))
