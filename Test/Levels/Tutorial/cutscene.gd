extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Ladder/Up.apply_scale(Vector2(1,0.6523157208))
	#$Ladder/W.apply_scale(Vector2(1,0.6523157208))
	#$Ladder/CollisionShape2D.apply_scale(Vector2(1,2.7))
	#$Ladder2/CollisionShape2D.apply_scale(Vector2(1,2))
	#$Ladder3/CollisionShape2D.apply_scale(Vector2(1,2.2))
	$player.flare_lit = false
	
	#$Ladder/LadderGuide.apply_scale(Vector2(1,0.6523157208))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
