extends Node2D

var a = 23
var level = preload("res://Scenes/test_level.tscn")
var settings = preload("res://Scenes/settings.tscn")
var tree = get_tree()

func _ready() -> void:
	print(typeof(level))
	print(typeof(tree))
	print(typeof(a))

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(level)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_packed(settings)
