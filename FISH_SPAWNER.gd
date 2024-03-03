extends Node

@onready var spawns_r = $spawns_right
@onready var spawns_l = $spawns_left

var spawnpoints_r = []
var spawnpoints_l = []

var fishes = [preload("res://triangle_fish.tscn"), preload("res://puffer_fish.tscn"), preload("res://salmon_fish.tscn")]

func _ready():
	for marker in spawns_r.get_children():
		spawnpoints_r.append(marker.position)

	for marker in spawns_l.get_children():
		spawnpoints_l.append(marker.position)
	
	$Timer.start(0.05) # firt start


func _on_timer_timeout():
	$Timer.start(glov.spawn_speed)
	spawn_fish()

func spawn_fish():
	var site = randi_range(0,1)
	var spawn
	var exit
	
	if site == 0:
		spawn = spawnpoints_l.pick_random()
		exit = spawnpoints_r.pick_random()
	if site == 1:
		spawn = spawnpoints_r.pick_random()
		exit = spawnpoints_l.pick_random()
	
	var fish = fishes.pick_random().instantiate()
	fish.position = spawn
	fish.set_exit(exit)
	add_child(fish)
