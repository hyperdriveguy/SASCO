extends CharacterBody2D

@export var move_speed: float = 300.0

@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var initial_postion = position

var can_interact = false

func _ready():
	pass

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	update_animation_blend(direction)
	update_animation_state(direction)
	velocity = direction * move_speed
	if Input.is_action_just_pressed("reset_player"):
		position = initial_postion
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept") and can_interact:
		print("Interacted with NPC!")

func update_animation_blend(input_direction: Vector2):
	if input_direction != Vector2.ZERO:
		$InteractArea.rotation = -input_direction.angle_to(Vector2(0, 1))
		$AnimationTree.set("parameters/idle/blend_position", input_direction)
		$AnimationTree.set("parameters/walk/blend_position", input_direction)

func update_animation_state(input_direction: Vector2):
	if input_direction == Vector2.ZERO:
		animation_state.travel("idle")
	else:
		animation_state.travel("walk")

func _on_interact_area_area_entered(area):
	print("entered area")
	can_interact = true

func _on_interact_area_area_exited(area):
	print("exited area")
	can_interact = false
