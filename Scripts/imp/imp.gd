extends Enemy

@onready var damage_player: AnimationPlayer = $DamagePlayer


var health = 3:
	set(value):
		health = value
		print("enemy health =", value)

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	#if is_colliding():
		#var push_vector = (global_position - player.global_position).normalized()
		#apply_impulse(Vector2(), push_vector * push_force)
	move_and_slide()
	if get_slide_collision_count() > 0:
		knockback(get_slide_collision(0).get_collider())

func knockback(body: Node2D):
	var knockback_vector = (global_position - body.global_position).normalized()
	var knockback_force = 50.0
	velocity = knockback_vector * knockback_force

func get_damage(damage: int):
	health -= damage
	damage_player.play("Hit")
	if health <= 0:
		death()
	else:
		emit_signal("got_damage")
	
func death():
	queue_free()
