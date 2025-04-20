extends Enemy

@onready var damage_player: AnimationPlayer = $DamagePlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var health = 2:
	set(value):
		health = value
		print(health)



func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
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
	super.death()
	emit_signal("died")
	queue_free()
