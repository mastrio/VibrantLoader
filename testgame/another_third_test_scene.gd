extends Node3D


func _on_button_pressed() -> void:
	VibrantLoader.load_scene("res://testgame/test_scene.tscn")


func _on_button_2_pressed() -> void:
	VibrantLoader.load_scene("res://testgame/fourth_test_scene.tscn")
