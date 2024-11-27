class_name Quest extends QuestManager
@export var quest_sound: AudioStreamPlayer

func start_quest() -> void:
	if quest_status == QuestStatus.available:
		quest_status = QuestStatus.started
		QuestBox.visible = true
		QuestTitle.text = quest_name
		QuestDescripton.text = quest_desc
		if quest_sound:
			quest_sound.play()
			
func reached_goal() -> void:
	if quest_status == QuestStatus.started:
		quest_status = QuestStatus.reached_goal
		QuestDescripton.text = reached_goal_text
		
func finished_quest() -> void:
	if quest_status == QuestStatus.reached_goal:
		quest_status = QuestStatus.finished
		QuestBox.visible = false
		Questmanager.next_quest()
