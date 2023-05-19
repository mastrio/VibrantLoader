extends Node2D


func _on_button_pressed() -> void:
	VibrantServer.load_scene("res://testgame/another_third_test_scene.tscn")
