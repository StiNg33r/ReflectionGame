extends Area2D
class_name Bullet
var direction: Vector2
var speed = 200.0
var target_group: String
var lifetime: float = 5
var is_active = true
@onready var audio_player = $AudioStreamPlayer2D
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
		delete()
	if body.is_in_group(target_group):
		body.get_damage(1)
		delete()


func delete():
	is_active = false
	queue_free()
