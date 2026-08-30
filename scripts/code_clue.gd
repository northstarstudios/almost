class_name CodeClue
extends Area2D

@export var dialogue_box: DialogueBox

var interaction_lock_time := 0.0


func _ready() -> void:
	dialogue_box.dialogue_closed.connect(_on_dialogue_closed)


func _process(delta: float) -> void:
	interaction_lock_time = maxf(interaction_lock_time - delta, 0.0)


func interact() -> void:
	if interaction_lock_time > 0.0 or dialogue_box.visible:
		return

	if GameState.loop_count == 0:
		dialogue_box.show_dialogue("DISPLAY", [
			"A number flashes behind the glass: 5963.",
			"The keypad is sealed away. There is no path to it.",
			"If you are stuck, press ESC and choose RESET.",
			"The room will rebuild. It always does."
		])
	else:
		dialogue_box.show_dialogue("DISPLAY", [
			"5963.",
			"The glass is gone."
		])


func _on_dialogue_closed() -> void:
	interaction_lock_time = 0.2
