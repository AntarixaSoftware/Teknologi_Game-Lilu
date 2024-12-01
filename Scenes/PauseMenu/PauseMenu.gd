extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var resume_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeButton
@onready var main_menu_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/MainMenuButton
@onready var restart_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/RestartButton


func _ready() -> void:
	resume_button.pressed.connect(unpause)
	main_menu_button.pressed.connect(to_intro)
	restart_button.pressed.connect(restart_game)

func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func pause():
	animator.play("Pause")
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func restart_game():
	print("Restarting the current scene...")
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().reload_current_scene()
	print("Scene restarted successfully.")

func to_intro():
	if not get_tree().paused:
		return
	print("Switching to intro scene...")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Intro/intro.tscn")
	print("Intro scene loaded successfully.")
