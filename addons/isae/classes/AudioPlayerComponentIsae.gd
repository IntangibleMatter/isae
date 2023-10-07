class_name AudioPlayerComponentIsae
extends Node

@export var stream : AudioStreamIsae

enum PLAYER_TYPE {NONSPATIAL, SPATIAL_2D, SPATIAL_3D}
var play_type : PLAYER_TYPE

var audio_data : Dictionary

var spatial_scatter_2d : Vector2
var spatial_scatter_3d : Vector3

var players : Array

func _ready() -> void:
	pass

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
		stream.params[stream.get_param_by_name(param)].seek_speed * abs(value - stream.params[stream.get_param_by_name(param)].target_value)
		)

func update() -> void:
	for player in players:
		if not is_instance_valid(player):
			players.remove_at(players.find(player))
			continue
		if player.playing:
			await player.finished

		player.volume_db = randf_range(audio_data.volume_db - audio_data.volume_rand, audio_data.volume_db + audio_data.volume_rand)
		player.pitch_scale = randf_range(audio_data.pitch_scale - audio_data.pitch_rand, audio_data.pitch_scale + audio_data.pitch_rand)
		match play_type:
			PLAYER_TYPE.SPATIAL_2D:
				if spatial_scatter_2d != Vector2.ZERO:
					player.position = Vector2(randf_range(-spatial_scatter_2d.x, spatial_scatter_2d.x), randf_range(-spatial_scatter_2d.y, spatial_scatter_2d.y))



func spawn_players(data: Dictionary) -> void:
	audio_data = data
	match data.type:
		"2D":
			spawn_players_2d(data)
			play_type = PLAYER_TYPE.SPATIAL_2D
		"3D":
			spawn_players_3d(data)
			play_type = PLAYER_TYPE.SPATIAL_3D
		_:
			spawn_players_nonspatial(data)
			play_type = PLAYER_TYPE.NONSPATIAL


func spawn_players_2d(data: Dictionary) -> void:
	var p : Array[AudioStreamPlayer2D]
	for track in stream.streams:
		p.append(player_2d(data, track))
	players = p

func player_2d(data: Dictionary, track: AudioStreamIsae.Track) -> AudioStreamPlayer2D:
	var p := AudioStreamPlayer2D.new()
	p.area_mask = data.area_mask
	p.attenuation = data.attenuation
	p.autoplay = data.autoplay
	p.bus = data.bus
	p.max_distance = data.max_distance
	p.max_polyphony = data.max_polyphony
	p.panning_strength = data.panning_strength
	p.pitch_scale = randf_range(data.pitch_scale - data.pitch_rand, data.pitch_scale + data.pitch_rand)
	p.playing = data.playing
	p.stream = track.stream
	p.stream_paused = data.stream_paused
	p.volume_db = randf_range(data.volume_db - data.volume_rand, data.volume_db + data.volume_rand)
	return p

func spawn_players_3d(data: Dictionary) -> void:
	pass


func spawn_players_nonspatial(data: Dictionary) -> void:
	pass

func player_nonspatial(data: Dictionary, track: AudioStreamIsae.Track) -> AudioStreamPlayer:
	var p := AudioStreamPlayer.new()
	p.autoplay = data.autoplay
	p.bus = data.bus
	p.max_polyphony = data.max_polyphony
	p.mix_target = data.mix_target
	p.pitch_scale = randf_range(data.pitch_scale - data.pitch_rand, data.pitch_scale + data.pitch_rand)
	p.playing = data.playing
	p.stream = track.stream
	p.stream_paused = data.stream_paused
	p.volume_db = randf_range(data.volume_db - data.volume_rand, data.volume_db + data.volume_rand)
	return p

