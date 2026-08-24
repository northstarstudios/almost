extends Area2D

@export var message_label: Label
var player_nearby := false

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_nearby = true

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_nearby = false
		message_label.hide()

func _process(_delta: float) -> void:
	if player_nearby and Input.is_action_just_pressed("interact"):
		message_label.show()
