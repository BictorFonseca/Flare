extends Area2D
signal text

@export var wall_text = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# TODO: code to check whether or not the player has entered the 2d node


func _on_body_entered(body):
	text.emit(wall_text);
	print("body entered");

func _on_body_exited(body):
	text.emit("hide");
	print("body exited")
