extends StaticBody3D

var toggle = false
var interactable = true
var message_shown : bool = false
@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var door_message = $"../../DoorMessage"
@onready var Item = $"../../../ItemUi"
@export var player : CharacterBody3D
@export var locked : AudioStreamPlayer

func interact():
	var area3d = player.get_node("InteractionArea")
	
	if area3d.has_key :
		Item.use_key()
		if interactable == true:
			interactable = false
			toggle = !toggle
			
			if toggle == false:
				animation.play("Close")
			if toggle == true:
				animation.play("Open")
				if not message_shown :
					show_door_message("Door Unlocked!", Color(0, 1, 0))
					message_shown = true

			await get_tree().create_timer(1.0, false).timeout
			interactable = true
	else :
		show_door_message("The door needs a key!", Color(1, 0, 0))
		if locked:
			locked.play()

func show_door_message(message: String, color = Color(1, 1, 1)):
	door_message.text = message
	door_message.modulate = color
	door_message.visible = true
	
	await get_tree().create_timer(2.0).timeout
	door_message.visible = false
