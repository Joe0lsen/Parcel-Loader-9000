extends Node2D

@export var speed = 100
var screen_size
var half_player

func _ready():
	screen_size = get_viewport_rect().size
	half_player = $Sprite2D/ColorRect.size * scale / 2

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"): # Using elif to not allow diagonal movement
		velocity.y -= 1
		velocity.x = 0
	elif Input.is_action_pressed("move_down"):
		velocity.y += 1
		velocity.x = 0
	elif Input.is_action_pressed("move_right"):
		velocity.x += 1
		velocity.y = 0
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		velocity.y = 0

	velocity *= speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO + half_player, screen_size - half_player) # Keep full body of player within screen
