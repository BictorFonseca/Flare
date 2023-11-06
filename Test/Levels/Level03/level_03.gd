extends Node2D

var has_mineral3 = false
var elevator2Moving=false
var BegEle=true
var eleSound = false
var minSound = false
var minOnce=false
var red_mineral_tilemap = preload("res://Objects/level_3_red_mineral_tilemap.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer2/Inventory2.show()
	$CanvasLayer2/Inventory3.show()
	$CanvasLayer2/Inventory4.hide()
	$CanvasModulate.hide()
	await get_tree().create_timer(0.01).timeout
	var tilemap = red_mineral_tilemap.instantiate()
	add_child(tilemap)
	$CanvasModulate.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Only for SLudge
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
	
	if elevator2Moving:
		$Elevator2.position.y-=2
		if not eleSound:
			$Elevator2/ElevatorSound.play()
			eleSound=true
	if BegEle:
		if not eleSound:
			$Elevator3/ElevatorSound.play()
			eleSound=true
		$Elevator3.position.y-=2
	print(BegEle)
	if minSound and not minOnce:
		$RockPickUp.play()
		minSound=false
		minOnce=true
	#Tilemap
	if (Input.is_action_just_pressed("select_3") or get_node("../player").inventory_slot_selected == 3) and not get_node("../player").inRed:
		var tilemap_instance = get_node_or_null("Level3RedMineralTilemap")
		print(tilemap_instance)
		if tilemap_instance:
			print("not sure what the original message is meant to say but whatever i guess")
			tilemap_instance.queue_free()
	
	if (Input.is_action_just_pressed("select_1") or Input.is_action_just_pressed("select_2") or Input.is_action_just_pressed("select_4")) and not get_node_or_null("Level3RedMineralTilemap"):
		'''
		if get_node("../player").position.x >= 535 and get_node("../player").position.x <= 635:
			get_node("../player").position.x = 530
		elif get_node("../player").position.x >= 635 and get_node("../player").position.x <= 680:
			get_node("../player").position.x = 690
		if get_node("../player").position.x >= 900 and get_node("../player").position.x <= 925:
			get_node("../player").position.x = 890
		elif get_node("../player").position.x >= 925 and get_node("../player").position.x <= 950:
			get_node("../player").position.x = 960
		'''
		var tilemap = red_mineral_tilemap.instantiate()
		
		add_child(tilemap)
		

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Player"):
		$CanvasLayer2/Inventory4.show()
		has_mineral3 = true
		minSound=true
		body.has_mineral3 = true
		$Light1.energy = 5


func _on_area_2d_for_elevator_body_entered(body):
	if body.is_in_group("Player") and not BegEle and get_node('../player').position.y <=150 and get_node("../player").position.x>=1000:
		elevator2Moving=true
		eleSound=false
	
	pass # Replace with function body.


func _on_stop_area_body_entered(body):
	if body.is_in_group("Player"):
		BegEle=false
		
	pass # Replace with function body.


func _on_lever_flipped():
	$Light1.energy = 0
	#$Light2.energy = 5
	pass


#this one flips before lever2
func _on_lever_3_flipped():
	#$Light2.energy = 0
	#$Light3.energy = 5
	pass


func _on_lever_2_flipped():
	#$Light3.energy = 0
	$Elevator2/Light4.energy = 5
