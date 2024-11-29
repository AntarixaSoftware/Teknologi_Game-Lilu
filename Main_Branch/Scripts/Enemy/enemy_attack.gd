extends State
class_name EnemyAttack

@export var enemy: CharacterBody3D
@export var attack_range := 1.0  # Distance within which the enemy attacks
@export var attack_cooldown := 1.5  # Time between consecutive attacks
@export var attack_damage : int = 50  # Damage dealt to the player
@onready var player: CharacterBody3D = null

var cooldown_timer: float = 0.0

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	if player == null:
		print("Error: No player found in 'Player' group!")
	else:
		print("Player detected: ", player.name)

	# Initialize cooldown timer
	cooldown_timer = 0.0

func Update(delta: float):
	if player == null:
		Transitioned.emit(self, "enemyidle")  # Transition to idle if no player
		return

	var distance = enemy.global_position.distance_to(player.global_position)

	# Transition back to Follow if player is out of attack range
	if distance > attack_range:
		print("Player out of attack range, transitioning to EnemyFollow.")
		Transitioned.emit(self, "enemyfollow")
		return

	# Reduce cooldown timer
	if cooldown_timer > 0:
		cooldown_timer -= delta

func Physics_Update(_delta: float):
	if player == null or cooldown_timer > 0:
		enemy.velocity = Vector3.ZERO  # Stop moving during cooldown
		return

	# Attack logic
	var _direction = (player.global_position - enemy.global_position).normalized()
	enemy.look_at(player.global_position, Vector3.UP)  # Face the player

	print("Enemy attacks the player!")
	$"../../AnimationPlayer".play("Attack")
	_attack_player()
	
	cooldown_timer = attack_cooldown  # Reset cooldown

func _attack_player():
	# Damage the player or trigger an event
	if player:
		# Add your custom damage logic or call a function on the player
		player.call("take_damage", attack_damage)
		print("Dealt ", attack_damage, " damage to the player.")
