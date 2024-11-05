@icon("res://addons/vibrant_loader/custom_nodes/loading_screen.svg")
class_name LoadingScreen
extends CanvasLayer


signal started_transition
signal finished_transition
signal completed_transition

var scene_to_load: String

var loading_progress: Array[float] = [0.0]
var is_scene_loaded: bool = false


func _ready() -> void:
	layer = VibrantLoader.loading_screen_layer
	
	# Do the scene loading
	var loader: Error = ResourceLoader.load_threaded_request(scene_to_load, "", true)
	print("Starting loading!")
	
	if loader == null:
		VibrantLoader.log_error("An error occured when getting the scene")
		return
	
	scene_load()

func scene_load() -> void:
	while ResourceLoader.load_threaded_get_status(scene_to_load, loading_progress) != ResourceLoader.THREAD_LOAD_LOADED:
		var loading_result: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(scene_to_load)
		if loading_result == ResourceLoader.THREAD_LOAD_FAILED:
			VibrantLoader.log_error("Failed to load scene")
			return
	is_scene_loaded = true

func start_transition_completed() -> void:
	get_tree().current_scene.queue_free()
	await is_scene_loaded
	
	var loaded_scene: Node = ResourceLoader.load_threaded_get(scene_to_load).instantiate()
	
	get_tree().root.add_child(loaded_scene)
	get_tree().set_current_scene(loaded_scene)
	VibrantLoader.can_load_scene = true
	_loading_end()

func end_transition_completed() -> void:
	completed_transition.emit()
	queue_free()

func _loading_start() -> void:
	started_transition.emit()

func _loading_end() -> void:
	finished_transition.emit()
