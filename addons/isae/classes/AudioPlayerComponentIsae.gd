class_name AudioPlayerComponentIsae
extends Node

@export var stream : AudioStreamIsae

# TODO: Move to audioplayer
func set_param(param: String, value: float) -> void:
	if stream.params[stream.get_param_by_name(param)].seek_speed == 0:
		stream.params[stream.get_param_by_name(param)].value = value
		return
	var tween : Tween = create_tween()
	tween.tween_property(
		stream.params[stream.get_param_by_name(param)],
		"value",
		clampf(value, stream.params[stream.get_param_by_name(param)].min_value, stream.params[stream.get_param_by_name(param)].max_value),
		stream.params[stream.get_param_by_name(param)].seek_speed / abs(value - stream.params[stream.get_param_by_name(param)].target_value)
		)


