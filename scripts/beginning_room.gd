extends Node2D

@onready var reset_transition: ResetTransition = $ResetTransition
@onready var opening_fade: ColorRect = $OpeningFade/Overlay

func _ready() -> void:
	reset_transition.transition_finished.connect(_on_reset_transition_finished)
	opening_fade.modulate.a = 1.0
	var tween := create_tween()
	tween.tween_property(opening_fade, "modulate:a", 0.0, 0.8)
	tween.tween_callback(opening_fade.hide)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_R:
		reset_transition.play()

func _on_reset_transition_finished() -> void:
	GameState.complete_reset()
