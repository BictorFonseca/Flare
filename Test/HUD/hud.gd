extends CanvasLayer
var time = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory.hide()
	$TimerAnimation.hide()
	$Selector.hide()
	#$GameTimer.start()
	#$TimerLabel.text = '10mins 0s left'
	#$TimerAnimation.play("start")
	$BGMusic.play()
	
	$Back.hide()
	$Movement.hide()
	$Inventory1.hide()
	$Inventory2.hide()
	$Inventory3.hide()
	$Inventory4.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#the shifting of hte shifter will be hard coded with coordinates 
	if Input.is_action_pressed("select_1"):
		$Selector.position.x = 460
	if Input.is_action_pressed('select_2'):
		$Selector.position.x = 469 + 67
	if Input.is_action_pressed("select_3"):
		$Selector.position.x = 469 + 67 * 2.15
	if Input.is_action_pressed('select_4'):
		$Selector.position.x = 469 + 67 * 3.3
		
#here, we update the number for the time

func updateTime(timeChange):
	if timeChange < 0:
		$TimerLabel.text = "Game Over"
		$TimerAnimation.play("end")
	else:
		var mins = timeChange / 60
		var secs = timeChange % 60
		var changed = (str(mins) + "mins " + str(secs) + "s left")
		#print(changed)
		$TimerLabel.text = changed


func _on_game_timer_timeout():
	#print('timeout' + str(time))
	time -= 1
	self.updateTime(time)


func _on_play_button_pressed():
	$"Flare!".hide()
	$Instructions.position.x = 0
	$Instructions.position.y = 0
	$Inventory1.show()
	#$Instructions.theme_override_font_sizes/font_size = 20
	$PlayButton.hide()
	$Background.hide()
	$Inventory.show()
	$TimerAnimation.show()
	$Selector.show()
	$GameTimer.start()
	$TimerLabel.text = '10mins 0s left'
	$TimerAnimation.play("start")


func _on_instructions_pressed():
	$PlayButton.hide()
	$Back.show()
	$Instructions.hide()
	$Movement.show()


func _on_back_pressed():
	$Back.hide()
	if time == 600:
		$PlayButton.show()
	else:
		$PlayButton.hide()
	$Movement.hide()
	$Instructions.show()


func _on_area_2_for_mineral_1_body_entered(body):
	if body.is_in_group('Player'):
		print("Character has touched the mineral")
		$Inventory2.show()
	
