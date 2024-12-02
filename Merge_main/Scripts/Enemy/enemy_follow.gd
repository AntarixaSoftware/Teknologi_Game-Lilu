extends State
class_name EnemyFollow

@export var enemy: CharacterBody3D
@export var move_speed := 3.0
@export var follow_area_min: Vector3 = Vector3(-10, 0, -10)  # Minimum corner of the area
@export var follow_area_max: Vector3 = Vector3(10, 0, 10)    # Maximum corner of the area

var player: CharacterBody3D = null

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		print("Error: No player found in 'Player' group!")
	else:
		print("Player found: ", player.name)

func Physics_Update(delta: float):
	if player == null:
		enemy.velocity = Vector3.ZERO
		return

	# Calculate direction and distance to player
	var direction = (player.global_position - enemy.global_position)
	var target_position = enemy.global_position + direction.normalized() * move_speed * delta
	var distance = direction.length()

	# Clamp target position within follow boundaries
	#if not is_within_bounds(target_position):
		#print("Player is out of bounds. Staying within the follow area.")
		#target_position = clamp_position_within_bounds(target_position)

	# Move towards the player if within range and bounds
	if distance > 2 and distance <= 10:
		$"../../AnimationPlayer".play("Chase")
		enemy.velocity = (target_position - enemy.global_position).normalized() * move_speed
		enemy.look_at(player.global_position, Vector3.UP)
	else:
		enemy.velocity = Vector3.ZERO

	# Transition back to Idle if player is out of follow range
	if distance > 10:
		print("Player out of follow range, transitioning to EnemyIdle.")
		Transitioned.emit(self, "enemyidle")

#func is_within_bounds(position: Vector3) -> bool:
	# #Check if position is within the defined follow area
	#return position.x >= follow_area_min.x and position.x <= follow_area_max.x \
		#and position.z >= follow_area_min.z and position.z <= follow_area_max.z

func clamp_position_within_bounds(position: Vector3) -> Vector3:
	# Clamp position to stay within the defined bounds
	return Vector3(
		clamp(position.x, follow_area_min.x, follow_area_max.x),
		position.y,  # Y is unchanged for now
		clamp(position.z, follow_area_min.z, follow_area_max.z)
	)
