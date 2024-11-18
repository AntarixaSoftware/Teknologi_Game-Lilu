extends Area3D

signal puzzle_collected(has_puzzle: bool)
@export var ItemTypes : Array[ItemData] = []
@onready var map_message = $MapMessage

var NearbyBodies : Array[InteractableItem]
var has_key : bool = false
var has_puzzle : bool = false

const REQUIRED_PUZZLE_ITEMS = ["Pz1", "Pz2", "Pz3", "Pz4"]
var collected_puzzle_items : Array[String] = []

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
					print("Kunci diambil!!!")
				elif REQUIRED_PUZZLE_ITEMS.has(ItemTypes[i].ItemName):
					AddPuzzleItem(ItemTypes[i].ItemName)
				return
		
		printerr("Item not found")

func AddPuzzleItem(item_name : String):
	if not collected_puzzle_items.has(item_name):
		collected_puzzle_items.append(item_name)
		print("Puzzle item diambil: " + item_name)
		CheckPuzzleCompletion()

func CheckPuzzleCompletion():
	if collected_puzzle_items.size() == REQUIRED_PUZZLE_ITEMS.size():
		has_puzzle = true
		emit_signal("puzzle_collected", has_puzzle)
		map_message.visible = true
		map_message.text = "You can now Access Map! Press M to show Map"
		await get_tree().create_timer(3.0).timeout
		map_message.visible = false

func OnObjectEnteredArea(body : Node3D ):
	if (body is InteractableItem):
		body.GainFocus()
		NearbyBodies.append(body)

func OnObjectExitedArea(body : Node3D):
	if (body is InteractableItem and NearbyBodies.has(body)):
		body.LoseFocus()
		NearbyBodies.remove_at(NearbyBodies.find(body))