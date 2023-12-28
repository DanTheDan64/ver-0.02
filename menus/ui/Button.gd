extends Button
var scl = 1
var can_scl = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_scl == 1 and scl < 1.1:
		scl = scl + 0.01
	if can_scl == 0 and scl > 1:
		scl = scl - 0.01
	
	scale.x = scl
	scale.y = scl



func _on_mouse_entered():
	can_scl = 1

func _on_mouse_exited():
	can_scl = 0

