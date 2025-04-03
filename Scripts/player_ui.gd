extends CanvasLayer

var hearts: Array[Heart]

func _ready() -> void:
	Signals.player_got_damage.connect(player_got_damage)
	Signals.player_got_heal.connect(player_got_heal)
	for node in get_children():
		if node is Heart:
			hearts.append(node)
	print(hearts)

# 2 1 0
# 
func player_got_damage(remaining_health: int):
	hearts[remaining_health].make_empty()

func player_got_heal(remaining_health: int):
	hearts[remaining_health-1].make_full()
