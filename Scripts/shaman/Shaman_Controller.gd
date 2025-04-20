extends EnemyController



func _ready():
	bullet = preload("res://Scenes/bullet.tscn")
	super._ready()
	body = $"../.."
	attack_timer = $"../../AttackTimer"

func _on_attack_timer_timeout() -> void:
	var angle_variation = deg_to_rad(30)  # Разброс в 15 градусов
	var angle = direction.angle()
	for i in range(-1,2):
		var new_bullet = bullet.instantiate()
		#new_bullet.global_position = body.global_position + (Vector2(0,20)* abs(direction.x) + Vector2(20,0) * abs(direction.y) ) * i
		new_bullet.global_position = body.global_position + Vector2(10,10) * direction

		#new_bullet.direction = direction
		new_bullet.direction = Vector2.RIGHT.rotated(angle + angle_variation * i)
		new_bullet.target_group = "player"
		level.add_child(new_bullet)
