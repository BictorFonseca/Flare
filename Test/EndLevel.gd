extends Node2D

var elevatorMoving=false
var begEle=true
var gates_active = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Ladder/CollisionShape2D.apply_scale(Vector2(1,1.35))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elevatorMoving:
		$Elevator.position.y += 20
		#Add crash sound
	if begEle:
		$Elevator2.position.y-=2
	pass



func _on_area_2d_for_elevator_body_entered(body):
	if body.is_in_group("Player") and not begEle:
		elevatorMoving = true


func _on_stop_shape_body_entered(body):
	print('close but not yet')
	if not body.is_in_group("Tilemap"):
		print("yooo")
		begEle=false
	pass # Replace with function body.
