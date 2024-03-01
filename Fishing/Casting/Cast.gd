extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fishes = []
var hookRangeMin = 100.0
var hookRangeMax = 500.0
var hookDistance = hookRangeMax - hookRangeMin

var hookRange = hookDistance / 10.0

var hookClockwise = false
var hookActive = false
var hookAmplitude = 8.0
var hookProgress = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func launch_hook():
	if !fishes.empty():
		return fishes[0]
	else:
		return "Nothing"

func start_fishing():
	$Fishes.spread_fish(hookRangeMin, hookRangeMax)
	fishes = $Fishes.get_spread()
	hookActive = true

func sort_fish(_fishA, _fishB):
	if _fishA.distance < _fishB.distance:
		return true
	return false

func get_target_distances(_hookY : float):
	for fish in fishes:
		var distance = abs(fish.y - _hookY)
		fish.distance = distance
	fishes.sort_custom(self, "sort_fish")

func render_target_distances():
	var weights = {"R": 0.0, "B": 0.0, "G": 0.0, "P": 0.0, "Y": 0.0, "J": 0.0}
	
	for fish in fishes:
		var effectiveRange = hookDistance / 3.0#fish.rarity
		if fish.distance < effectiveRange:
			var scaledDistance = fish.distance / effectiveRange
			var invScaledDistance = 1.0 - scaledDistance
			weights[fish.color] = max(invScaledDistance, weights[fish.color])
	
	if !fishes.empty():
		var closestFish = fishes[0]
		$Display.render_closest(closestFish.color)
	else:
		$Display.render_closest("")
	#var totalWeight = 0.0
	#for weightName in weights:
	#	totalWeight += weights[weightName]
	
	#for weightName in weights:
	#	weights[weightName] = (weights[weightName] + (weights[weightName] / totalWeight)) / 2.0
	#for weightName in weights:
	#	weights[weightName] /= totalWeight
	#print("R: %.2f, B: %.2f" % [weights.R, weights.B])
	$Display.render_display(weights)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !hookActive:
		return
	
	if hookClockwise:
		hookProgress += delta
		if hookProgress >= hookAmplitude:
			hookProgress = hookAmplitude
			hookClockwise = false
	else:
		hookProgress -= delta
		if hookProgress <= 0.0:
			hookProgress = 0.0
			hookClockwise = true
	
	var hookY = ((hookProgress / hookAmplitude) * hookDistance)
	$HookTarget.position.y = hookRangeMin + hookY
	
	get_target_distances(hookY)
	render_target_distances()
