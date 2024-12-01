extends CharacterBody3D

enum PlayerState {ALIVE, DEAD}
var player_state = PlayerState.ALIVE

var speed 
const WALK_SPEED = 3.0
const SPRINT_SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003
var gravity = 9.8

#bobbing variable
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

var flashlight_on = true
@onready var flashlight = $Head/Camera3D/SpotLight3D
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var anim = $Head/Camera3D/AnimationPlayer


var spawn_point = Vector3(0,2,0)

const MAX_STAMINA = 100.0
var stamina = MAX_STAMINA
const STAMINA_DEPLETE = 20.0
const STAMINA_RECHARGE = 15.0

var MAX_HEALTH = 100.0
var health = MAX_HEALTH


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	position = spawn_point

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	if player_state == PlayerState.DEAD:
		_go_to_main_menu()
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		velocity.y = 0
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("sprint") and stamina > 0:
		speed = SPRINT_SPEED
		stamina -= STAMINA_DEPLETE * delta
		stamina = max(stamina, 0)
		print("sprinting..")
		if stamina == 0:
			print("habis")
	else:
		speed = WALK_SPEED
		if stamina < MAX_STAMINA:
			stamina += STAMINA_RECHARGE * delta
			stamina = min(stamina, MAX_STAMINA)
			print("recharging..")
			if stamina == MAX_STAMINA:
				print("udah")
				
	if Input.is_action_pressed("dead"):
		kill_player()
		
	if Input.is_action_just_pressed("flashlight"):
		flashlight.visible = !flashlight.visible
		flashlight_on = flashlight.visible

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			# Inersia
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.x * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.x * speed, delta * 3.0)
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov,target_fov, delta * 8.0)
	
	move_and_slide()

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ/2) * BOB_AMP
	return pos

func _go_to_main_menu():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://checkpoint_and_radial_effect/Scenes/main_menu.tscn")
	
func kill_player():
	player_state = PlayerState.DEAD

func take_damage(amount: float) -> void:
	if player_state == PlayerState.ALIVE:
		health -= amount
		health = max(health, 0)
	
	if anim and anim.has_animation("Blood"):
		anim.play("Blood")
	
		if health <= 0:
			kill_player()
