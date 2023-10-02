extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_ladder=false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if on_ladder==true:
		if Input.is_action_pressed("jump"):
			velocity.y=-speed
			$LadderSFX.play()
		elif Input.is_action_pressed("down"):
			velocity.y=speed
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("run_left", "run_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	#plays sound once it's pressed, but does not loop it 
	#thing we need to do a .mp3 instead of a .wav so that we have the abiliyy to loop it 
	#if Input.is_action_just_pressed("run_left") or Input.is_action_just_pressed("run_right"):
	#	$SteosSFX.play()

	move_and_slide()

func _process(delta):
	if velocity.x < 0.1 and velocity.x > -0.1:
		$AnimatedSprite2D.play("default")
	elif velocity.x < -0.1:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
	elif velocity.x > 0.1:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")
		
