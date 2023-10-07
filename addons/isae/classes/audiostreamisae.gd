class_name AudioStreamIsae
extends Resource

@export var streams : Array[Track]

@export var params : Array[IsaeParameter]
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
	

