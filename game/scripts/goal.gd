extends Area3D
class_name Goal

@export var next_level_name: String

func _on_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		var main := get_tree().get_first_node_in_group("mains") as Main
		main.start_level(next_level_name)
