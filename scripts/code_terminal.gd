class_name CodeTerminal
extends Area2D

@export var terminal_ui: CodeTerminalUI
@export var locked_door: Node
@export var required_loop := 1

@onready var interaction_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	terminal_ui.access_granted.connect(_on_access_granted)
	_set_available(GameState.loop_count >= required_loop)


func interact() -> void:
	if GameState.loop_count >= required_loop and not terminal_ui.visible:
		terminal_ui.open()


func _set_available(is_available: bool) -> void:
	interaction_shape.set_deferred("disabled", not is_available)
	modulate = Color.WHITE if is_available else Color(0.35, 0.35, 0.35, 0.8)


func _on_access_granted() -> void:
	if locked_door.has_method("unlock"):
		locked_door.unlock()
	queue_free()
