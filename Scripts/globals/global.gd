extends Node

var active_enemies_count: int = 0:
	set(value):
		active_enemies_count = value
		emit_signal("active_enemies_count_changed", active_enemies_count)
		print("enemies count: ", active_enemies_count)


var level: Node2D

signal player_pos(position: Vector2)
signal active_enemies_count_changed(remaining_enemies: int)
signal enemy_spawned
signal enemy_died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy_spawned.connect(_on_enemy_spawned)
	enemy_died.connect(_on_enemy_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_enemy_spawned():
	active_enemies_count += 1

func _on_enemy_died():
	active_enemies_count -= 1
