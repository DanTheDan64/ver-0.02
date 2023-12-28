extends Area3D
var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# the forward vector
	var forward = -global_transform.basis.z
	# you need some speed variable, indicating the bullet speed
	global_position += forward * speed * delta 



func _on_area_entered(area):
	queue_free()
