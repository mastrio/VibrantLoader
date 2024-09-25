extends LoadingScreen


var target_load_progress: float


func _process(delta: float) -> void:
	target_load_progress = loading_progress[0]
	%LoadingProgress.value = lerp(%LoadingProgress.value, target_load_progress, 6.0 * delta)

func _loading_start() -> void:
	%BackgroundAnimatior.play("BackgroundFade")

func _loading_end() -> void:
	%BackgroundAnimatior.play("BackgroundFadeOut")

func _on_background_animation_finished(anim_name: StringName) -> void:
	if anim_name == "BackgroundFade":
		scene_load()
	elif anim_name == "BackgroundFadeOut":
		loading_completed()
