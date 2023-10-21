extends TileMap
#here we are going to make it so the scene hides itself if the 3 key is pressed
var show = true
#var shown = get_node("RedMineralTileMap").visible

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select_3"):
		#get_node("../RedMineralTileMap").hide()
		#self.hide()
		self.visible = false
	elif Input.is_action_just_pressed("select_1") or Input.is_action_just_pressed("select_2") or Input.is_action_just_pressed("select_4"):
		#self.set_deferred("disabled", true)
		self.visible = true
