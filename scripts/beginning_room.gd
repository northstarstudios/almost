extends Node2D

const TITLE_SCENE := "res://scenes/intro_scene.tscn"

@onready var reset_transition: ResetTransition = $ResetTransition
@onready var opening_fade: ColorRect = $OpeningFade/Overlay

var reset_returns_to_title := false

func _ready() -> void:
	reset_transition.transition_finished.connect(_on_reset_transition_finished)
	$OpeningFade.show()
	opening_fade.modulate.a = 1.0
	var tween := create_tween()
	tween.tween_property(opening_fade, "modulate:a", 0.0, 0.8)
	tween.tween_callback(opening_fade.hide)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("back"):
		start_reset(true)
	elif event.is_action_pressed("reset_test"):
		start_reset(false)

func reset_to_title() -> void:
	start_reset(true)

func start_reset(return_to_title: bool) -> void:
	if reset_transition.is_playing:
		return

	reset_returns_to_title = return_to_title
	reset_transition.play()

func _on_reset_transition_finished() -> void:
	GameState.advance_loop()

	if reset_returns_to_title:
		get_tree().change_scene_to_file(TITLE_SCENE)
	else:
		get_tree().reload_current_scene()
