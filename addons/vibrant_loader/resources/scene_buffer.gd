class_name SceneBuffer
extends Resource


@export var scene_name: String : set = set_scene_name, get = get_scene_name
@export var loading_screen: PackedScene : set = set_loading_screen, get = get_loading_screen


func set_scene_name(name: String) -> SceneBuffer:
	scene_name = name
	return self

func get_scene_name() -> String:
	return scene_name

func set_loading_screen(screen: PackedScene) -> SceneBuffer:
	loading_screen = screen
	return self

func get_loading_screen() -> PackedScene:
	return loading_screen
