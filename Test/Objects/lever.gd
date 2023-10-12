extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("../../player").lever1_signal:
		$LeverArt.set_flip_h(true)
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_node("../../player").lever1=true
		$Lever_Prompt.visible=true
	pass # Replace with function body.

func _on_body_exited(body):
	if body.is_in_group("Player"):
		$Lever_Prompt.visible=false
	pass
	
