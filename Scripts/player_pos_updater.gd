extends Node2D
class_name PlayerPosUpdater

signal player_pos_updated(pos: Vector2)

var player_pos: Vector2

func _ready() -> void:
	Global.player_pos.connect(_on_player_pos_update)

func _on_player_pos_update(pos: Vector2):
	player_pos = pos
	player_pos_updated.emit(player_pos)
