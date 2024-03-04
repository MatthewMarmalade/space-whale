extends Node2D

export var fish = {}


var baseLineLength = 256.0
var maxLength = 1600.0

var lineProgress = 0.0
var lineDuration = 2.0

var distance = 0.0
var farDistance = 1000.0
var distancePerHit = 400.0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_reel():
	distance = farDistance
	$Reel.start_reel()

func stop_reel():
	$Reel.stop_reel()

func hit_reel():
	var successProp = $Reel.hit_reel()
	distance -= distancePerHit * successProp

func advance_reel(_delta : float):
	if distance > 0.0:
		$Reel.advance_reel(_delta)
		return distance
	else:
		lineProgress -= _delta
		if lineProgress <= 0.0:
			lineProgress = 0.0
			return -1.0
		else:
			var lineProp = lineProgress / lineDuration
			set_hook_offset_length(maxLength * lineProp)
			return 0.0

func crane_target(_position : Vector2):
	$Hook/Rotater.look_at(_position)

func reset_hook():
	lineProgress = 0.0

func set_fish(_fishID : String):
	$Hook/Rotater/HookBase/Hook/FishAttach.set_fish(_fishID)


func set_hook_offset_length(_length : float):
	$Hook/Rotater/HookBase/Hook.position.x = _length
	var targetScale = _length / baseLineLength
	$Hook/Rotater/HookBase/Line.scale.y = targetScale
	$Hook/Rotater/HookBase/Line.position.x = _length / 2.0

func advance_hook(_delta : float):
	lineProgress += _delta
	
	if lineProgress >= lineDuration:
		lineProgress = lineDuration
		return true
	
	var lineProp = lineProgress / lineDuration
	set_hook_offset_length(maxLength * lineProp)
	
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
