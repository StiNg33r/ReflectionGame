extends Node2D

var size_mode: int = 0 #режим экрана

func _on_check_box_toggled(toggled_on: bool) -> void:
	size_mode = 3 if toggled_on else 0
	ProjectSettings.set_setting("display/window/size/mode", size_mode)
	print(ProjectSettings.get_setting("display/window/size/mode"))
	print(size_mode)
