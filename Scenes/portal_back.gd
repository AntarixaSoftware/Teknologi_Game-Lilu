extends Area3D

@export var main_scene_path : String = "res://main_scene.tscn"

func _on_body_entered(body):
	if body.name == "Main Character":
		call_deferred("load_main_scene")

func load_main_scene() -> void:
	print("Changing to main scene...")
	var main_scene = load(main_scene_path) as PackedScene
	get_tree().change_scene_to_packed(main_scene)
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.1  # Tunggu 100ms
	timer.one_shot = true
	timer.start()
	
	await timer.timeout  # Tunggu hingga Timer selesai
	timer.queue_free()
	
	if get_tree().current_scene == null:
		print("Error: Current scene masih null setelah timer.")
		return
