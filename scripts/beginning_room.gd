extends Node2D

@onready var reset_transition: ResetTransition = $ResetTransition

func _ready() -> void:
	reset_transition.transition_finished.connect(_on_reset_transition_finished)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_R:
		reset_transition.play()

func _on_reset_transition_finished() -> void:
	GameState.complete_reset()
