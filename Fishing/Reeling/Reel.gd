extends Node2D

var maxAngle = PI * 2.0
var minAngle = 0.0
var angleRange = maxAngle - minAngle
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var targetAngle = 0.0
var currentAngle = 0.0
var otherAngle = 0.0
var rotationPeriod = 2.0
var rotationSpeed = angleRange / rotationPeriod

var forgiveness = PI * (1.0 / 10.0)
var maxFailure = (angleRange / 2.0) - forgiveness
var failureScale = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_random_angle():
	return (randf() * angleRange) + minAngle

func set_target():
	targetAngle = get_random_angle()
	$Target.rotation = targetAngle

func start_reel():
	currentAngle = 0.0
	set_target()

func hit_reel():
	var distance = max(currentAngle, targetAngle) - min(currentAngle, targetAngle)
	if distance > PI / 2.0:
		distance = maxAngle - distance
	
	var forgivenDistance = distance - forgiveness
	var success = 0.0
	if forgivenDistance <= 0.0:
		success = 1.0
	else:
		success = (1.0 - (forgivenDistance / maxFailure)) * failureScale
	
	print("Reeling in: %.2f >< %.2f, distance of %.2f (%.2f), success: %.2f" % [rad2deg(currentAngle), rad2deg(targetAngle), rad2deg(distance), rad2deg(forgivenDistance), success])
	
	set_target()
	
	return success

func advance_reel(_delta : float):
	currentAngle += rotationSpeed * _delta
	if currentAngle >= maxAngle:
		currentAngle -= maxAngle
	
	$Wheel.rotation = currentAngle
	
	otherAngle += rotationSpeed * 1.25 * _delta
	if otherAngle >= maxAngle:
		otherAngle -= maxAngle
	$OtherWheel.rotation = otherAngle
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
