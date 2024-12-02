extends WorldEnvironment
@onready var flashlight = $"../Main Character/Head/Camera3D/SpotLight3D"

func _process(float) -> void:
	if flashlight.visible == false:
		self.queue_free()
	else:
		if flashlight.visible == true:
			self.get_tree()
