extends Node

var level_01_running = false
var level_02_running = false
var level_03_running = false

var level_01_scene = preload("res://Levels/Level01/level_01.tscn")
var level_02_scene = preload("res://Levels/Level02/level_02.tscn")
var player_scene = preload("res://Character/character_body_2d.tscn")

func _ready():
	$HUD._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level_01_running:
		var player = get_node_or_null("player")
		if player and player.position.y < 0:
			_end_level_01()
			_begin_level_01()
	if level_02_running:
		pass
			

func _begin_level_01():
	level_01_running = true
	var level = level_01_scene.instantiate()
	var player = player_scene.instantiate()
	add_child(level)
	add_child(player)
	
	player.global_position = Vector2(100, -500)
	
func _end_level_01():
	level = get_node_or_null("level_01")
	level.queue_free()
	
func _begin_level_02():
	var level = level_02_scene.instantiate()
	var player = player_scene.instantiate()
	add_child(level)
	add_child(player)
	
	player.global_position = Vector2(600, 600)
	
func _on_hud_start_game():
	#_begin_level_01()
	
