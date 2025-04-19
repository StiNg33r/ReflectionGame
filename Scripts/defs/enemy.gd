extends CharacterBody2D
class_name Enemy

signal got_damage
signal died
var damage_multiplier: int = 1
var is_last_enemy: bool = false
var is_alive: bool = true

func _ready() -> void:
	add_to_group("enemies")
	Global.emit_signal("enemy_spawned")
	Global.active_enemies_count_changed.connect(_on_enemy_count_change)

func get_is_alive() -> bool:
	return is_alive

func get_damage(damage: int):
	pass

func knockback_from_damage():
	pass

func death():
	Global.emit_signal("enemy_died")

func _on_enemy_count_change(enemy_count: int):
	print("from enemy, enemy count: = ", enemy_count)
	if enemy_count == 1:
		is_last_enemy = true
		damage_multiplier *= 2
	elif is_last_enemy:
		damage_multiplier /= 2
		is_last_enemy = false
