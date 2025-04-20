extends State

@onready var body: CharacterBody2D = $"../.."
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"
@onready var player_pos_updater: PlayerPosUpdater = $"../../PlayerPosUpdater"

var speed = 20.0
var player_pos: Vector2
var distance: float
func _ready() -> void:
	player_pos_updater.player_pos_updated.connect(_on_player_pos_update)


func enter():
	anim.play("Idle")
	

func update(delta: float) -> void:
	distance = (player_pos - body.global_position).length()
	if distance < 200 and distance > 70:
		transition(self, "Chase")

func physics_update(delta: float) -> void:
	body.velocity.x = move_toward(body.velocity.x, 0, speed)
	body.velocity.y = move_toward(body.velocity.y, 0, speed)

func _on_player_pos_update(pos: Vector2):
	player_pos = pos
