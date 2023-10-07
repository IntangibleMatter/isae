@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("Isae", "res://addons/isae/isae_manager.gd")
	if not DirAccess.dir_exists_absolute("res://addons/isae/busparams"):
		DirAccess.make_dir_absolute("res://addons/isae/busparams")
		if not FileAccess.file_exists("res://addons/isae/busparams/demoparam.tres"):
			ResourceSaver.save(IsaeBusParam.new(), "res://addons/isae/busparams/demoparam.tres")
	


func _exit_tree() -> void:
	remove_autoload_singleton("Isae")
