extends StateMachine

@onready var body: Enemy = $".."

func _ready() -> void:
	super._ready()
	body.got_damage.connect(_on_got_damage)


func _on_got_damage():
	on_transition(current_state, "Run")
