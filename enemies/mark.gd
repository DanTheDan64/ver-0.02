extends Marker3D

var spawn = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawn > 0:
		var node = preload("res://enemies/carrot.tscn")
		var instance = node.instantiate()
		instance.position = Vector3(global_position.x + randi_range(-5, 5), global_position.y, global_position.z + randi_range(-5, 5))
		get_parent().get_parent().get_parent().add_child(instance)
		spawn -= 1
