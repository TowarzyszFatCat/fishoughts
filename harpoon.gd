extends Node2D

@onready var ray_cast_2d = $raycast

var last_collider

func _process(delta):
	if Input.is_action_pressed("LMB"):
		ray_cast_2d.enabled = true
		draw_ray()
	else:
		ray_cast_2d.enabled = false
	
	if ray_cast_2d.is_colliding() && last_collider != ray_cast_2d.get_collider():
		last_collider = ray_cast_2d.get_collider()
		ray_collision(last_collider)
	
	queue_redraw()

func _draw():
	var mouse_pos = get_global_mouse_position()
	var rp = Vector2(1920/2, 1080)
	
	draw_dashed_line(rp, mouse_pos,Color.WHITE, 3, 2, true)
	draw_arc(mouse_pos, 10, 0, TAU, 16, Color.WHITE, 1, true)


func draw_ray():
	var mouse_pos = get_global_mouse_position()
	var mp = Vector2(mouse_pos.x - 1920/2, mouse_pos.y - 1080)
	var rp = Vector2(1920/2, 1080)
	
	ray_cast_2d.global_position = rp
	ray_cast_2d.target_position = mp

func ray_collision(col):
	col.explode()
	$"..".caught(col)
