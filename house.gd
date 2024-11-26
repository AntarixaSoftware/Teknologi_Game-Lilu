extends Area3D

@export var quest: Quest


func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		if body.name == "Main Character" :
			if quest.quest_status == quest.QuestStatus.available:
				quest.start_quest()
				
			if quest.quest_status == quest.QuestStatus.reached_goal:
				quest.finished_quest()
