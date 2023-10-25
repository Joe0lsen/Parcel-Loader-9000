extends Node2D

@export var target_speed = 100
var speed = 0

var hue

func _ready():
	hue = $Sprite2D/ColorRect.color.h
	$Sprite2D/ColorTimer.start()

func _process(delta):
	var velocity = Vector2.ZERO
	velocity.x -= 1
	
	if speed < target_speed: # Get up to speed smoothly
		speed += 0.1
		
	position += velocity * delta * speed
	
	if position.x < -$Sprite2D/ColorRect.size.x / 2: # Start box again, just barely off screen
		var screen_size = get_viewport_rect().size
		var half_size = $Sprite2D/ColorRect.size
		position.x = screen_size.x + half_size.x / 2
		position.y = randi_range(half_size.y, screen_size.y - half_size.y)

func _on_color_timer_timeout(): # change color
	hue = snapped(fmod(hue * 1.01 + 0.33, 1), 0.01) # Next color should be dissimilar, but slightly random
	$Sprite2D/ColorRect.color = Color.from_ok_hsl(hue, 1.0, 0.7)
