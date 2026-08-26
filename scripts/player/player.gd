extends CharacterBody2D

@export var speed: float = 120.0

@onready var interaction_hitbox: Area2D = $InteractionHitbox

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	
	velocity = direction * speed
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("interact") or event.is_echo():
		return

	for area in interaction_hitbox.get_overlapping_areas():
		if area.has_method("interact"):
			area.interact()
			get_viewport().set_input_as_handled()
			return
