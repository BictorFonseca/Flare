extends CharacterBody2D
#implementing seeing what key is pressed so it can be carried forwards between levels
#so that if an inventory is selected then the functionality is openeed - going to be done w 
#inventory_slot_selected

@export var speed = 300.0
@export var jump_velocity = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var flare_lit = false
var light_flare = false
var flare_die = false
var on_ladder=false
var on_lever=-1
var lever_list=[0,0,0,0,0,0,0,0,0]
var has_mineral1 = false
var has_mineral2 = false
var has_mineral3 = false
var finished_tutorial = false
var inRed=false
var climbing = true
var game_over=false
var credit=false
var lock=false
var locked=false

var inventory_slot_selected = 1
#var lever2=false
#var lever2_signal=false

func _ready():
	$PointLight2D.energy = 0
	$Flame.play("unlit")
	

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if on_ladder==true and not locked:
		if Input.is_action_pressed("jump") and not $LadderSFX.playing:
			velocity.y=-speed
			$LadderSFX.play()
		elif Input.is_action_pressed("down"):
			velocity.y=speed
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not locked:
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("run_left", "run_right")
	if direction and not locked:# and not on_ladder:
		velocity.x = direction * speed
		if on_ladder and Input.is_action_pressed('jump'):
			velocity.x = direction * speed / 5
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if self.position.y <=-1:
		#get_tree().quit()
		pass
	
	#plays sound once it's pressed, but does not loop it 
	#thing we need to do a .mp3 instead of a .wav so that we have the abiliyy to loop it 
	#if Input.is_action_just_pressed("run_left") or Input.is_action_just_pressed("run_right"):
	#	$SteosSFX.play()
	if on_lever>=0 and lever_list[on_lever]==0 and Input.is_action_just_pressed("Interact"):
		lever_list[on_lever]=1
		$SwitchSound.play()
		$GateSFX.play()
		
	

	move_and_slide()

func _process(delta):
	#Flame animation
	#Walking animations
	if velocity.x < 0.1 and velocity.x > -0.1 and velocity.y == 0:
		$AnimatedSprite2D.play("default")
	elif velocity.x < -0.1:
		$AnimatedSprite2D.flip_h = true
		$Flame.flip_h = true
		$Flame.position.x = -16.5
		$Flame.position.y = -8
		$PointLight2D.position.x = -18
		$PointLight2D.position.y = -5
		$AnimatedSprite2D.play("walk")
	elif velocity.x > 0.1:
		$AnimatedSprite2D.flip_h = false
		$Flame.position.x = 16.5
		$Flame.position.y = -8
		$PointLight2D.position.x = 18
		$PointLight2D.position.y = -5
		$Flame.flip_h = false
		$AnimatedSprite2D.play("walk")
	
	# Jumping Animations
	if on_ladder == false and velocity.y < 0:
		$AnimatedSprite2D.play("jump_up")
	elif on_ladder == false and velocity.y > 0:
		$AnimatedSprite2D.play("jump_down")
	
	# Climbing Animations
	if on_ladder == true and is_on_floor() == false:
		if  $AnimatedSprite2D.animation != "climb":
			$AnimatedSprite2D.play("climb")
			
		$Flame.play("unlit")
	else:
		if flare_lit:
			$Flame.play("fire")
		
	
	#Footstep SFX
	if (velocity.x < -0.1 or velocity.x > 0.1) and is_on_floor():
		if not $FootstepSFX.playing:
			#print("footsteps")
			$FootstepSFX.play()
	else:
		$FootstepSFX.stop()
		
	#Lighting Flare
	if light_flare:
		_light_flare()
		light_flare = false
		#print("Activating flare and startTimer")
		
	#Killing Flare
	if flare_die or (game_over and self.position.x >=245 and not lock):
		#Named lock in case we want to lock the players movement
		$NormalFlareSFX.stop()
		lock=true
		_kill_flare()
		flare_die = false
		
		

	'''if Input.is_action_just_released("select_1") or Input.is_action_just_released("select_2") or Input.is_action_just_released("select_3") or Input.is_action_just_released("select_4"):
		inventory_slot_selected = 1
		print("inventory slot selected:", inventory_slot_selected)'''
		
		
	if Input.is_action_just_pressed("select_1") and not inRed:
		inventory_slot_selected = 1
		
		#print("inventory slot selected:", inventory_slot_selected)
		
		$InventorySwitchSFX.play()
		$PointLight2D.color = Color("ffffce")
	elif Input.is_action_just_pressed("select_2") and not inRed:
		inventory_slot_selected = 2
		#print("inventory slot selected:", inventory_slot_selected)
		
		$InventorySwitchSFX.play()
		if not has_mineral1:
			$PointLight2D.color = Color("ffffce")
		else:
			$PointLight2D.color = Color("89fae7")
	elif Input.is_action_just_pressed("select_3"):
		inventory_slot_selected = 3
		#print("inventory slot selected:", inventory_slot_selected)
		$InventorySwitchSFX.play()
		if not has_mineral2:
			$PointLight2D.color = Color("ffffce")
		else:
			$PointLight2D.color = Color("ff9f98")
	elif Input.is_action_just_pressed("select_4") and not inRed:
		inventory_slot_selected = 4
		#print("inventory slot selected:", inventory_slot_selected)
		$InventorySwitchSFX.play()
		if not has_mineral3:
			$PointLight2D.color = Color("ffffce")
		else:
			$PointLight2D.color = Color("e669ff")

func _light_flare():
	$Flame.play("fire")
	$LightFlareSFX.play()
	flare_lit = true
	await get_tree().create_timer(0.2).timeout
	$NormalFlareSFX.play()
	get_parent().startTimer=true
	
	
func _kill_flare():
	var energy = 1.3
	while energy > 0.05:
		energy -= 0.05
		$PointLight2D.energy = energy
		await $FlareTimer.timeout
		#print("is it done now?")
	credit=true
	$Crying.play()
	$EndingMusic.play()
	$PointLight2D.enabled=false
	#print("Yoo we;re done")
		
		
		
		

func _on_timer_timeout():
	if flare_lit:
		$PointLight2D.energy = randf_range(1.1, 1.4)
		

#FOR USE LATER
func _on_light_flare_timer_timeout(delta):
	if flare_lit:
		$PointLight2D.scale.x = randf_range(0.49,0.51)
		$PointLight2D.scale.y = randf_range(0.49,0.51)
	if flare_lit and inventory_slot_selected == 1:
		$PointLight2D.scale.x = randf_range(0.55,0.57)
		$PointLight2D.scale.y = randf_range(0.55,0.57)
	
	'''for i in range(12):
		$PointLight2D.energy += 0.1
	flare_lit = true'''

