extends Area3D

signal display
@export var quest: Quest
@onready var dialog = $"../../Dialog/RichTextLabel"
@export var quest_dialog : Quest

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		if body.name == "Main Character":
			if quest.quest_status == quest.QuestStatus.started:
				quest.reached_goal()
				await get_tree().create_timer(2.0).timeout
				if quest.quest_status == quest.QuestStatus.reached_goal:
					quest.finished_quest()
			
			if quest_dialog.quest_status == quest_dialog.QuestStatus.started:
				emit_signal("display")
				quest_dialog.reached_goal()
				await get_tree().create_timer(3.0).timeout
				if quest_dialog.quest_status == quest_dialog.QuestStatus.reached_goal:
					quest_dialog.finished_quest()
					dialog.visible = false
