extends Node3D


func _on_button_pressed() -> void:
	VibrantServer.load_scene("res://testgame/test_scene.tscn")
