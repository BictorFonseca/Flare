extends Area2D

var on_off = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select_1"):
		if on_off==false:
			on_off=true
		else:
			on_off=false
	if on_off:
		self.visible=true
		get_node("RedPlatformCol").set_deferred("disabled", false)
	else:
		self.visible=false
		get_node("RedPlatformCol").set_deferred("disabled", true)
	print(on_off)
	pass
