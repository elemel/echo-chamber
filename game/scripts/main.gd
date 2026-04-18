extends Node3D

@export var echo_material: ShaderMaterial


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	echo_material.set_shader_parameter("debug", 0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
