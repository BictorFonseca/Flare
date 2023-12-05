extends Node2D

var elevatorMoving=false
var begEle=true
var gates_active = true
var eleSound = false
var eleCrash=false
var darken = false
var alpha = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ladder/CollisionShape2D.apply_scale(Vector2(1,1.35))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elevatorMoving:
		$Elevator.position.y += 9.8
		if not eleCrash:
			#$elevatorSnap.play()
			$ElevatorCrash.play(3)
			eleCrash=true
			$DarkenTimer.start()
		#Add crash sound
	if begEle:
		$Elevator2.position.y-=2
		if not eleSound:
			$Elevator2/ElevatorSound.play()
			eleSound=true
	if darken:
		$ColorRect.color = Color("00000000", alpha)
		if alpha < 0.96:
			alpha += 0.02



func _on_area_2d_for_elevator_body_entered(body):
	if body.is_in_group("Player") and not begEle:
		elevatorMoving = true


func _on_stop_shape_body_entered(body):
	#print('close but not yet')
	if not body.is_in_group("Tilemap"):
		#print("yooo")
		begEle=false
		$Elevator2/ElevatorSound.stop()
	pass # Replace with function body.


func _on_darken_timer_timeout():
	darken = true
