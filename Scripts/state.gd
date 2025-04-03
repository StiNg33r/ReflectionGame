extends Node2D
class_name State

signal Transitioned(state: State, new_state_name: String)

func enter():
	pass

func exit():
	pass


func update(delta: float):
	pass

func physics_update(delta: float):
	pass

func transition(state: State, new_state_name: String):
	emit_signal("Transitioned", state, new_state_name)
