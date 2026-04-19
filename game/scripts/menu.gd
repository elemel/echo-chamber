extends CanvasLayer
class_name PauseMenu

@export var main: Main
@export var compass_layer: CanvasLayer

@export var title_label: Label

@export var start_button: Button
@export var compass_button: Button
@export var invert_mouse_button: Button
@export var quit_button: Button

var compass_enabled := true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause()


func _process(_delta: float) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and not get_tree().paused:
		pause()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			if main.level != null:
				unpause()
		else:
			pause()


func update() -> void:
	if main.level == null:
		title_label.text = "Echo Chamber"
		start_button.visible = true
		quit_button.visible = false
	else:
		title_label.text = "Paused"
		start_button.visible = false
		quit_button.visible = true

	if compass_enabled:
		compass_button.text = "Compass: On"
	else:
		compass_button.text = "Compass: Off"

	if main.invert_mouse:
		invert_mouse_button.text = "Invert Mouse: On"
	else:
		invert_mouse_button.text = "Invert Mouse: Off"


func toggle_pause() -> void:
	if get_tree().paused:
		unpause()
	else:
		pause()


func pause() -> void:
	if not get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
		visible = true
		compass_layer.visible = false


func unpause() -> void:
	if get_tree().paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_tree().paused = false
		visible = false
		compass_layer.visible = compass_enabled


func _on_start_pressed() -> void:
	main.start_level("level_b")
	unpause()
	update()


func _on_compass_pressed() -> void:
	compass_enabled = not compass_enabled
	update()


func _on_invert_mouse_pressed() -> void:
	main.invert_mouse = not main.invert_mouse
	update()


func _on_quit_pressed() -> void:
	main.quit_level()
	update()
