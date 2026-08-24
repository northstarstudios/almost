class_name DialogueBox
extends CanvasLayer

@onready var name_label: Label = $Panel/MarginContainer/VBoxContainer/NameLabel
@onready var text_label: Label = $Panel/MarginContainer/VBoxContainer/TextLabel
@onready var prompt_label: Label = $Panel/MarginContainer/VBoxContainer/PromptLabel

var lines: Array[String] = []
var line_index := 0

func _ready() -> void:
	hide()

func show_dialogue(speaker: String, new_lines: Array[String]) -> void:
	if new_lines.is_empty():
		return

	name_label.text = speaker
	lines = new_lines
	line_index = 0
	show_current_line()
	show()

func show_current_line() -> void:
	text_label.text = lines[line_index]

	if line_index == lines.size() - 1:
		prompt_label.text = "Press E to close"
	else:
		prompt_label.text = "Press E to continue"

func _unhandled_input(event: InputEvent) -> void:
	if not visible or event.is_echo():
		return

	if event.is_action_pressed("interact"):
		line_index += 1

		if line_index >= lines.size():
			hide()
		else:
			show_current_line()

		get_viewport().set_input_as_handled()
