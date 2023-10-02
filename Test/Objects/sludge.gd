extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.speed *= .05
		body.jump_velocity = 0


func _on_body_exited(body):
	if body.is_in_group("Player"):
		body.speed *= 20
		body.jump_velocity = -400