extends Node2D


func _ready():
	pass

func new_sky():
	if has_node("First"):
		$First.queue_free()
	else:
		var bgs = get_children()
		for bg in bgs:
			bg.visible = false
		var chosenBG = bgs[randi() % bgs.size()]
		chosenBG.visible = true
