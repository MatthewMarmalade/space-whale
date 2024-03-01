extends Node2D

var perturbationProp = 0.25
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spread = []
var rarities = {R = 2.5, G = 2.0, B = 2.25, P = 4.0, Y = 4.5, J = 3.0}

# spreads out its children
# returns their positions and types

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

func get_spread():
	return spread

func spread_fish(_min : float, _max : float):
	spread = []
	var children = get_children().duplicate()
	children.shuffle()
	var childrenCount = children.size()
	var spacing = (1.0 / (float(childrenCount) + 1.0)) * (_max - _min)
	var perturbation = spacing * perturbationProp
	
	var i = 1.0
	for child in children:
		var childY = (i * spacing + random_perturbation(perturbation))
		child.position.y = _min + childY
		spread.append({y = childY, color = child.name[0], rarity = rarities[child.name[0]]})
		i += 1.0
	
	#spread.append({y = 0.0, color = "J", rarity = rarities["J"]})
	#spread.append({y = _max - _min, color = "J", rarity = rarities["J"]})

func random_perturbation(_perturbation : float):
	# returns a value in the range (-_perturbation, _perturbation)
	return -_perturbation + (randf() * _perturbation * 2.0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
