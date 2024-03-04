extends Spatial


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_released("switch_color"):
		for child in get_children():
			if child.visible and randi() % 4 != 0:
				var color = Color((randf() * 0.5) + 0.5, (randf() * 0.5) + 0.5, (randf() * 0.5) + 0.5)
				child.modulate = color
			else:
				child.modulate = Color.white
