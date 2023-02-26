extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play("idle_down")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_looped():
	if animation == "walk_down" or animation == "walk_up":
		flip_h = not flip_h

func _on_animation_changed():
	if animation == "idle_left" or animation == "walk_left":
		flip_h = false
	elif animation == "idle_right" or animation == "walk_right":
		flip_h = true
