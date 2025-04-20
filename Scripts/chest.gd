extends Area2D

var is_open: bool = false
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label


func _ready():
	body_entered.connect(_on_player_enter)
	body_exited.connect(_on_player_exit)
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		open_chest()


func _on_player_enter(body: Node2D):
	if !is_open:
		is_available()
		print("player enter")

func _on_player_exit(body: Node2D):
	if !is_open:
		is_unavailable()

func open_chest():
	if !is_open:
		print("chest is opened")
		anim_sprite.play("Open")
		is_open = true
		is_unavailable()

func is_available():
	label.visible = true
	set_process_input(true)

func is_unavailable():
	label.visible = false
	set_process_input(false)
