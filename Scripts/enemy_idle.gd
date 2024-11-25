extends State
class_name EnemyIdle

@export var enemy: CharacterBody3D
@export var move_speed := 5
@export var detection_range := 10.0  # Distance to detect player and switch to follow state
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

		var random_angle = randf_range(-PI, PI)
		var rotation_matrix = Basis(Vector3.UP, random_angle)
		move_direction = (rotation_matrix * Vector3(0, 0, -1)).normalized()


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
		pause_time -= delta
		
		return
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
		$"../../AnimationPlayer".play("Idle")
		

func Physics_Update(_delta: float):
	# Movement logic
	if pause_time <= 0:
		if enemy:
			enemy.velocity = move_direction * move_speed
			$"../../AnimationPlayer".play("Walk")
			if move_direction.length() > 0.01:
				enemy.look_at(enemy.global_transform.origin + move_direction, Vector3.UP)
	else:
		enemy.velocity = Vector3.ZERO
