extends CharacterBody2D

@onready var damage_player: AnimationPlayer = $DamagePlayer

var health = 3:
	set(value):
		health = value
		print("enemy health =", value)
		if health <= 0:
			death()


func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	move_and_slide()


func get_damage(damage: int):
	health -= damage
	damage_player.play("Hit")
	
func death():
	queue_free()
