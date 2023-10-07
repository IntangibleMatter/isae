class_name IsaeBusParam
extends IsaeParameter
@export var bus_relations : Array[BusParamControl]

class BusParamControl:
	extends Resource
	
	@export var curve: Curve
	@export var bus: int
	@export var effect: int
	@export var param: String

	func _ready() -> void:
		if bus > AudioServer.bus_count - 1:
			bus = AudioServer.bus_count - 1
		if effect > AudioServer.get_bus_effect_count(bus) - 1:
			effect = AudioServer.get_bus_effect_count(bus) - 1
		if not AudioServer.get_bus_effect(bus, effect).has_meta(param):
			param = AudioServer.get_bus_effect(bus, effect).get_meta_list()[0]
