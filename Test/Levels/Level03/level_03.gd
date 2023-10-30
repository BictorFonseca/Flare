extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("../player").has_mineral3 and Input.is_action_pressed("select_4"):
		get_node("Sludge/WaterArt").visible=true
		get_node("BigSludge1/WaterArt").visible=true
		get_node("BigSludge2/WaterArt").visible=true
		get_node("BigSludge3/WaterArt").visible=true
		get_node("Sludge/CollisionShape2D").set_deferred("disabled", true)
		get_node("BigSludge1/CollisionShape2D").set_deferred("disabled", true)
		get_node("BigSludge2/CollisionShape2D").set_deferred("disabled", true)
		get_node("BigSludge3/CollisionShape2D").set_deferred("disabled", true)
	elif Input.is_action_pressed("select_1") or Input.is_action_pressed("select_2") or Input.is_action_pressed("select_3"):
		get_node("Sludge/WaterArt").visible=false
		get_node("BigSludge1/WaterArt").visible=false
		get_node("BigSludge2/WaterArt").visible=false
		get_node("BigSludge3/WaterArt").visible=false
		get_node("Sludge/CollisionShape2D").set_deferred("disabled", false)
		get_node("BigSludge1/CollisionShape2D").set_deferred("disabled", false)
		get_node("BigSludge2/CollisionShape2D").set_deferred("disabled", false)
		get_node("BigSludge3/CollisionShape2D").set_deferred("disabled", false)
		
	pass
