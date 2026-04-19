extends Area3D
class_name Goal

@export var next_level_name: String
@export var message := "Level Complete"


func _on_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		var main := get_tree().get_first_node_in_group("mains") as Main

		if next_level_name:
			main.start_level(next_level_name)
		else:
			main.quit_level()

		main.menu.message = message
		main.menu.pause()
