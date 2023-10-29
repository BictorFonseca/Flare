extends Node2D

var elevatorMoving=false
var gates_active = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$Ladder/CollisionShape2D.apply_scale(Vector2(1,1.35))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elevatorMoving:
		$Elevator.position.y += 20
		#Add crash sound
	pass



func _on_area_2d_for_elevator_body_entered(body):
	if body.is_in_group("Player"):
		elevatorMoving = true
