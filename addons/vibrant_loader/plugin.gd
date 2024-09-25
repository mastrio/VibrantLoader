@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("VibrantLoader", "res://addons/vibrant_loader/scripts/vibrant_loader.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("VibrantLoader")
