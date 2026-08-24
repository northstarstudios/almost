class_name DialogueBox
extends CanvasLayer

signal dialogue_closed

@export_range(1.0, 120.0, 1.0) var characters_per_second := 45.0

@onready var name_label: Label = $Panel/MarginContainer/VBoxContainer/NameLabel
@onready var text_label: Label = $Panel/MarginContainer/VBoxContainer/TextLabel
@onready var prompt_label: Label = $Panel/MarginContainer/VBoxContainer/PromptLabel
@onready var typing_sound: AudioStreamPlayer = $TypingSound

var lines: Array[String] = []
var line_index := 0
var current_line := ""
var character_index := 0
var character_timer := 0.0
var is_typing := false

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if not visible or not is_typing:
		return

	character_timer += delta
	var seconds_per_character := 1.0 / characters_per_second

	while character_timer >= seconds_per_character and is_typing:
		character_timer -= seconds_per_character
		reveal_next_character()

func show_dialogue(speaker: String, new_lines: Array[String]) -> void:
	if new_lines.is_empty():
		return

	name_label.text = speaker
	lines = new_lines
	line_index = 0
	show()
	start_current_line()

func start_current_line() -> void:
	current_line = lines[line_index]
	character_index = 0
	character_timer = 0.0
	text_label.text = ""
	prompt_label.text = "Press E to skip"
	is_typing = true

func reveal_next_character() -> void:
	var character := current_line[character_index]
	text_label.text += character
	character_index += 1

	if character != " " and character != "\n":
		typing_sound.pitch_scale = randf_range(0.92, 1.08)
		typing_sound.play()

	if character_index >= current_line.length():
		is_typing = false
		update_prompt()

func update_prompt() -> void:
	if line_index == lines.size() - 1:
		prompt_label.text = "Press E to close"
	else:
		prompt_label.text = "Press E to continue"

func close_dialogue() -> void:
	hide()
	dialogue_closed.emit()

func _unhandled_input(event: InputEvent) -> void:
	if not visible or event.is_echo():
		return

	if event.is_action_pressed("interact"):
		if is_typing:
			text_label.text = current_line
			character_index = current_line.length()
			is_typing = false
			update_prompt()
		else:
			line_index += 1

			if line_index >= lines.size():
				close_dialogue()
			else:
				start_current_line()

		get_viewport().set_input_as_handled()
