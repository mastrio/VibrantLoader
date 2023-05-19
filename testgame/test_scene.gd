extends Node2D


func _on_button_pressed() -> void:
	VibrantServer.load_scene("res://testgame/test_scene_2.tscn")
