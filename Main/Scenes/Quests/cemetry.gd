extends Area3D

signal display2
@export var quest: Quest
@export var waybefore : Node3D
@export var quest_dialog : Quest
@onready var dialog = $"../../../Dialogs/Dialog2/RichTextLabel"
@export var dialog_sound_player : AudioStreamPlayer

func _on_body_entered(body: Node3D) -> void: # Replace with function body.
	if body is CharacterBody3D:
		if body.name == "Main Character":
			if quest.quest_status == quest.QuestStatus.started:
				waybefore.erase()
				quest.reached_goal()
				await get_tree().create_timer(2.0).timeout
			if quest.quest_status == quest.QuestStatus.reached_goal:
				quest.finished_quest()
			
			if quest_dialog.quest_status == quest_dialog.QuestStatus.started:
				emit_signal("display2")
				quest_dialog.reached_goal()
				if !dialog_sound_player.is_playing():
					dialog_sound_player.play()
				await get_tree().create_timer(31.0).timeout
				if quest_dialog.quest_status == quest_dialog.QuestStatus.reached_goal:
					if dialog_sound_player.is_playing():
						dialog_sound_player.stop()
					quest_dialog.finished_quest()
					dialog.visible = false
					
