extends State
class_name EnemyIdle

@export var enemy: CharacterBody3D
@export var move_speed := 5
@export var detection_range := 10.0  # Distance to detect the player
@export var wander_area_min: Vector3 = Vector3(-10, 0, -10)  # Minimum corner of the area
@export var wander_area_max: Vector3 = Vector3(10, 0, 10)    # Maximum corner of the area
@onready var Enemy: CharacterBody3D = $"../.."

var move_direction: Vector3
var wander_time: float
var pause_time: float
var player: CharacterBody3D = null

func randomize_wander():
	if Enemy.is_on_floor():
		pause_time = randf_range(0, 2)
		wander_time = randf_range(1, 3)
		move_direction = Vector3.ZERO

		# Randomize movement direction
		var random_angle = randf_range(-PI, PI)
		var rotation_matrix = Basis(Vector3.UP, random_angle)
		move_direction = (rotation_matrix * Vector3(0, 0, -1)).normalized()

		# Ensure new position stays within bounds
		var new_position = enemy.global_position + (move_direction * move_speed * wander_time)
		if not is_within_bounds(new_position):
			move_direction = -move_direction  # Reverse direction to stay within bounds

func is_within_bounds(position: Vector3) -> bool:
	# Check if position is within the defined wander area
	return position.x >= wander_area_min.x and position.x <= wander_area_max.x \
		and position.z >= wander_area_min.z and position.z <= wander_area_max.z

func Enter():
	randomize_wander()
	player = get_tree().get_first_node_in_group("Player")  # Get the player instance
	if player == null:
		print("Error: No player found in 'Player' group!")

func Update(delta: float):
	# Check if player is nearby
	if player and player.global_position.distance_to(Enemy.global_position) <= detection_range:
		print("Player detected! Transitioning to EnemyFollow.")
		Transitioned.emit(self, "enemyfollow")  # Emit signal to transition
		return

	# Wander logic
	if pause_time > 0:
		$"../../AnimationPlayer".play("Idle")
		pause_time -= delta
		return
	if wander_time > 0:
		$"../../AnimationPlayer".play("Walk")
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(_delta: float):
	# Movement logic
	if pause_time <= 0:
		if enemy:
			enemy.velocity = move_direction * move_speed
			if move_direction.length() > 0.01:
				enemy.look_at(enemy.global_transform.origin + move_direction, Vector3.UP)
	else:
		enemy.velocity = Vector3.ZERO
