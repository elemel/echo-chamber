extends Node3D
class_name Main

@export var echo_material: ShaderMaterial
@export var levels: Node3D
@export var menu: GameMenu

var invert_mouse := false
var level: Level

var _time := 0.0

var _ping_times: PackedFloat32Array;
var _ping_origins: PackedVector3Array
var _ping_velocities: PackedVector3Array
var _ping_ranges: PackedFloat32Array
var _ping_colors: PackedColorArray
var _ping_index := 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ping_times.resize(16)
	_ping_origins.resize(16)
	_ping_velocities.resize(16)
	_ping_ranges.resize(16)
	_ping_colors.resize(16)

	_ping_times.fill(-1000.0)
	_ping_colors.fill(Color.BLACK)

	echo_material.set_shader_parameter("debug", 0.0)
	update_material()


func start_level(level_name: String) -> void:
	quit_level()

	var level_path := "res://scenes/levels/" + level_name + ".tscn"
	var level_scene := load(level_path) as PackedScene
	level = level_scene.instantiate()
	levels.add_child(level)


func quit_level() -> void:
	if level != null:
		level.queue_free()
		level = null

		clear_pings()


func clear_pings() -> void:
	_ping_times.fill(-1000.0)
	_ping_origins.fill(Vector3.ZERO)
	_ping_velocities.fill(Vector3.ZERO)
	_ping_ranges.fill(0.0)
	_ping_colors.fill(Color.BLACK)


func add_ping(origin: Vector3, velocity := Vector3.ZERO, ping_range := 10.0, color := Color.WHITE) -> void:
	_ping_times[_ping_index] = _time
	_ping_origins[_ping_index] = origin
	_ping_velocities[_ping_index] = velocity
	_ping_ranges[_ping_index] = ping_range
	_ping_colors[_ping_index] = color

	_ping_index += 1
	_ping_index %= 16

	update_material()


func update_material() -> void:
	echo_material.set_shader_parameter("ping_times", _ping_times)
	echo_material.set_shader_parameter("ping_origins", _ping_origins)
	echo_material.set_shader_parameter("ping_velocities", _ping_velocities)
	echo_material.set_shader_parameter("ping_ranges", _ping_ranges)
	echo_material.set_shader_parameter("ping_colors", _ping_colors)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_time += _delta
	echo_material.set_shader_parameter("time", _time)
