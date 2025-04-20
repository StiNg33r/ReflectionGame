extends CharacterBody2D
class_name Enemy



@onready var direction_change_timer: Timer = $DirectionChangeTimer
@onready var damage_player: AnimationPlayer = $DamagePlayer
@onready var death_player: AnimationPlayer = $DeathPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var collider: CollisionShape2D = $CollisionShape2D

signal got_damage
signal died
var damage_multiplier: int = 1
var is_last_enemy: bool = false
var is_alive: bool = true
var health = 3:
	set(value):
		if value < 0:
			value = 0
		health = value
		print("enemy health =", value)


var is_direction_change_available: bool = true
var direction_change_time: float = 0.2

func _ready() -> void:
	add_to_group("enemies")
	Global.emit_signal("enemy_spawned")
	Global.active_enemies_count_changed.connect(_on_enemy_count_change)


func _physics_process(delta: float) -> void:
	if is_direction_change_available:
		if velocity.x > 5:
			sprite.flip_h = false
			direction_change()
		elif velocity.x < -5:
			sprite.flip_h = true
			direction_change()
	move_and_slide()


func get_is_alive() -> bool:
	return is_alive


func full_stop():
	velocity = Vector2(0,0)

func direction_change():
	is_direction_change_available = false
	direction_change_timer.start(direction_change_time)


func get_damage(damage: int):
	health -= damage * damage_multiplier
	emit_signal("got_damage")
	if health <= 0:
		death()
		return
	damage_player.stop()
	damage_player.play("Hit")

func knockback_from_damage():
	pass

func death():
	Global.emit_signal("enemy_died")
	is_alive = false
	state_machine.is_active = false
	collider.set_deferred("disabled", true)
	set_physics_process(false)
	full_stop()
	death_player.play("Death")
	await  death_player.animation_finished
	emit_signal("died")
	queue_free()

func _on_enemy_count_change(enemy_count: int):
	print("from enemy, enemy count: = ", enemy_count)
	if enemy_count == 1:
		is_last_enemy = true
		damage_multiplier *= 2
	elif is_last_enemy:
		damage_multiplier /= 2
		is_last_enemy = false



func _on_direction_change_timer_timeout() -> void:
	is_direction_change_available = true
