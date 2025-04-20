extends Node2D
class_name EnemyController


signal attack_on_signal
signal attack_off_signal


@onready var body: CharacterBody2D = $".."
@onready var attack_timer: Timer = $AttackTimer
@export var attack_time: float = 2
@export var move_speed: float = 60.0
@export var bullet_speed: float = 200.0
var state_machine: StateMachine
var player_pos_updater: PlayerPosUpdater
var bullet = preload("res://Scenes/bullet.tscn") # пуля
var is_attacking = false
var is_on = true
var player_pos: Vector2
var direction: Vector2
var distance: float
var level

func _ready() -> void:
	state_machine = $"../StateMachine"
	player_pos_updater = $"../PlayerPosUpdater"
	player_pos_updater.player_pos_updated.connect(_on_player_pos_update)
	attack_on_signal.connect(attack_on_func)
	attack_off_signal.connect(attack_off_func)
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	state_machine.is_active_change.connect(state_machine_status)
	

func _on_attack_timer_timeout() -> void: # функция атаки по кд таймера
	print("attack") 
	if !is_on:
		return
	var new_bullet = bullet.instantiate() as Bullet
	new_bullet.global_position = body.global_position + Vector2(10,10) * direction
	new_bullet.direction = direction
	new_bullet.target_group = "player"
	new_bullet.speed = bullet_speed
	level.add_child(new_bullet)


func _on_player_pos_update(pos: Vector2):
	player_pos = pos
	direction = (player_pos - body.global_position).normalized()


func attack_on_func():
	print("attack is on")
	if is_attacking == false:
		attack_timer.start(attack_time)
	level = Global.level
	is_attacking = true
	


func attack_off_func():
	is_attacking = false
	attack_timer.stop()


func state_machine_status(is_active: bool):
	if !is_active:
		is_on = false
		attack_off_func()
