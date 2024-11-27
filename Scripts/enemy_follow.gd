extends State
class_name EnemyFollow

@export var enemy: CharacterBody3D
@export var move_speed := 5.0
var player: CharacterBody3D = null

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		print("Error: No player found in 'Player' group!")
	else:
		print("Player found: ", player.name)

func Physics_Update(_delta: float):
	if player == null:
		enemy.velocity = Vector3.ZERO
		return
	$"../../AnimationPlayer".play("Run")
	var direction = (player.global_position - enemy.global_position)
	var distance = direction.length()

	# Transition to Attack if close enough
	if distance <= 2.0:  # Replace 2.0 with your desired attack range
		print("Player within attack range, transitioning to EnemyAttack.")
		Transitioned.emit(self, "enemyattack")
		return

	# Continue following the player
	if distance > 2 and distance <= 10:
		enemy.velocity = direction.normalized() * move_speed * 1.1
		enemy.look_at(player.global_position, Vector3.UP)
	else:
		enemy.velocity = Vector3.ZERO

	if distance > 10:
		print("Player out of follow range, transitioning to EnemyIdle.")
		Transitioned.emit(self, "enemyidle")
