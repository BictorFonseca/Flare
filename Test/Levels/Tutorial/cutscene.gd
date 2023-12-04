extends Node2D
@export var done = false
var gates_active = true
var scream = preload("res://Levels/Tutorial/scream.tscn")
var alpha = 0
var darken = false
var falling = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Ladder/Up.apply_scale(Vector2(1,0.6523157208))
	#$Ladder/W.apply_scale(Vector2(1,0.6523157208))
	#get_node("../../Player/Flame").hide()
	$Ladder1/CollisionShape2D.apply_scale(Vector2(1,1.3333))
	$Ladder2/CollisionShape2D.apply_scale(Vector2(1,2))
	$Ladder3/CollisionShape2D.apply_scale(Vector2(1,2))
	#$Ladder2/CollisionShape2D.apply_scale(Vector2(1,2))
	#$Ladder3/CollisionShape2D.apply_scale(Vector2(1,2.2))
	#$player.flare_lit = false
	$Trapdoor3.hide()
	$Trapdoor4.hide()
	$Trapdoor5.hide()
	$Trapdoor6.hide()
	
	#$Ladder/LadderGuide.apply_scale(Vector2(1,0.6523157208))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if darken:
		$ColorRect.color = Color("00000000", alpha)
		if alpha < 0.96:
			alpha += 0.02
	if falling:
		$Trapdoor1.hide()
		$Trapdoor2.hide()
		$Trapdoor3.show()
		$Trapdoor4.show()
		$Trapdoor5.show()
		$Trapdoor6.show()
		$Trapdoor3.position.y += 8
		$Trapdoor4.position.y += 9
		$Trapdoor5.position.y += 11
		$Trapdoor6.position.y += 6




func _on_tutorial_finished_body_entered(body):
	if body.is_in_group("Player"):
		var main = get_parent()
		var scream_instance = scream.instantiate()
		falling = true
		main.add_child(scream_instance)
		await get_tree().create_timer(0.5).timeout
		darken = true
