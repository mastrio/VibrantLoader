extends LoadingScreen


const LERP_SPEED: float = 6.0

var target_load_progress: float


func _process(delta: float) -> void:
	target_load_progress = loading_progress[0]
	%LoadingProgress.value = lerp(%LoadingProgress.value, target_load_progress, LERP_SPEED * delta)

func _loading_start() -> void:
	%BackgroundAnimatior.play("BackgroundFade")

func _loading_end() -> void:
	%BackgroundAnimatior.play("BackgroundFadeOut")

func _on_background_animation_finished(anim_name: StringName) -> void:
	if anim_name == "BackgroundFade":
		start_transition_completed()
	elif anim_name == "BackgroundFadeOut":
		end_transition_completed()
