extends CharacterBody2D

const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var accel_mode = false

@onready var initial_postion = position

func _ready():
	$AnimatedSprite2D.play()


func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	if not accel_mode:
		if direction_x:
			velocity.x = direction_x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		if direction_y:
			velocity.y = direction_y * SPEED
		else:
			velocity.y = move_toward(velocity.x, 0, SPEED)
	else:
		if direction_x:
			velocity.x += direction_x * SPEED / 8
		if direction_y:
			velocity.y += direction_y * SPEED / 8
			
	if Input.is_action_just_pressed("ui_accept"):
		if accel_mode:
			$Label.text = "velocity mode"
		else:
			$Label.text = "acceleration mode"
		accel_mode = not accel_mode
		
	if Input.is_action_just_pressed("reset_player"):
		position = initial_postion

	move_and_slide()
