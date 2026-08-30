extends Area2D

@export var NextRoom: Node2D
@export var dialogue_box: DialogueBox
@export var locked := false

var interaction_lock_time := 0.0

@export var doorID = -1

func _ready() -> void:
	dialogue_box.dialogue_closed_with_id.connect(_on_dialogue_closed)

func _on_dialogue_closed(dialogue_id: int) -> void:
	if dialogue_id != doorID:
		return
	interaction_lock_time = 0.2
	unlock()

func _process(delta: float) -> void:
	if interaction_lock_time > 0.0:
		interaction_lock_time -= delta

func interact() -> void:
	if interaction_lock_time > 0.0 or dialogue_box.visible:
		return
	if locked:
		dialogue_box.show_dialogue("Inner Voice", [
			"The door is locked.",
			"It needs a four-digit access code."
		])
		return

	dialogue_box.show_dialogue("Inner Voice", [
		"A door blocks the way.",
		"You push it open.",
	], doorID)


func unlock() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	hide()
	NextRoom.show()
