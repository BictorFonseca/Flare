extends Node2D

var elevatorMoving=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elevatorMoving:
		$Elevator.position.y -= 20
		#Add crash sound
	pass



func _on_area_2d_for_elevator_body_entered(body):
	if body.is_in_group("Player"):
		elevatorMoving = true
