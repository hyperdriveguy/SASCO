extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Handles zoom
func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		zoom *= 2
	elif Input.is_action_just_pressed("zoom_out"):
		zoom /= 2
