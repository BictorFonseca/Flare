extends CanvasLayer
var time = 900
var timerPaused=false
signal start_game
var started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Inventory.hide()
	$TimerAnimation.hide()
	$Selector.hide()
	#$GameTimer.start()
	#$TimerLabel.text = '10mins 0s left'
	#$TimerAnimation.play("start")
	$BGMusic.play()
	$FlareIcon.play()
	
	$Back.hide()
	$InstructionsText.hide()
	$QuitConfirmation.hide()
	$Inventory1.hide()
	$Inventory2.hide()
	$Inventory3.hide()
	$Inventory4.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#the shifting of hte shifter will be hard coded with coordinates 
	if Input.is_action_pressed("select_1") and not get_node("../player").inRed:
		$Selector.position.x = 460
	if Input.is_action_pressed('select_2') and not get_node("../player").inRed:
		$Selector.position.x = 469 + 67
	if Input.is_action_pressed("select_3"):
		$Selector.position.x = 469 + 67 * 2.15
	if Input.is_action_pressed('select_4') and not get_node("../player").inRed:
		$Selector.position.x = 469 + 67 * 3.3
	if get_parent().startTimer:
		$GameTimer.start()
		get_parent().startTimer=false
		$TimerLabel.show()
		$TimerAnimation.show()
		
#here, we update the number for the time

func updateTime(timeChange):
	if timeChange < 0:
		$TimerLabel.text = "Game Over"
		$TimerAnimation.play("end")
		$TimerAnimation.scale = 0.8
	else:
		var mins = timeChange / 60
		var secs = timeChange % 60
		var changed = (str(mins) + "M " + str(secs) + "S LEFT")
		#print(changed)
		$TimerLabel.text = changed


func _on_game_timer_timeout():
	#print('timeout' + str(time))
	if not timerPaused:
		time -= 1
		self.updateTime(time)


func _on_play_button_pressed():
	#print('timer should have staretd')
	$"Flare!".hide()
	$FlareIcon.hide()
	$Instructions.position.x = 0
	$Instructions.position.y = 0
	var scale = Vector2(0.5, 0.5)
	$Quit.position.x=995
	$Quit.position.y=23
	$Quit.set_size(Vector2(139,53))
	$Instructions.set_scale(scale)
	$Inventory1.show()
	#$Instructions.theme_override_font_sizes/font_size = 20
	$PlayButton.hide()
	$Background.hide()
	$Quit.hide()
	$Inventory.show()
	#$TimerAnimation.show()
	$Selector.show()
	$TimerLabel.text = '10M 0S LEFT'
	$TimerLabel.hide()
	$TimerAnimation.play("default")
	start_game.emit()


func _on_instructions_pressed():
	$FlareIcon.hide()
	$PlayButton.hide()
	$Quit.hide()
	$Background.show()
	$Inventory.hide()
	$TimerLabel.hide()
	$TimerAnimation.hide()
	$Selector.hide()
	$Inventory1.hide()
	if started:
		$Quit.show()
	else:
		$Quit.hide()
	$Back.show()
	$Instructions.hide()
	$InstructionsText.show()
	timerPaused=true


func _on_back_pressed():
	$Back.hide()
	if not started:
		$PlayButton.show()
		$FlareIcon.show()
		$Quit.show()
	else:
		$PlayButton.hide()
		$FlareIcon.hide()
		$Quit.hide()
		$Background.hide()
		$Inventory.show()
		$TimerLabel.show()
		$TimerAnimation.show()
		$Selector.show()
		$Inventory1.show()

	$InstructionsText.hide()
	$Instructions.show()
	timerPaused = false


func _on_area_2_for_mineral_1_body_entered(body):
	if body.is_in_group('Player'):
		print("Character has touched the mineral")
		$Inventory2.show()
	


func _on_quit_pressed():
	$InstructionsText.hide()
	$Quit.hide()
	$Back.hide()
	$QuitConfirmation.show()


func _on_no_continue_pressed():
	$QuitConfirmation.hide()
	$InstructionsText.show()
	$Quit.show()
	$Back.show()


func _on_yes_quit_pressed():
	$FlareIcon.show()
	$PlayButton.show()
	$Instructions.show() # this isn't working
	$Quit.show() # this also isn't working
	$Background.show()
	
	$Back.hide()
	$InstructionsText.hide()
	$QuitConfirmation.hide()
	
	# need to find a way to actually restart the game
	
