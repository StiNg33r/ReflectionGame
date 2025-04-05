extends State



@onready var body: CharacterBody2D = $"../.."
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_timer = $"../../AttackTimer"
@onready var controller: EnemyController = $"../Imp_controller"
var is_attacking = false
var bullet = preload("res://Scenes/bullet.tscn")
var player_pos: Vector2
var direction: Vector2
var speed = 60.0
var distance: float
var level
func _ready() -> void:
	
	Global.player_pos.connect(_on_player_pos_update)

func enter():
	#attack_timer.start(2)
	#is_attacking = true
	#level = Global.level
	controller.emit_signal("attack_on_signal")
	anim.play("Run")


func exit():
	pass
	#is_attacking = false
	#attack_timer.stop()


func update(delta: float) -> void:
	distance = (player_pos - body.global_position).length()
	if distance < 50:
		transition(self, "Idle")
	

func physics_update(delta: float) -> void:
	body.velocity = direction * speed
func _on_player_pos_update(pos: Vector2):
	player_pos = pos
	direction = (player_pos - body.global_position).normalized()


#func _on_attack_timer_timeout() -> void:
	#var new_bullet = bullet.instantiate()
	#new_bullet.global_position = body.global_position
	#new_bullet.direction = direction
	#new_bullet.target_group = "player"
	#level.add_child(new_bullet)
