extends Node2D
@export var button = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_glow_timer_timeout():
	$PointLight2D2.energy = randf_range(3.0, 3.3)
	



func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		$Mineral_Instruction.visible=true
		if button == 2:
			$Button2.visible=true
		elif button == 3:
			$Button3.visible=true
		elif button == 4:
			$Button4.visible=true
		body.has_mineral1 = true
		$PointLight2D2.enabled=false
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		$Mineral_Instruction.visible=false
		$Button2.visible=false
		$Button3.visible=false
		$Button4.visible=false
	pass # Replace with function body.
