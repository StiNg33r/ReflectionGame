extends CanvasLayer

@onready var cards_node: Node2D = $Cards
var cards: Array[UpgradeCard] = []

func _ready():
	for card in cards_node.get_children():
		card = card as UpgradeCard
		card.upgrade_selected.connect(_on_upgrade_selected)
		cards.append(card)

func _on_upgrade_selected(upgrade: UpgradeCard):
	print("upgrade selected")
	for card in cards:
		card.queue_free()
