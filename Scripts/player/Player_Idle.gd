extends PlayerState


@export var player: CharacterBody2D
@export var anim: AnimationPlayer

func _ready():
	pass

func input_update(event: InputEvent):
	var direction = Input.get_vector("left","right","up","down")
	if direction:
		transition(self, "Run")

func enter():
	anim.play("Idle")
