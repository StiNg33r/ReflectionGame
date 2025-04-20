extends Enemy



func _physics_process(delta: float) -> void:
	if get_slide_collision_count() > 0:
		knockback(get_slide_collision(0).get_collider())
	super._physics_process(delta)

func knockback(body: Node2D):
	var knockback_vector = (global_position - body.global_position).normalized()
	var knockback_force = 50.0
	velocity = knockback_vector * knockback_force

func get_damage(damage: int):
	super.get_damage(damage)
	
func death():
	super.death()
