extends Node

var level_01_scene = preload("res://Levels/Level01/level_01.tscn")
var player_scene = preload("res://Character/character_body_2d.tscn")
#var hud = preload("res://HUD/hud.tscn")

# TEMPORARY CODE
func _ready():
	_begin_level_01()
	$HUD._ready()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _begin_level_01():
	var level = level_01_scene.instantiate()
	var player = player_scene.instantiate()
	add_child(level)
	add_child(player)
	player.global_position = Vector2(100, 100)
