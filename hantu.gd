extends CharacterBody3D

enum HantuState {IDLE, PATROL, APPROACH, ATTACK}
var state = HantuState.IDLE
var prev_state = HantuState.IDLE

var flashlight_on = true
const APPROACH_DISTANCE = 20.0
const ATTACK_DISTANCE = 1.5

const PATROL_SPEED = 2.0
const APPROACH_SPEED = 7.0
const ACCEL = APPROACH_SPEED * 1.75

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var target: Marker3D = $"../Main Character/Marker3D"

var patrol_positions = [Vector3(10, 0, 10), Vector3(-10, 0, 10), Vector3(-10, 0, -10), Vector3(10, 0, -10)]
var cur_patrol = 0

const ATTACK_CD = 1.0
var timer_attack = 0.0
const DAMAGE = 25.0

var is_paused = false
var timer_pause = 0.0
var target_rotation = Vector3()
const rotation_speed = 0.5

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
			if prev_state == HantuState.PATROL:
				_hantu_pause(main_character)
			state = HantuState.APPROACH
		else:
			state = HantuState.PATROL
	else:
		if distance > APPROACH_DISTANCE:
			state = HantuState.IDLE
		else:
			state = HantuState.PATROL
		
	match state:
		HantuState.IDLE:
			velocity = Vector3.ZERO
			prev_state = HantuState.IDLE
			
		HantuState.PATROL:
			is_paused = false
			prev_state = HantuState.PATROL
			nav.target_position = patrol_positions[cur_patrol]
			var patrol_direction = nav.get_next_path_position() - global_transform.origin
			patrol_direction = patrol_direction.normalized()
			velocity = velocity.lerp(patrol_direction * PATROL_SPEED, ACCEL * delta )
			
			if global_transform.origin.distance_to(patrol_positions[cur_patrol]) < 2.0:
				cur_patrol = (cur_patrol + 1) % patrol_positions.size()
				
		HantuState.APPROACH:
			if is_paused:
				velocity = Vector3.ZERO
				_rotate_to_target(delta)
				timer_pause -= delta
				if timer_pause <= 0:
					is_paused = false
			else:
				nav.target_position = target.global_transform.origin
				var direction = nav.get_next_path_position() - global_transform.origin
				direction = direction.normalized()
				velocity = velocity.lerp(direction * APPROACH_SPEED, ACCEL * delta)
			prev_state = HantuState.APPROACH
			
		HantuState.ATTACK:
			velocity = Vector3.ZERO
			_attack_player(delta, main_character)
			
	move_and_slide()

func _attack_player(delta: float, main_character):
	timer_attack -= delta
	if timer_attack <= 0:
		main_character.take_damage(DAMAGE)
		print("kena damage")
		timer_attack = ATTACK_CD

func _hantu_pause(main_character):
	is_paused = true
	target_rotation = (main_character.global_transform.origin - global_transform.origin).normalized()
	
	var cur_direction = -global_transform.basis.z.normalized()
	var angle_to_target = cur_direction.angle_to(target_rotation)
	timer_pause = angle_to_target / rotation_speed
	
func _rotate_to_target(delta: float):
	print("rotating to target..")
	var cur_direction = -global_transform.basis.z.normalized()
	var angle_to_target = cur_direction.angle_to(target_rotation)
	if angle_to_target > 0.01:
		var rotation_step = min(rotation_speed * delta, angle_to_target)
		var new_direction = cur_direction.slerp(target_rotation, rotation_step / angle_to_target)
		look_at(global_transform.origin + new_direction)
		
