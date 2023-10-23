extends Node

var level_01_running = false

var mineral1 = false

var dummy=true

var level_01_scene = preload("res://Levels/Level01/level_01.tscn")
var level_02_scene = preload("res://Levels/Level02/level_02.tscn")
var player_scene = preload("res://Character/character_body_2d.tscn")
#var hud = preload("res://HUD/hud.tscn")

# TEMPORARY CODE
func _ready():
	$HUD._ready()
	#level_01_running = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _begin_level_01():
	var level = level_01_scene.instantiate()
	var player = player_scene.instantiate()
	add_child(level)
	add_child(player)
	
	player.global_position = Vector2(100, -500)
	
func _begin_level_02():
	var level = level_02_scene.instantiate()
	var player = player_scene.instantiate()
	add_child(level)
	add_child(player)
	
	player.global_position = Vector2(600, 600)
	
func _on_hud_start_game():
	#_begin_level_01()
	_begin_level_02()
