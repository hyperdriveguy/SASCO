extends CharacterBody2D

@export var move_speed: float = 300.0

@onready var animation_state = $AnimationTree.get("parameters/playback")
@onready var initial_postion: Vector2 = position
@onready var nearest_interactable: Interactable = null

func _ready():
	$InteractIndicator.play("default")
	DialogueManager.dialogue_finished.connect($InteractIndicator.show)

func _physics_process(delta):
	move_and_slide()

func update_animation_blend(input_direction: Vector2) -> void:
	if input_direction != Vector2.ZERO:
		$InteractArea.rotation = -input_direction.angle_to(Vector2(0, 1))
		$AnimationTree.set("parameters/idle/blend_position", input_direction)
		$AnimationTree.set("parameters/walk/blend_position", input_direction)

func update_animation_state(input_direction: Vector2) -> void:
	if input_direction == Vector2.ZERO:
		animation_state.travel("idle")
	else:
		animation_state.travel("walk")
		
func move_player(direction: Vector2) -> void:
	update_animation_blend(direction)
	update_animation_state(direction)
	velocity = direction * move_speed

func _unhandled_input(event):
	var input_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	move_player(input_direction)
	if event.is_action_pressed("ui_accept"):
		get_viewport().set_input_as_handled()
		if is_instance_valid(nearest_interactable):
			move_player(Vector2.ZERO)
			$InteractIndicator.hide()
			nearest_interactable.emit_signal("interacted")

# Function adapted from an example here: https://www.youtube.com/watch?v=-rytm4o1ndE
func check_nearest_interactable() -> void:
	var areas: Array[Area2D] = $InteractArea.get_overlapping_areas()
	if not len(areas) > 0:
		$InteractIndicator.hide()
		nearest_interactable = null
		return
	$InteractIndicator.show()
	var shortest_distance: float = INF
	var next_nearest_interactable: Interactable = null
	for area in areas:
		var distance: float = area.global_position.distance_to(global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			next_nearest_interactable = area
	
	if next_nearest_interactable != nearest_interactable or not is_instance_valid(next_nearest_interactable):
		nearest_interactable = next_nearest_interactable

func _on_interact_area_entered_exited(area):
	check_nearest_interactable()
