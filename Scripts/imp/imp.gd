extends Enemy

@onready var direction_change_timer: Timer = $DirectionChangeTimer
@onready var damage_player: AnimationPlayer = $DamagePlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $State_Machine
@onready var collider: CollisionShape2D = $CollisionShape2D

var is_direction_change_available: bool = true
var direction_change_time: float = 0.2
var health = 3:
	set(value):
		health = value
		print("enemy health =", value)


func _physics_process(delta: float) -> void:
	if is_direction_change_available:
		if velocity.x > 5:
			sprite.flip_h = false
			direction_change()
		elif velocity.x < -5:
			sprite.flip_h = true
			direction_change()
	
	move_and_slide()
	if get_slide_collision_count() > 0:
		knockback(get_slide_collision(0).get_collider())

func knockback(body: Node2D):
	var knockback_vector = (global_position - body.global_position).normalized()
	var knockback_force = 50.0
	velocity = knockback_vector * knockback_force

func get_damage(damage: int):
	health -= damage * damage_multiplier
	damage_player.stop()
	damage_player.play("Hit")
	if health <= 0:
		death()
	else:
		emit_signal("got_damage")
	
func death():
	super.death()
	is_alive = false
	state_machine.is_active = false
	collider.set_deferred("disabled", true)
	set_physics_process(false)
	full_stop()
	$AnimationPlayer2.play("new_animation")
	await  $AnimationPlayer2.animation_finished
	emit_signal("died")
	queue_free()

func full_stop():
	velocity = Vector2(0,0)

func direction_change():
	is_direction_change_available = false
	direction_change_timer.start(direction_change_time)


func _on_direction_change_timer_timeout() -> void:
	is_direction_change_available = true
