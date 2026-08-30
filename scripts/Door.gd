extends Area2D

@export var NextRoom: Node2D
@export var dialogue_box: DialogueBox

var interaction_lock_time := 0.0

@export var doorID = -1

func _ready() -> void:
	dialogue_box.dialogue_closed_with_id.connect(_on_dialogue_closed)

func _on_dialogue_closed(dialogue_id: int) -> void:
	if dialogue_id != doorID:
		return
	interaction_lock_time = 0.2
	$CollisionShape2D.disabled = true
	$StaticBody2D/CollisionShape2D.disabled = true
	hide()
	NextRoom.show()

func _process(delta: float) -> void:
	if interaction_lock_time > 0.0:
		interaction_lock_time -= delta

func interact() -> void:
	if interaction_lock_time > 0.0 or dialogue_box.visible:
		return

	dialogue_box.show_dialogue("Inner Voice", [
		"A door blocks the way.",
		"You push it open.",
	], doorID)
