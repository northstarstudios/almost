extends Area2D

@export var HiddenRoom: TileMapLayer
@export var dialogue_box: DialogueBox

var interaction_lock_time := 0.0

func _ready() -> void:
	dialogue_box.dialogue_closed.connect(_on_dialogue_closed)

func _on_dialogue_closed() -> void:
	interaction_lock_time = 0.2
	$CollisionShape2D.disabled = true
	$StaticBody2D/CollisionShape2D.disabled = true
	hide()
	HiddenRoom.show()

func _process(delta: float) -> void:
	if interaction_lock_time > 0.0:
		interaction_lock_time -= delta

func interact() -> void:
	if interaction_lock_time > 0.0 or dialogue_box.visible:
		return

	dialogue_box.show_dialogue("", [
		"There seems to be a hidden button...",
		"You press it and a hidden door opens!",
	])
