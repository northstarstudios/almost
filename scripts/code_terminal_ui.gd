class_name CodeTerminalUI
extends CanvasLayer

signal access_granted

const ACCESS_CODE := "5963"

@onready var code_input: LineEdit = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/CodeInput
@onready var submit_button: Button = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/SubmitButton
@onready var status_label: Label = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/StatusLabel


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()
	submit_button.pressed.connect(_submit)
	code_input.text_submitted.connect(func(_text: String) -> void: _submit())


func open() -> void:
	show()
	get_tree().paused = true
	code_input.text = ""
	status_label.text = "ENTER FOUR-DIGIT ACCESS CODE"
	code_input.grab_focus()


func close() -> void:
	get_tree().paused = false
	hide()


func _submit() -> void:
	if code_input.text == ACCESS_CODE:
		status_label.text = "ACCESS GRANTED"
		submit_button.disabled = true
		await get_tree().create_timer(0.8, true).timeout
		access_granted.emit()
		close()
	else:
		status_label.text = "ACCESS DENIED"
		code_input.select_all()
		code_input.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("back") and not event.is_echo():
		close()
		get_viewport().set_input_as_handled()
