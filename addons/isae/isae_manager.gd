extends Node

var params: Dictionary

func _ready() -> void:
	_load_parameters()

func _load_parameters() -> void:
	for file in DirAccess.get_files_at("res://addons/isae/busparams"):
		var b : Resource = load("res://addons/isae/busparams/" + file)
		if b.is_class("IsaeBusParam"):
			params[b.name] = b

