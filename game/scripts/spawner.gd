extends Node3D
class_name Spawner

@export var player_character_scene: PackedScene

var player_character: PlayerCharacter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if player_character == null or not player_character.is_inside_tree():
		player_character = player_character_scene.instantiate()
		get_parent().add_child(player_character)
		player_character.global_position = global_position
