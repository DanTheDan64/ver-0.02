extends Panel
var carrots = 0
var carrot_req = randi_range(4, 12)
var carrots_left = carrot_req - carrots
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalPanel.carrots_left = GlobalPanel.carrot_req - GlobalPanel.carrots
	GlobalPanel.carrots_left = clamp(GlobalPanel.carrots_left, 0, 1000)
	if get_node_or_null("required_food"):
		$required_food.text = "carrots required: " + str(GlobalPanel.carrots_left)
		$food_collected.text = "carrots: " + str(GlobalPanel.carrots)

