extends Area3D

signal display3
@export var quest: Quest
@export var waybefore : Node3D
@export var wayafter: Node3D
@export var quest_dialog: Quest
@onready var dialog = $"../../../Dialogs/Dialog3/RichTextLabel"

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		if body.name == "Main Character":
			if quest.quest_status == quest.QuestStatus.started:
				waybefore.erase()
				quest.reached_goal()
				await get_tree().create_timer(2.0).timeout
				if quest.quest_status == quest.QuestStatus.reached_goal:
					quest.finished_quest()
					
			if quest_dialog.quest_status == quest_dialog.QuestStatus.started:
				emit_signal("display3")
				quest_dialog.reached_goal()
				await get_tree().create_timer(10.0).timeout
				if quest_dialog.quest_status == quest_dialog.QuestStatus.reached_goal:
					quest_dialog.finished_quest()
					dialog.visible = false
					wayafter.spawn()
