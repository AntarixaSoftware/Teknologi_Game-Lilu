extends Control

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_button_pressed():
	resume()


func _on_restart_button_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_setting_button_pressed():
	pass # Replace with function body.


func _on_main_menu_button_pressed():
	pass # Replace with function body.

func _process(delta):
	testEsc()
