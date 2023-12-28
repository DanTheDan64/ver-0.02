extends CharacterBody3D


var speed = randf_range(1, 2)
var max_distance_to_pack = randf_range(6, 16)
var distance_to_pack = 0
var wait_time = randf_range(1, 4)
var hp = 2
var panic = false
var panic_amount = randf_range(2, 3.2)

#Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 200

func _ready():
	$Timer.start(wait_time)
	$main_mesh.rotation_degrees.x = clamp($main_mesh.rotation_degrees.x, -30, 30)
	rotation_degrees.y += randi_range(-360, 360)


func _process(delta):
	pass

func _physics_process(delta):
	
	
	#if too far from mark, point towards mark to go towards it
	if get_node_or_null("3"):
		distance_to_pack = position.distance_to(Vector3($"1/2/3".global_position.x, global_position.y, $"1/2/3".global_position.z))
		if distance_to_pack > max_distance_to_pack:
			look_at(Vector3($"1/2/3".global_position.x, global_position.y , $"1/2/3".global_position.z))
	
	
	
	#move forward
	velocity = -global_transform.basis.z * speed
	
	#death
	if hp <= 0:
		var node = preload("res://enemies/enemy drops/carrot_drop.tscn")
		var instance = node.instantiate()
		instance.position = position
		get_parent().add_child(instance)
		queue_free()
	
	#gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()


func _on_timer_timeout():
	#point to random dir + redundances to stop twitching
	if distance_to_pack < max_distance_to_pack - 1:
		rotation_degrees.y += randi_range(-360, 360)
	
	$Timer.stop()
	wait_time = randf_range(2, 4)
	$Timer.start(wait_time)


#damage
func _on_area_3d_area_entered(area):
	if area.is_in_group("bullets"):
		hp -= 1
		panic = true
		if $agro_timer.is_stopped():
			$agro_timer.start(2)
			look_at(-$"../CharacterBody3D".position)
			rotation.x = 0
			rotation_degrees.y += randi_range(-120, 120)
			speed *= 2
			max_distance_to_pack *= 2


func _on_agro_timer_timeout():
	panic = false
	speed /= 2
	max_distance_to_pack /= 2
	$agro_timer.stop()
