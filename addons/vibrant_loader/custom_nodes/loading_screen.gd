@icon("res://addons/vibrant_loader/custom_nodes/loading_screen.svg")
class_name LoadingScreen
extends CanvasLayer


var scene_to_load: String

var loading_progress: Array = []


func _process(_delta: float) -> void:
	layer = 100

func _loading_start() -> void:
	_scene_load()

func _loading_end() -> void:
	_loading_completed()

func _scene_load() -> void:
	var loader: Error = ResourceLoader.load_threaded_request(scene_to_load)
	
	if loader == null:
		VibrantServer.log_error("An error occured when getting the scene")
		return
	
	get_tree().current_scene.queue_free()
	
	await get_tree().create_timer(0.5).timeout
	
	while ResourceLoader.load_threaded_get_status(scene_to_load, loading_progress) != ResourceLoader.THREAD_LOAD_LOADED:
		var loading_result: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(scene_to_load)
		if loading_result == ResourceLoader.THREAD_LOAD_FAILED:
			VibrantServer.log_error("Failed to load scene")
			return
	
	var loaded_scene: Node = ResourceLoader.load_threaded_get(scene_to_load).instantiate()
	
	get_tree().root.add_child(loaded_scene)
	get_tree().set_current_scene(loaded_scene)
	VibrantServer.can_load_scene = true
	_loading_end()

func _loading_completed() -> void:
	queue_free()
