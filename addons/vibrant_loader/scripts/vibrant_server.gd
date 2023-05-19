extends Node


var default_loading_screen: PackedScene = preload("res://addons/vibrant_loader/default_loading_screen.tscn")

var load_buffer: Array[SceneBuffer] = [] : set = set_load_buffer, get = get_load_buffer

var can_load_scene = true


func log_output(message: String) -> void:
	print("[VibrantLoader:Log] " + message)

func log_error(message: String) -> void:
	printerr("[VibrantLoader:Error] " + message)

func _physics_process(_delta: float) -> void:
	if load_buffer.size() > 0 and can_load_scene:
		load_scene(load_buffer[0].get_scene_name(), load_buffer[0].get_loading_screen(), false)
		load_buffer.pop_front()

func load_scene(scene_to_load: String, loading_screen: PackedScene = default_loading_screen, can_buffer: bool = true) -> void:
	if can_load_scene:
		can_load_scene = false
		var load_screen: LoadingScreen = loading_screen.instantiate()
		load_screen.scene_to_load = scene_to_load
		get_tree().root.add_child(load_screen)
		await get_tree().create_timer(1)
		load_screen._loading_start()
	else:
		if can_buffer:
			log_output("Another scene is currently loading, adding load request to load buffer")
			var scene_buffer: SceneBuffer = SceneBuffer.new().set_scene_name(scene_to_load).set_loading_screen(loading_screen)
			load_buffer.append(scene_buffer)
		else:
			log_output("Failed to load scene, another scene is currently loading")

func set_load_buffer(new_load_buffer: Array[SceneBuffer]) -> void:
	load_buffer = new_load_buffer

func get_load_buffer() -> Array[SceneBuffer]:
	return load_buffer
