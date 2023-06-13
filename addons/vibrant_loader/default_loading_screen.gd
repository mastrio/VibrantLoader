extends LoadingScreen

@onready var background_a_nimatior: AnimationPlayer = $Background/BackgroundANimatior


func _loading_start() -> void:
	background_a_nimatior.play("BackgroundFade")

func _loading_end() -> void:
	background_a_nimatior.play("BackgroundFadeOut")

func _on_background_a_nimatior_animation_finished(anim_name: StringName) -> void:
	if anim_name == "BackgroundFade":
		_scene_load()
	elif anim_name == "BackgroundFadeOut":
		_loading_completed()
