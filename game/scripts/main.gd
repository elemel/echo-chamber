extends Node3D
class_name Main

@export var echo_material: ShaderMaterial

var _ping_times: PackedFloat32Array;
var _ping_positions: PackedVector3Array
var _ping_index := 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ping_times.resize(16)
	_ping_positions.resize(16)

	_ping_times.fill(-1000.0)

	echo_material.set_shader_parameter("debug", 0.0)
	update_material()


func add_ping(ping_position) -> void:
	_ping_times[_ping_index] = Time.get_ticks_msec() * 0.001
	_ping_positions[_ping_index] = ping_position

	_ping_index += 1
	_ping_index %= 16

	update_material()


func update_material() -> void:
	echo_material.set_shader_parameter("ping_times", _ping_times)
	echo_material.set_shader_parameter("ping_positions", _ping_positions)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
