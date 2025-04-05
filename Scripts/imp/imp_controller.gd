extends Node2D
class_name EnemyController


signal attack_on_signal
signal attack_off_signal


@onready var body: CharacterBody2D = $"../.."
@onready var attack_timer: Timer = $"../../AttackTimer"

var is_attacking = false
var bullet = preload("res://Scenes/bullet.tscn")
var speed = 20.0
var player_pos: Vector2
var direction: Vector2
var distance: float
var level

func _ready() -> void:
	
	Global.player_pos.connect(_on_player_pos_update)
	attack_on_signal.connect(attack_on_func)
	attack_off_signal.connect(attack_off_func)


func _on_attack_timer_timeout() -> void:
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = body.global_position
	new_bullet.direction = direction
	new_bullet.target_group = "player"
	level.add_child(new_bullet)


func _on_player_pos_update(pos: Vector2):
	player_pos = pos
	direction = (player_pos - body.global_position).normalized()


func attack_on_func():
	if is_attacking == false:
		attack_timer.start(2)
	level = Global.level
	is_attacking = true
	


func attack_off_func():
	is_attacking = false
	attack_timer.stop
