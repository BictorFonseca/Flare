extends Area2D
signal text
@export var signText = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	text.emit(signText)
	$SignLabel.text = signText
	
func _on_body_exited(body):
	text.emit("hide")
	$SignLabel.text = ""
