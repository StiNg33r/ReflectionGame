extends State

@onready var body: CharacterBody2D = $"../.."
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"
@onready var controller: EnemyController = $"../shaman_controller"
var player_pos: Vector2
var direction: Vector2
var speed = 90.0
var distance: float
var level
func _ready() -> void:
	
	
	Global.player_pos.connect(_on_player_pos_update)
	speed = controller.speed


func enter():
	controller.emit_signal("attack_on_signal")
	anim.play("Run")


func exit():
	pass


func update(delta: float) -> void:
	distance = (player_pos - body.global_position).length()
	if distance > 150:
		transition(self, "Idle")

func physics_update(delta: float) -> void:
	body.velocity = direction * speed



func _on_player_pos_update(pos: Vector2):
	player_pos = pos
	direction = -(player_pos - body.global_position).normalized()
