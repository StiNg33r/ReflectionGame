extends State

@onready var body: CharacterBody2D = $"../.."
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"
@onready var controller: EnemyController = $"../../Controller"
@onready var player_pos_updater: PlayerPosUpdater = $"../../PlayerPosUpdater"

var player_pos: Vector2
var direction: Vector2
var speed = 90.0
var distance: float
var level
func _ready() -> void:
	
	player_pos_updater.player_pos_updated.connect(_on_player_pos_update)
	speed = controller.move_speed


func enter():
	controller.emit_signal("attack_on_signal")
	anim.play("Run")


func exit():
	pass


func update(delta: float) -> void:
	distance = (player_pos - body.global_position).length()
	if distance < 250:
		transition(self, "Idle")

func physics_update(delta: float) -> void:
	body.velocity = direction * speed



func _on_player_pos_update(pos: Vector2):
	player_pos = pos
	direction = (player_pos - body.global_position).normalized()
