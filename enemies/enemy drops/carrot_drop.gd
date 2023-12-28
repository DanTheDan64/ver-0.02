extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		GlobalPanel.carrots += 1
		print("sdlikjn")
		queue_free()
