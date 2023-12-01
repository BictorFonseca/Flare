extends Node2D
var red_mineral_tilemap = preload("res://Levels/Level02/red_mineral_tilemap.tscn")
var gates_active = false
var elevatorIsMoving = true
#Change to has_mineral2 when it's been implemented
var stopped=false
var elevator2Moving=false
var has_mineral2 = false
var eleSound=false
var minSound =false
var minOnce=false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ladder/CollisionShape2D.apply_scale(Vector2(1,1.3333))
	$Ladder2/CollisionShape2D.apply_scale(Vector2(1,0.8))
	$Ladder3/CollisionShape2D.apply_scale(Vector2(1,0.8))
	var tilemap = red_mineral_tilemap.instantiate()
	print(tilemap)
	add_child(tilemap)
	$CanvasLayer/Inventory3.hide()
	$CanvasModulate.hide()
	await get_tree().create_timer(0.01).timeout
	$CanvasModulate.show()
	#$PointLight2D2.hide()
	$Elevator2/PointLight2D2.energy = 0
	$Lever/PointLight2D2.energy = 0
	$"Mineral Deposit/PointLight2D2".color = Color("ff5454")
	$CanvasLayer/WallWritingLabel.hide()
	#making it so that if 2 was selected, blue platforms show
	#if get_node("../HUD/Selector").position.x = 469 + 67:
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select_3") and has_mineral2:
		var tilemap_instance = get_node_or_null("RedMineralTilemap")
		print(tilemap_instance)
		if tilemap_instance:
			print("yp I ecost and im not supposed to anymore")
			tilemap_instance.queue_free()
			$RedMinLight.show()
	elif (Input.is_action_just_pressed("select_1") or Input.is_action_just_pressed("select_2") or Input.is_action_just_pressed("select_4")) and not get_node_or_null("RedMineralTilemap") and not get_node("../player").inRed:
		var tilemap = red_mineral_tilemap.instantiate()
		add_child(tilemap)
		$RedMinLight.hide()
	if elevatorIsMoving:
		if not eleSound:
			$Elevator/ElevatorSound.play()
			eleSound=true
		$Elevator.position.y -= 2
	if elevator2Moving:
		if not eleSound:
			$Elevator2/ElevatorSound.play()
			eleSound=true
		$Elevator2.position.y-=2
	if minSound and not minOnce:
		$RockPickUp2.play()
		minSound=false
		minOnce=true
	if get_node('../player').game_over:
		$Elevator.visible=false
		$"Mineral Deposit".visible=false
		$CanvasLayer.hide()
		


func _on_gate_timer_timeout():
	gates_active = true
	
	
func _on_area_2d_for_elevator_body_entered(body):
	print('e1')
	if body.is_in_group("Player") and get_node('../player').position.y <=100 and get_node("../player").position.x>=1000 and not elevatorIsMoving:
		elevator2Moving=true
		eleSound=false
		

func _on_stop_eleva_body_entered(body):
	if body.is_in_group("Player"):
		elevatorIsMoving=false
		$Elevator/ElevatorSound.stop()
		
	pass # Replace with function body.

#if player collect mineral 2
func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Player"):
		$CanvasLayer/Inventory3.show()
		has_mineral2 = true
		minSound=true
		body.has_mineral2 = true


func _on_lever_2_flipped():
	#$Elevator2/PointLight2D2.energy = 20
	$Lever/PointLight2D2.energy = 5


func _on_lever_flipped():
	$Elevator2/PointLight2D2.energy = 20
	$Lever/PointLight2D2.energy = 0


func _on_wall_writing_text(text):
	if text == "hide":
		$CanvasLayer/WallWritingLabel.hide()
	else:
		$CanvasLayer/WallWritingLabel.show()
		$CanvasLayer/WallWritingLabel.text = text
