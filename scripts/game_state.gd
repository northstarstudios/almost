extends Node

const BEGIN_MARKERS := [
	"user://almost/session.dat",
	"user://almost/recovery.dat",
	"user://almost/archive.dat",
]

var loop_count := 0
var has_begun := false

func _ready() -> void:
	for marker_path in BEGIN_MARKERS:
		if FileAccess.file_exists(marker_path):
			has_begun = true
			return

func record_begin() -> void:
	has_begun = true
	DirAccess.make_dir_recursive_absolute("user://almost")

	for marker_path in BEGIN_MARKERS:
		var marker := FileAccess.open(marker_path, FileAccess.WRITE)
		if marker != null:
			marker.store_string("has_begun=true\n")

func advance_loop() -> void:
	loop_count += 1
