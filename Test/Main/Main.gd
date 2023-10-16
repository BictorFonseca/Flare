extends Node

var level_01_running = false
var dummy=true
var level_01_scene = preload("res://Levels/Level01/level_01.tscn")
var player_scene = preload("res://Character/character_body_2d.tscn")
var mineral1 = false
#var hud = preload("res://HUD/hud.tscn")

# TEMPORARY CODE
func _ready():
	_begin_level_01()
	$HUD._ready()
	#level_01_running = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	'''
	if level_01_running:
		if get_node("../level").obtained_mineral:
			print("got it")
	'''
	'''if get_node(../../level).done = true:
		print("finished")'''

func _begin_level_01():
	var level = level_01_scene.instantiate()
	var player = player_scene.instantiate()
	add_child(level)
	add_child(player)
	
	player.global_position = Vector2(100, 100)

