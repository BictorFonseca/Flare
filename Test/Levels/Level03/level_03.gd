extends Node2D

var has_mineral3 = false
var elevator2Moving=false
var BegEle=true
var eleSound = false
var minSound = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer2/Inventory2.show()
	$CanvasLayer2/Inventory3.show()
	$CanvasLayer2/Inventory4.hide()
	$CanvasModulate.hide()
	await get_tree().create_timer(0.01).timeout
	$CanvasModulate.show()


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
	if minSound:
		$RockPickUp.play()
		minSound=false
	pass


func _on_area_2d_2_body_entered(body):
	if body.is_in_group("Player"):
		$CanvasLayer2/Inventory4.show()
		has_mineral3 = true
		minSound=true
		body.has_mineral3 = true


func _on_area_2d_for_elevator_body_entered(body):
	if body.is_in_group("Player") and not BegEle:
		elevator2Moving=true
		eleSound=false
	
	pass # Replace with function body.


func _on_stop_area_body_entered(body):
	if body.is_in_group("Player"):
		BegEle=false
		
	pass # Replace with function body.
