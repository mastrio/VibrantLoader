@icon("res://addons/vibrant_loader/script/vibrant_loader.svg")
extends Node


signal loading_scene

const DEFAULT_LOADING_SCREEN: PackedScene = preload("res://addons/vibrant_loader/default_loading_screen.tscn")

var loading_screen_layer: int = 100
var can_load_scene = true


func log_output(message: String) -> void:
	print_rich("[color=green]VibrantLoader:Log[/color] {0}".format([message]))

func log_error(message: String) -> void:
	print_rich("[shake][color=red]VibrantLoader:Error[/color][/shake] {0}".format([message]))

func load_scene(scene_to_load: String, loading_screen: PackedScene = DEFAULT_LOADING_SCREEN) -> void:
	if can_load_scene:
		can_load_scene = false
		var load_screen: LoadingScreen = loading_screen.instantiate()
		load_screen.scene_to_load = scene_to_load
		get_tree().root.add_child(load_screen)
		
		loading_scene.emit(scene_to_load, load_screen)
		load_screen._loading_start()
	else:
		log_output("Failed to load scene, another scene is currently loading")
