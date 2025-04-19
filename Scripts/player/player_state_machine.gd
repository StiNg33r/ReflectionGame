extends StateMachine
class_name PlayerStateMachine



func _input(event: InputEvent) -> void:
	current_state.input_update(event)
