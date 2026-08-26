extends Control

const FIRST_ROOM := "res://scenes/loading_scene.tscn"

func _ready() -> void:
	$CenterContainer/VBoxContainer/NewGameButton.grab_focus()

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file(FIRST_ROOM)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
