extends Area2D
class_name Bullet
var direction: Vector2
var level: Node2D
var speed = 200.0
var target_group: String
var lifetime: float = 5
var bounce_count: int = 0
var piercing_count: int  = 0
var is_active = true
var is_reflectable = true


var particles = preload("res://Scenes/particles/bullet_particles.tscn")
@onready var lifetime_timer: Timer = $Timer



func _ready() -> void:
	
	add_to_group("bullets")
	lifetime_timer.wait_time = lifetime
	
	
func _process(delta: float) -> void:
	if direction:
		position += direction * speed * delta


func _on_timer_timeout() -> void:
	delete()

func bounce():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group(target_group):
			_on_body_entered(body)
			break

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("tilemap"):
		if bounce_count > 0:
			print("bounce")
			bounce_count -= 1
			direction = -direction
			make_particles()
		else:
			delete()
	if body.is_in_group(target_group):
		if body.get_is_alive():
			body.get_damage(1)
			delete()

func make_particles():
	level = Global.level
	var new_particles = particles.instantiate() as GPUParticles2D
	new_particles.global_position = global_position
	new_particles.emitting = true
	level.add_child(new_particles)


func delete():
	is_active = false
	make_particles()
	queue_free()

func lifetime_timer_reset(divide: float = 1.0):
	lifetime_timer.start(lifetime/divide)

func get_reflectable() -> bool:
	return is_reflectable
