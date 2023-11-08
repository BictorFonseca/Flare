extends Node2D
signal finished
@export var done = false
signal start
# =
# +
#the above comments are there becayse of the broken keyboard that doesn't allow a group member to use the keys
#thus, that's there for copy pasting
var elevatorIsMoving = false
var obtained_mineral = false
var gates_active = true
var eleSound = false
var minSound = false
var minOnce=false
var intro = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	start.emit()
	$CanvasLayer/WallWritingLabel.hide()
	print("text hidden")
	$CanvasLayer/Inventory2.hide()
	$EndLayer/LabelEnd.hide()
	$CanvasModulate.hide()
	await get_tree().create_timer(0.01).timeout
	
	$CanvasModulate.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if elevatorIsMoving:
		$Elevator.position.y -= 2
		finished.emit()
		if not eleSound:
			$Elevator/ElevatorSound.play()
			eleSound=true
	if minSound and not minOnce:
		$RockPickUp.play()
		minSound=false
		minOnce=true
	if intro:
		get_node("../player").position = Vector2(100, 520)
	

func _on_wall_writing_text(text):
	if text == "hide":
		$CanvasLayer/WallWritingLabel.hide()
	else:
		$CanvasLayer/WallWritingLabel.show()
		$CanvasLayer/WallWritingLabel.text = text

func _on_area_2_for_mineral_1_body_entered(body):
	#print("show Inv2")

	obtained_mineral = true
	if body.is_in_group("Player"):
		minSound=true
		$CanvasLayer/Inventory2.show()

func _on_area_2d_for_elevator_body_entered(body):
	elevatorIsMoving = true


func _on_intro_sequence_timeout():
	intro = false
	$Thud.play()
	await get_tree().create_timer(2).timeout
	get_node("../player").light_flare = true
	get_parent().startTimer = true
	get_node("../HUD").timerPaused = false
	get_node("../HUD").time = 900
