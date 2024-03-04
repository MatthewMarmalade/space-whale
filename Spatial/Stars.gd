extends Spatial


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_released("switch"):
		var stars = get_children()
		for star in stars:
			star.visible = false
		var chosenStar = stars[randi() % stars.size()]
		chosenStar.visible = true
