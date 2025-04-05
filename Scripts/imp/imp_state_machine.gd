extends StateMachine

@onready var body: Enemy = $".."
@onready var state_change_timer: Timer = $"../StateChangeTimer"

var state_change_cooldown = 0.05
var is_state_change_available = true
func _ready() -> void:
	super._ready()
	body.got_damage.connect(_on_got_damage)


func _on_got_damage():
	on_transition(current_state, "chase")

#func on_transition(state: State, new_state_name: String):
	#if !is_state_change_available:
		#state_change_timer.start(state_change_cooldown)
		#return
	#super.on_transition(state, new_state_name)
	#is_state_change_available = false



func _on_state_change_timer_timeout() -> void:
	is_state_change_available = true
