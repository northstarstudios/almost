class_name PauseMenu
extends CanvasLayer

signal resume_requested
signal reset_requested
signal title_requested

@onready var resume_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResumeButton
@onready var reset_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ResetButton
@onready var title_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/TitleButton

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

	resume_button.pressed.connect(_on_resume_button_pressed)
	reset_button.pressed.connect(_on_reset_button_pressed)
	title_button.pressed.connect(_on_title_button_pressed)

func open() -> void:
	show()
	get_tree().paused = true
	resume_button.grab_focus()

func close() -> void:
	get_tree().paused = false
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("back") and not event.is_echo():
		resume_requested.emit()
		get_viewport().set_input_as_handled()

func _on_resume_button_pressed() -> void:
	resume_requested.emit()

func _on_reset_button_pressed() -> void:
	reset_requested.emit()

func _on_title_button_pressed() -> void:
	title_requested.emit()
