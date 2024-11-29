extends Node

var current_state: AudioState
@export var initial_state: AudioState
@onready var states: Dictionary = {}

func _ready():
	# Collect all child states
	for child in get_children():
		if child is AudioState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(_on_state_transition)

	# Set initial state
	if initial_state:
		current_state = initial_state
		current_state.Enter()

func _process(delta: float):
	# Fetch input to determine movement and running states
	var is_moving = Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") \
					or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	var is_running = is_moving and Input.is_action_pressed("sprint")

	# Update the current state
	if current_state:
		current_state.Update(delta, is_running, is_moving)

func _on_state_transition(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		print("State not found:", new_state_name)
		return

	# Transition between states
	if current_state:
		current_state.Exit()
	current_state = new_state
	current_state.Enter()
