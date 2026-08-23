extends CharacterBody2D

@export var speed: float = 120.0

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	
	velocity = direction * speed
	move_and_slide()
