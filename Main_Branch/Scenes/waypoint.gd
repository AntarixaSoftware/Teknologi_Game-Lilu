extends Node3D

@export var cam = Camera3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$origin.visible = false
	set_process(false)
	cam = get_viewport().get_camera_3d()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var marker_pos = self.global_transform.origin
	var camera_dir = -cam.global_transform.basis.z
	var to_marker_dir = (marker_pos - cam.global_transform.origin).normalized()
	
	var dot_product = camera_dir.dot(to_marker_dir)
		
	if dot_product > 0:  # Waypoint is in front of the camera
		var screen_pos = cam.unproject_position(marker_pos)
		$origin.visible = true
		$origin.position = screen_pos
	else:  # Waypoint is behind the camera
		$origin.visible = false

func spawn():
	set_process(true)
	$origin.visible = true

func erase():
	set_process(false)
	self.queue_free()
