extends Node

var current_state: State
@export var initial_state: State
var states: Dictionary = {}

func _ready():
	# Populate the states dictionary
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)  # Connect correctly
	
	# Set the initial state
	if initial_state:
		current_state = initial_state
		current_state.Enter()

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state: Node, new_state_name: String):
	if state != current_state:
		return  # Ignore if signal is from a non-current state
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("Error: State not found -", new_state_name)
		return

	print("Transitioning from", current_state.name, "to", new_state_name)
	
	current_state.Exit()  # Clean up current state
	current_state = new_state
	current_state.Enter()  # Initialize new state
