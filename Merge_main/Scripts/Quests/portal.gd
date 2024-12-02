extends Area3D

@export var alam_lain_path : String = "res://Main_Branch/Scenes/alam_lain.tscn"
@export var main_scene : Node
@export var quest : Quest
@export var portal : AudioStreamPlayer
func _on_body_entered(body):
	if body.name == "Main Character" and not GameState.entered:
		if portal:
			portal.play()
		GameState.save_state(body.global_transform.origin, get_tree().current_scene.name)
		if quest.quest_status == quest.QuestStatus.started:
			quest.reached_goal()
			await get_tree().create_timer(5.0).timeout
			if quest.quest_status == quest.QuestStatus.reached_goal:
				quest.Stop()
				await get_tree().create_timer(1.0).timeout
		
		
		call_deferred("change_scene_to_alam_lain")
	else:
		print("udah masuk")
		
func change_scene_to_alam_lain():
	var new_scene = load(alam_lain_path) as PackedScene
	get_tree().change_scene_to_packed(new_scene)
