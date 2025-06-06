extends CharacterBody2D
class_name Player
@onready var sword = $Sword
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var invincibility_timer: Timer = $InvincibilityTimer
@onready var damage_player: AnimationPlayer = $DamagePlayer

var is_alive = true
var max_health: int = 3

var attack_cooldown: float = 0.5
var invincibility_time: float = 3.0
var is_invincible = false
var health: int = 3:
	set(value):
		if value < 0:
			value = 0
		if value > max_health:
			value = max_health
		health = value
		print(health)


func _ready() -> void:
	add_to_group("player")


func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	move_and_slide()


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		sword.attack()
	if Input.is_action_just_pressed("alt_attack"):
		sword.alt_attack()


func get_damage(damage: int):
	if !is_invincible:
		health -= damage
		audio_player.pitch_scale = 1.2 - 0.2 * (3 - health)
		audio_player.play()
		damage_recovery()
		Signals.emit_signal("player_got_damage", health)

func is_full_hp() -> bool:
	return health == max_health

func get_heal(heal_amount: int):
	health += 1
	Signals.emit_signal("player_got_heal", health)


func _on_player_pos_update_timeout() -> void:
	Global.emit_signal("player_pos", self.global_position)


func damage_recovery():
	is_invincible = true
	invincibility_timer.start(invincibility_time)
	damage_player.play("Flicker")
	await invincibility_timer.timeout
	damage_player.stop()
	is_invincible = false


func get_is_alive() -> bool:
	return is_alive

func get_is_invincible() -> bool:
	return is_invincible
