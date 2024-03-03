extends CharacterBody2D

@onready var particles = $particles

var exit_point
var fish_speed

func _ready():
	fish_speed = randi_range(150, 250)
	
	if glov.points:
		$fish_body_full.visible = false
		$fish_body_close.visible = false
		$point.visible = true

	else:
		$fish_body_full.visible = true
		$fish_body_close.visible = true
		$point.visible = false
		
	var h = randf()
	
	var fish_close_color = Color.from_hsv(h, glov.sat, 0.8)
	var fish_full_color = Color.from_hsv(h, glov.sat, 0.7)
	$fish_body_close.color = fish_close_color
	$fish_body_full.color = fish_full_color
	
	particles.color = $fish_body_full.color

func explode():
	particles.emitting = true
	$fish_body_close.queue_free()
	$fish_body_full.queue_free()
	$CollisionPolygon2D.queue_free()
	$death_timer.start()
	


func _on_death_timer_timeout():
	queue_free()

func set_exit(exit):
	var dir = global_position.direction_to(exit)
	if dir.x < 0:
			scale = Vector2i(-1,-1)
			
	exit_point = exit
	
func _process(delta):
	
	if exit_point:
		var direction = global_position.direction_to(exit_point)
		
		if global_position.distance_squared_to(exit_point) < 10:
			queue_free()
		
		velocity = direction * fish_speed
		
		move_and_slide()
