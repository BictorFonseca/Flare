extends StaticBody2D
#a way to keep track in the object if it's on or off
var on_off=false

#this is to check if the player has collected the mineral 
#toggle this to true if you want to test level 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#this is supposed to help us keep the platforms up if 2 is held but it doesn't
'''or get_node("../../player").inventory_slot_selected == 2'''
func _process(delta):
	
	if (Input.is_action_just_pressed("select_2") or get_node("../../player").inventory_slot_selected == 2) and get_node("../../player").has_mineral1:
		if on_off==false:
			on_off=true
		#get_node("../../player").inventory_slot_selected == 0
		#this is needed to detoggle the platforms with the key 2. 
		#if we dont need this we can always comment it out later
		#else:
		#	on_off=false
	if Input.is_action_just_pressed("select_1") or Input.is_action_just_pressed("select_3") or Input.is_action_just_pressed("select_4"):
		if on_off==true:
			on_off=false
		
	if on_off and get_node("../../player").has_mineral1:
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
		get_node("../../player").has_mineral1=true
