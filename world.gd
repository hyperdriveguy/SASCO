extends Node2D

@export var first_level: String = "res://outside_level.tscn"
var current_level = null

# Called when the node enters the scene tree for the first time.
func _ready():
	change_level(first_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Change the level to a new one at a given path
func change_level(new_level_path: String) -> void:
	if current_level != null:
		remove_child(current_level)
	current_level = load(new_level_path).instantiate()
	add_child(current_level)
	var player_spawn = current_level.get_node("PlayerSpawn").position
	$PlayerCharacter.move_player(Vector2.ZERO)
	$PlayerCharacter.position = player_spawn
