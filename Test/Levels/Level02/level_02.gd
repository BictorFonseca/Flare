extends Node2D
var red_mineral_tilemap = preload("res://Levels/Level02/red_mineral_tilemap.tscn")
var gates_active = false
var elevatorIsMoving = true
#Change to has_mineral2 when it's been implemented
var stopped=false
var elevator2Moving=false

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
			print("yp I ecost and im not supposed to anymore")
			tilemap_instance.queue_free()
	elif (Input.is_action_just_pressed("select_1") or Input.is_action_just_pressed("select_2") or Input.is_action_just_pressed("select_4")) and not get_node_or_null("RedMineralTilemap"):
		var tilemap = red_mineral_tilemap.instantiate()
		add_child(tilemap)
	if elevatorIsMoving:
		$Elevator.position.y -= 2
		$Elevator/ElevatorSound.play()
	if elevator2Moving:
		$Elevator2.position.y-=2
	if get_node("../player").position.y<150:
		print("im in range")
		stopped=false
		$Elevator.visible=false
		print(stopped)


func _on_gate_timer_timeout():
	gates_active = true
	
func _on_area_2d_for_elevator_body_entered(body):
	if not stopped:
		elevatorIsMoving = true
	if not stopped and get_node("../player").position.y<150 and body.is_in_group("Player"):
		elevator2Moving=true


func _on_stop_eleva_body_entered(body):
	if body.is_in_group("Player"):
		elevatorIsMoving=false
	pass # Replace with function body.
