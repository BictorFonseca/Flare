extends CanvasLayer
var time = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTimer.start()
	$TimerLabel.text = '600s'

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
	var changed = (str(timeChange) + "s")
	print(changed)
	$TimerLabel.text = changed
	
	


func _on_game_timer_timeout():
	print('timeout' + str(time))
	time -= 1
	self.updateTime(time)
