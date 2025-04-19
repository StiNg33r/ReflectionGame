extends Area2D
class_name UpgradeCard

signal upgrade_selected(card: UpgradeCard)

func _ready() -> void:
	connect("input_event", Callable(self, "_on_input_event"))
#func _on_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	#pass

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("нажато")
		upgrade_selected.emit(self)
		
