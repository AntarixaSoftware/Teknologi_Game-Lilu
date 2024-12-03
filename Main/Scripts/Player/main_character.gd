extends CharacterBody3D

var speed 
const WALK_SPEED = 3.0
const SPRINT_SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.003
var gravity = 9.8
var health = 100
#bobbing variable
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

@onready var flashlight = $Head/Camera3D/SpotLight3D
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var anim = $Head/Camera3D/AnimationPlayer
@onready var walk_sound = $"Walking-soundscape-200112"
@onready var run_sound = $"Running-on-concrete-268478"
@onready var on = $On
@onready var off = $Off
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$"../PauseMenu".mouse_filter = Control.MOUSE_FILTER_IGNORE

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
	#if event.is_action_pressed("esc"):
		#$"../PauseMenu".pause()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if run_sound.is_playing() or walk_sound.is_playing() :
			run_sound.stop()
			walk_sound.stop()
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
		
	if Input.is_action_just_pressed("flashlight"):
		if flashlight.visible == true:
			if not off.is_playing():
				off.play()
			flashlight.visible = false
		else:
			if not on.is_playing():
				on.play()
			flashlight.visible = true
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction.length() > 0:  
			if Input.is_action_pressed("sprint"):  # Pemain berlari
				if not run_sound.is_playing():
					walk_sound.stop()
					run_sound.play()
			else:  # Pemain berjalan
				if not walk_sound.is_playing():
					run_sound.stop()
					walk_sound.play()
		else:  # Karakter diam
			walk_sound.stop()
			run_sound.stop()
			
		if direction:
			if !walk_sound :
				walk_sound.play()
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			if walk_sound :
				walk_sound.stop()
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
	
func take_damage(amount: int):
	health -= amount
	print("Player took", amount, "damage. Health:", health)
	if health <= 0:
		_die()
		
	if anim and anim.has_animation("Blood"):
		anim.play("Blood")

func _die():
	print("Player has died!")
	# Exit the game when the player dies
	get_tree().quit()
