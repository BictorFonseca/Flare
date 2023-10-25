extends Node2D
@export var done = false
var gates_active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Ladder/Up.apply_scale(Vector2(1,0.6523157208))
	#$Ladder/W.apply_scale(Vector2(1,0.6523157208))
	$Ladder1/CollisionShape2D.apply_scale(Vector2(1,1.3333))
	$Ladder2/CollisionShape2D.apply_scale(Vector2(1,2))
	$Ladder3/CollisionShape2D.apply_scale(Vector2(1,2))
	#$Ladder2/CollisionShape2D.apply_scale(Vector2(1,2))
	#$Ladder3/CollisionShape2D.apply_scale(Vector2(1,2.2))
	#$player.flare_lit = false
	
	#$Ladder/LadderGuide.apply_scale(Vector2(1,0.6523157208))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_tutorial_finished_body_entered(body):
	if body.is_in_group("Player"):
		$Scream.play()
