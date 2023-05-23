@icon("res://addons/vibrant_loader/script/vibrant_server.svg")
extends Node


var default_loading_screen: PackedScene = preload("res://addons/vibrant_loader/default_loading_screen.tscn")

var can_load_scene = true


func log_output(message: String) -> void:
	print("[VibrantLoader:Log] " + message)

func log_error(message: String) -> void:
	printerr("[VibrantLoader:Error] " + message)

func load_scene(scene_to_load: String, loading_screen: PackedScene = default_loading_screen) -> void:
	if can_load_scene:
		can_load_scene = false
		var load_screen: LoadingScreen = loading_screen.instantiate()
		load_screen.scene_to_load = scene_to_load
		get_tree().root.add_child(load_screen)
		await get_tree().create_timer(1)
		load_screen._loading_start()
	else:
		log_output("Failed to load scene, another scene is currently loading")
