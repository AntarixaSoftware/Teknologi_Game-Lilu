extends Node3D

func _ready():
	self.visible = false
	$Sprite3D.set_process(false)
# Called when the node enters the scene tree for the first time.
func spawn():
	$Sprite3D.set_process(true)
	self.visible = true
	
func erase():
	$Sprite3D.set_process(false)
	self.queue_free()
