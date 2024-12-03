extends Node3D

@export var camera: Camera3D  # Kamera untuk memproyeksikan waypoint ke layar

func _ready() -> void:
	# Pastikan kamera sudah diset
	if not camera:
		camera = get_viewport().get_camera_3d()
	if not camera:
		push_error("Tidak ada kamera aktif di viewport!")
		return

func _process(delta: float) -> void:
	if not camera:
		return

	# Posisi waypoint di dunia
	var waypoint_world_position: Vector3 = self.global_transform.origin

	var screen_position: Vector2 = camera.unproject_position(waypoint_world_position)


	var camera_forward: Vector3 = -camera.global_transform.basis.z
	var to_waypoint: Vector3 = (waypoint_world_position - camera.global_transform.origin).normalized()
	var is_in_front: bool = camera_forward.dot(to_waypoint) > 0

	# Update posisi dan visibilitas waypoint
	if is_in_front:
		$origin.visible = true
		$origin.position = screen_position
	else:
		$origin.visible = false
