extends Node2D

var obtained_mineral = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$WallWritingLabel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_wall_writing_text(text):
	if text == "show":
		$WallWritingLabel.show()
	elif text == "hide":
		$WallWritingLabel.hide()

func _on_area_2_for_mineral_1_body_entered(body):
	obtained_mineral = true
