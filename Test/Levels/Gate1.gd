extends StaticBody2D

@export var gateID=0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if get_parent().gates_active:
	if get_node("../../player").lever_list[gateID]:
		$GateCol.set_deferred("disabled", true)
		$GateArt.visible=false
		
	pass
