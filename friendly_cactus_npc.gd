extends CharacterBody2D

@export var dialogue_start = "bruh_time"

@onready var resource = load("res://cactus.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_interactable_interacted():
	DialogueManager.show_example_dialogue_balloon(resource, dialogue_start)
