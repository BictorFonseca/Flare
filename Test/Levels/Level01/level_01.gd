extends Node2D
signal finished
@export var done = false
signal start

var elevatorIsMoving = false
var obtained_mineral = false
var gates_active = true
var eleSound = false
var minSound = false
var minOnce=false
var intro = true
var in_air = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	start.emit()
	$CanvasLayer/WallWritingLabel.hide()
	#print("text hidden")
	$CanvasLayer/Inventory2.hide()
	$EndLayer/LabelEnd.hide()
	$CanvasModulate.hide()
	await get_tree().create_timer(0.01).timeout
	
	$CanvasModulate.show()
	
	if get_node("../player").game_over:
		in_air = true
		get_node("../player/Flame").play("fire")


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
	if not get_node("../player").game_over and intro:
		get_node("../player").position = Vector2(100, 520)
	if get_node('../player').game_over:
		$Elevator.visible=false
		$"Mineral Deposit".visible=false
		$CanvasLayer.hide()
		
	if in_air and get_node('../player').is_on_floor():
		in_air = false
		$Falling.stop()
		$Thud.play()
	

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
	if not get_node("../player").game_over:
		intro = false
		$Thud.play()
		await get_tree().create_timer(2).timeout
		get_node("../player").light_flare = true
		get_parent().startTimer = true
		get_node("../HUD").timerPaused = false
		get_node("../HUD").time = 900
