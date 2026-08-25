extends Area2D

@export var dialogue_box: DialogueBox

var player_nearby := false
var interaction_lock_time := 0.0

func _ready() -> void:
	dialogue_box.dialogue_closed.connect(_on_dialogue_closed)

func _on_dialogue_closed() -> void:
	interaction_lock_time = 0.2

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_nearby = true

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_nearby = false

func _process(delta: float) -> void:
	if interaction_lock_time > 0.0:
		interaction_lock_time -= delta
		return

	if player_nearby and not dialogue_box.visible:
		if Input.is_action_just_pressed("interact"):
			if GameState.loop_count == 0:
				dialogue_box.show_dialogue("Guide", [
					"Hello. I haven't seen you before.",
					"Please be careful."
				])
			else:
				dialogue_box.show_dialogue("Guide", [
					"...",
					"Have I seen you before?"
				])
