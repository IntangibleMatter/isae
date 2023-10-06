class_name AudioStreamIsae

@export var streams : Array[Track]

@export var params : Array[Parameter]
var param_names : Dictionary

func _ready() -> void:
	param_names = get_param_names()

func get_param_names() -> Dictionary:
	var names: Dictionary
	for p in params.size():
		names[params[p].title] = p
	return names

func get_param_by_name(nme: String) -> int:
	return param_names[nme]

class Track:
	extends Resource
	@export var stream : AudioStream
	@export var synced : bool = false
	

class Parameter:
	extends Resource
	@export var title: String
	@export var value: float
	@export var min_value : float = 0
	@export var max_value : float = 1
	@export var seek_speed : float = 0

