extends Node2D
class_name Heart


@onready var full_heart: Sprite2D = $Full_heart
@onready var empty_heart: Sprite2D = $Empty_heart
var is_full = true

func make_empty():
	full_heart.visible = false
	empty_heart.visible = true
	is_full = false


func make_full():
	full_heart.visible = true
	empty_heart.visible = false
	is_full = true
