extends State

@onready var body: CharacterBody2D = $"../.."
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"
@onready var controller: EnemyController = $"../shaman_controller"
var speed = 20.0
var player_pos: Vector2
var distance: float


func _ready() -> void:
	Global.player_pos.connect(_on_player_pos_update)


func enter():
	anim.play("Idle")
	

func update(delta: float) -> void:
	distance = (player_pos - body.global_position).length()
	#if distance < 200 and distance > 70:
	if distance < 100:
		transition(self, "Run")
	if distance > 300:
		transition(self, "RunToPlayer")
	#if distance > 60:
		#transition(self, "Chase")

func physics_update(delta: float) -> void:
	body.velocity.x = move_toward(body.velocity.x, 0, speed)
	body.velocity.y = move_toward(body.velocity.y, 0, speed)

func _on_player_pos_update(pos: Vector2):
	player_pos = pos
