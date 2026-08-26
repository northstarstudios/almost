extends Control

const FIRST_ROOM := "res://scenes/rooms/beginning/beginning_room.tscn"

@onready var message_label: Label = $MessageLabel
@onready var fade_overlay: ColorRect = $FadeOverlay

func _ready() -> void:
	message_label.modulate.a = 0.0
	fade_overlay.modulate.a = 1.0

	await fade(fade_overlay, 0.0, 0.7)

	await show_message("Creating world...")
	await get_tree().create_timer(1.5).timeout

	await hide_message()
	message_label.text = "Hello?"

	await get_tree().create_timer(0.35).timeout
	await show_message("Hello?")
	await get_tree().create_timer(1.3).timeout

	await fade(fade_overlay, 1.0, 0.6)
	get_tree().change_scene_to_file(FIRST_ROOM)

func show_message(message: String) -> void:
	message_label.text = message
	await fade(message_label, 1.0, 0.35)

func hide_message() -> void:
	await fade(message_label, 0.0, 0.25)

func fade(node: CanvasItem, alpha: float, duration: float) -> void:
	var tween := create_tween()
	tween.tween_property(node, "modulate:a", alpha, duration)
	await tween.finished
