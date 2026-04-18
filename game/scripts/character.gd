extends CharacterBody3D


@export var move_speed := 5.0
@export var move_acceleration := 20.0
@export var jump_speed := 5.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	if is_on_floor():
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		var target_ground_velocity := Vector2(direction.x, direction.z) * move_speed
		var ground_velocity := Vector2(velocity.x, velocity.z)
		ground_velocity = ground_velocity.move_toward(target_ground_velocity, move_acceleration * delta)

		velocity.x = ground_velocity.x
		velocity.z = ground_velocity.y

	move_and_slide()
