extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_glow_timer_timeout():
	$PointLight2D2.energy = randf_range(2.0, 2.3)
