extends Node2D
var red_mineral_tilemap = preload("res://Levels/Level02/red_mineral_tilemap.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var tilemap = red_mineral_tilemap.instantiate()
	print(tilemap)
	add_child(tilemap)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select_3"):
		var tilemap_instance = get_node_or_null("RedMineralTilemap")
		print(tilemap_instance)
		if tilemap_instance:
			tilemap_instance.queue_free()
	elif (Input.is_action_just_pressed("select_1") or Input.is_action_just_pressed("select_2") or Input.is_action_just_pressed("select_4")) and not get_node_or_null("RedMineralTilemap"):
		var tilemap = red_mineral_tilemap.instantiate()
		add_child(tilemap)
