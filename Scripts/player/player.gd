extends CharacterBody2D
class_name Player
@onready var sword = $Sword
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
var max_health = 3
var health = 3:
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
	Global.emit_signal("player_pos", self.global_position)

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		sword.attack()


func get_damage(damage: int):
	health -= damage
	audio_player.pitch_scale = 1.2 - 0.2 * (3 - health)
	audio_player.play()
	Signals.emit_signal("player_got_damage", health)

func is_full_hp() -> bool:
	return health == max_health

func get_heal(heal_amount: int):
	health += 1
	Signals.emit_signal("player_got_heal", health)
