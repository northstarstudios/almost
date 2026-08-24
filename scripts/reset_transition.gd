class_name ResetTransition
extends CanvasLayer

signal transition_finished

@onready var overlay: ColorRect = $Overlay
@onready var shader_material: ShaderMaterial = overlay.material as ShaderMaterial

var is_playing := false

func _ready() -> void:
	overlay.hide()

func play() -> void:
	if is_playing:
		return

	is_playing = true
	overlay.show()
	shader_material.set_shader_parameter("progress", 0.0)

	var tween := create_tween()
	tween.tween_method(Callable(self, "_set_progress"), 0.0, 1.0, 0.72)
	tween.tween_callback(Callable(self, "_finish"))

func _set_progress(value: float) -> void:
	shader_material.set_shader_parameter("progress", value)

func _finish() -> void:
	transition_finished.emit()
