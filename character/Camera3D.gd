extends Camera3D

@export var sens = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x += -event.relative.y * sens
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
