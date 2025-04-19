extends Node2D
class_name StateMachine

signal is_active_change(status: bool)

@export var initial_state: State

var is_active = true:
	set(value):
		is_active = value
		set_physics_process(is_active)
		set_process(is_active)
		emit_signal("is_active_change", is_active)

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_transition(state: State, new_state_name: String):
	if !is_active:
		return
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
