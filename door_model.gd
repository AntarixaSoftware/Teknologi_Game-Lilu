extends StaticBody3D

var toggle = false
var interactable = true
@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var door_message = $"../../DoorMessage"
@export var player : CharacterBody3D

func interact():
	var area3d = player.get_node("InteractionArea")
	
	if area3d.has_key :
		if interactable == true:
			interactable = false
			toggle = !toggle
			
			if toggle == false:
				animation.play("Close")
			if toggle == true:
				animation.play("Open")
				show_door_message("Door Unlocked!")

			await get_tree().create_timer(1.0, false).timeout
			interactable = true
	else :
		show_door_message("The door needs a key!")

func show_door_message(message: String):
	door_message.text = message
	door_message.visible = true
	
	await get_tree().create_timer(2.0).timeout
	door_message.visible = false
