extends PlayerState


@export var player: CharacterBody2D
@export var anim: AnimationPlayer
var speed = 100.0
var direction: Vector2

func enter():
	anim.play("Run")
	

func input_update(event: InputEvent):
	pass
	#direction = Input.get_vector("left","right","up","down")

func physics_update(delta: float):
	direction = Input.get_vector("left","right","up","down")
	if direction:
		player.velocity = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)
		player.velocity.y = move_toward(player.velocity.y, 0, speed)
	if player.velocity == Vector2(0,0) and !direction:
		transition(self, "Idle")
		return
		

func exit():
	pass
