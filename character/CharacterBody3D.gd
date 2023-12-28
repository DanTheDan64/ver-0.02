extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 4.5

var max_jumps = 2
var jumps = max_jumps
var jump_length = 0.3
var jump_time = 0
var jumping = false

var dashing = false
var dash_length = 10
var dash_timer = dash_length


@export var sens = 0.3


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 15

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y += -event.relative.x * sens

func _physics_process(delta):
	
	if Input.is_action_just_pressed("shoot"):
		var node = preload("res://guns/nodes/bullet.tscn")
		var instance = node.instantiate()
		instance.position = $Camera3D/gun.global_position
		instance.position += -global_transform.basis.z * 3 * delta 
		instance.rotation = $Camera3D/gun.global_rotation
		
		get_parent().add_child(instance)
	
	if is_on_floor():
		jumps = max_jumps
	else:
		if jumps == max_jumps:
			jumps = max_jumps - 1
		velocity.y -= gravity * delta
	
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and jumping == false and jumps > 0:
		jumping = true
		jump_time = jump_length
		jumps -= 1
	
	if Input.is_action_just_released("jump"):
		jumping = false
		jump_time = jump_length
	
	if jump_time > 0 and jumping == true:
		velocity.y = JUMP_VELOCITY
		jump_time -= 1 * delta
	
	if jump_time <= 0:
		jumping = false
		jump_time = jump_length
	
	
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


