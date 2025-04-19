extends Bullet
class_name SimpleBullet

@onready var audio_player = $AudioStreamPlayer2D
@onready var enemy_bullet_sprite: Sprite2D = $Enemy_bullet
@onready var ally_bullet_sprite: Sprite2D = $Ally_bullet


#func _ready() -> void:
	#super._ready()
	#lifetime_timer = $Timer

func make_ally():
		enemy_bullet_sprite.hide()
		ally_bullet_sprite.show()

func _on_timer_timeout() -> void:
	delete()
