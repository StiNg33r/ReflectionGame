extends Node2D

var sword_distance = 15.0
var current_angle = 0.0
var attack_cooldown: float = 0.5
var is_ready_to_attack = true
@onready var pivot = $Pivot
@onready var anim = $AnimationPlayer
@onready var detector = $Pivot/Area2D
@onready var cooldown_timer = $Attack_cooldown
@onready var audio_player = $AudioStreamPlayer2D
func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	pivot.position = direction * sword_distance
	pivot.rotation = direction.angle() + PI/2



func attack():
	if is_ready_to_attack:
		var direction = (get_global_mouse_position() - global_position).normalized()
		is_ready_to_attack = false
		cooldown_timer.start(attack_cooldown)
		anim.play("Attack")
		var bullets = detector.get_overlapping_areas()
		for bullet in bullets:
			bounce()
			bullet.target_group = "enemies"
			bullet.bounce()
			#bullet.direction = -bullet.direction
			bullet.direction = direction

func bounce():
	audio_player.pitch_scale = randf_range(1.0, 2.0)
	audio_player.play()

func _on_attack_cooldown_timeout() -> void:
	is_ready_to_attack = true
