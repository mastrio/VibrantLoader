@icon("res://addons/vibrant_loader/custom_nodes/loading_screen.svg")
class_name LoadingScreen
extends CanvasLayer


signal started_loading
signal finished_loading
signal completed_loading

var scene_to_load: String

var loading_progress: Array[float] = [0.0]


func _ready() -> void:
	layer = VibrantLoader.loading_screen_layer

func scene_load() -> void:
	var loader: Error = ResourceLoader.load_threaded_request(scene_to_load, "", true)
	
	if loader == null:
		VibrantLoader.log_error("An error occured when getting the scene")
		return
	
	get_tree().current_scene.queue_free()
	
	while ResourceLoader.load_threaded_get_status(scene_to_load, loading_progress) != ResourceLoader.THREAD_LOAD_LOADED:
		var loading_result: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(scene_to_load)
		if loading_result == ResourceLoader.THREAD_LOAD_FAILED:
			VibrantLoader.log_error("Failed to load scene")
			return
	
	var loaded_scene: Node = ResourceLoader.load_threaded_get(scene_to_load).instantiate()
	
	get_tree().root.add_child(loaded_scene)
	get_tree().set_current_scene(loaded_scene)
	VibrantLoader.can_load_scene = true
	_loading_end()

func loading_completed() -> void:
	completed_loading.emit()
	queue_free()

func _loading_start() -> void:
	started_loading.emit()

func _loading_end() -> void:
	finished_loading.emit()
