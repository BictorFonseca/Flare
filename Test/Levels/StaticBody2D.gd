extends StaticBody2D
#a way to keep track in the object if it's on or off
var on_off=false

#this is to check if the player has collected the mineral 
var mineral1Collected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select_2") and mineral1Collected:
		if on_off==false:
			on_off=true
		else:
			on_off=false
	elif Input.is_action_just_pressed("select_1") or Input.is_action_just_pressed("select_3") or Input.is_action_just_pressed("select_4"):
		if on_off==true:
			on_off=false
	if on_off and mineral1Collected:
		self.visible=true
		get_node("Platform1").set_deferred("disabled", false)
		
		#self.set_deferred("disabled", false)
	else:
		self.visible=false
		get_node("Platform1").set_deferred("disabled", true)
	
	pass

#make sure to connect the signal from area2ForMineral1 to each platform created to make it functional
func _on_area_2_for_mineral_1_body_entered(body):
	if body.is_in_group("Player"):
		print('mineral1Collected = true')
		mineral1Collected = true
