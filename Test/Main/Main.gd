extends Node
var tutorial_running = false
var level_01_running = false
var level_02_running = false
var level_03_running = false
var level = null
var player = null

var level_01_scene = preload("res://Levels/Level01/level_01.tscn")
var level_02_scene = preload("res://Levels/Level02/level_02.tscn")
var player_scene = preload("res://Character/character_body_2d.tscn")
var cutscene = preload("res://Levels/Tutorial/cutscene.tscn")

func _ready():
	$HUD._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tutorial_running:
		player = get_node_or_null("player")
		if player and player.position.y>720:
			_end_level()
			tutorial_running=false
			_begin_level_01()
	if level_01_running:
		player = get_node_or_null("player")
		if player and player.position.y < 0:
			_end_level()
			level_01_running=false
			_begin_level_02()
	if level_02_running:
		player = get_node_or_null("player")
		if player and player.position.y<0:
			_end_level()
			level_02_running=false
			_begin_level_03()
		pass
			

func _begin_level_01():
	level_01_running = true
	level = level_01_scene.instantiate()
	
	add_child(level)
	add_child(player)
	get_node("player").flare_lit = true
	
	player.global_position = Vector2(100, 0)
	
func _end_level():
	if (is_instance_valid(level)):
		level.queue_free()
		remove_child(player)
	
func _begin_level_03():
	pass
	
	
func _begin_level_02():
	level_02_running=true
	player = player_scene.instantiate() 
	level = level_02_scene.instantiate()
	add_child(level)
	add_child(player)
	player.global_position = Vector2(600, 450)

func _begin_tutorial():
	tutorial_running=true
	level = cutscene.instantiate()
	player = player_scene.instantiate()  
	add_child(level)
	add_child(player)
	get_node("player").flare_lit = false
	player.global_position = Vector2(100, 97)
	
func _on_hud_start_game():
	_begin_tutorial()
	#_begin_level_02()
	
