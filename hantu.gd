extends CharacterBody3D

enum HantuState {PATROL, APPROACH, ATTACK}
var state = HantuState.PATROL

var flashlight_on = true
const APPROACH_DISTANCE = 100.0
const ATTACK_DISTANCE = 1.0

const SPEED = 5.0
const ACCEL = SPEED * 1.75

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var target: Marker3D = $"../Main Character/Marker3D"

var patrol_positions = [Vector3(10, 0, 10), Vector3(-10, 0, 10), Vector3(-10, 0, -10), Vector3(10, 0, -10)]
var cur_patrol = 0

func _ready():
	nav.target_position = patrol_positions[cur_patrol]
	
func _physics_process(delta: float) -> void:
	var main_character = $"../Main Character"
	flashlight_on = main_character.flashlight_on
	
	var distance = global_transform.origin.distance_to(target.global_transform.origin)
	
	if flashlight_on:
		if distance < ATTACK_DISTANCE:
			state = HantuState.ATTACK
		elif distance < APPROACH_DISTANCE:
			state = HantuState.APPROACH
		else:
			state = HantuState.PATROL
	
	else:
		state = HantuState.PATROL
		
	match state:
		HantuState.PATROL:
			nav.target_position = patrol_positions[cur_patrol]
			var patrol_direction = nav.get_next_path_position() - global_transform.origin
			patrol_direction = patrol_direction.normalized()
			velocity = velocity.lerp(patrol_direction * SPEED, ACCEL * delta )
			
			if global_transform.origin.distance_to(patrol_positions[cur_patrol]) < 2.0:
				cur_patrol = (cur_patrol + 1) % patrol_positions.size()
				
		HantuState.APPROACH:
			nav.target_position = target.global_transform.origin
			var direction = nav.get_next_path_position() - global_transform.origin
			direction = direction.normalized()
			velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
			
		HantuState.ATTACK:
			velocity = Vector3.ZERO
			
	move_and_slide()
