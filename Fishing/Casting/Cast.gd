extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var fishes = []
var weights = null
var hookRangeMin = 100.0
var hookRangeMax = 500.0
var hookDistance = hookRangeMax - hookRangeMin

var hookRange = hookDistance / 10.0

var hookClockwise = true
var hookActive = false
var hookAmplitude = 8.0
var hookProgress = hookAmplitude / 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_weights():
	return weights

func pick_random_fish():
	var pool = []
	var count = fishes.size()
	for fish in fishes:
		var effectiveRange = hookDistance / 3.0#fish.rarity
		if fish.distance < effectiveRange:
			for _i in range(count):
				pool.append(fish.color)
			count -= 1
	
	if !pool.empty():
		return pool[randi() % pool.size()]
	else:
		return null

func get_target_fish():
	if !fishes.empty():
		return pick_random_fish()
		#return fishes[0]
	return null

func get_target_position():
	return position + $HookTarget.position

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

func get_target_weights():
	weights = {}
	
	for fish in fishes:
		if !weights.has(fish.color):
			weights[fish.color] = 0.0
		var effectiveRange = hookDistance / 3.0#fish.rarity
		if fish.distance < effectiveRange:
			var scaledDistance = fish.distance / effectiveRange
			var invScaledDistance = 1.0 - scaledDistance
			weights[fish.color] = max(invScaledDistance, weights[fish.color])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func cast_advance(delta):
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
	get_target_weights()
