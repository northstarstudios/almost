extends Area2D

@export var dialogue_box: DialogueBoxEvilAster
@export var dialogue_FirstLoop: Array[String]
@export var dialogue_OtherLoops: Array[String]
@export var dialogue_exhausted: Array[String]

@export var dialogueID = -1

var interaction_lock_time := 0.0

func _ready() -> void:
	dialogue_box.dialogue_closed.connect(_on_dialogue_closed)

func _on_dialogue_closed() -> void:
	interaction_lock_time = 0.2

func _process(delta: float) -> void:
	if interaction_lock_time > 0.0:
		interaction_lock_time -= delta

func interact() -> void:
	if interaction_lock_time > 0.0 or dialogue_box.visible:
		return

	if GameState.loop_count == 0:
		dialogue_box.show_dialogue("Aster", dialogue_FirstLoop, dialogueID)
		"""
		dialogue_box.show_dialogue("Aster", [
			"Oh!",
			"You made it.",
			"I was worried this place had stopped making people."
		])
		"""
	else:
		dialogue_box.show_dialogue("Aster", dialogue_OtherLoops, dialogueID)
		
		"""
		dialogue_box.show_dialogue("Aster", [
			"You came back.",
			"...",
			"That's not meant to happen."
		])
		"""
