extends Node2D

var maxAngle = PI * 2.0
var minAngle = 0.0
var angleRange = maxAngle - minAngle
var randomRangeMin = (PI / 9.0)
var randomRange = (angleRange / 2.0) - randomRangeMin

var reeling = false
var winchLevelProgress = 0.0
var winchLevelInterval = 1.0
var winchLevel = Vector2(-18.0, -5.0)

var responseLevels = Vector2(-40.0, -5.0)

var targetAngle = 0.0
var currentAngle = 0.0
var otherAngle = 0.0
var rotationPeriod = 2.0
var rotationSpeed = angleRange / rotationPeriod

var forgiveness = PI * (1.0 / 6.0)
var maxFailure = (angleRange / 2.0) - forgiveness
var failureScale = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_random_angle():
	var offset = (randf() * randomRange) + randomRangeMin
	var newAngle = currentAngle - offset
	if newAngle < 0.0:
		newAngle += maxAngle
	return newAngle
	#return (randf() * angleRange) + minAngle

func set_target():
	targetAngle = get_random_angle()
	$Target.rotation = targetAngle

func set_levels():
	$Winching.volume_db = lerp(winchLevel.x, winchLevel.y, winchLevelProgress / winchLevelInterval)

func start_reel():
	reeling = true
	$Winching.play()
	winchLevelProgress = 0.0
	set_levels()
	currentAngle = 0.0
	set_target()

func stop_reel():
	reeling = false
	$Winching.stop()

func play_success(_success : float):
	var successOffset = 0.1
	var failureOffset = 0.1
	if _success == 1.0:
		$Winch_Success.volume_db = responseLevels.y
		$Winch_Success.play(successOffset)
	#elif _success > 0.0:
	#	$Winch_Success.volume_db = lerp(responseLevels.x, responseLevels.y, _success)
	#	$Winch_Failure.volume_db = lerp(responseLevels.y, responseLevels.x, _success)
	#	$Winch_Success.play(successOffset)
	#	$Winch_Failure.play(failureOffset)
	else:
		$Winch_Failure.volume_db = responseLevels.y
		$Winch_Failure.play(failureOffset)

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
	
	if success > 0.0:
		winchLevelProgress = winchLevelInterval
		set_levels()
	
	play_success(success)
	#print("Reeling in: %.2f >< %.2f, distance of %.2f (%.2f), success: %.2f" % [rad2deg(currentAngle), rad2deg(targetAngle), rad2deg(distance), rad2deg(forgivenDistance), success])
	
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
	
	if winchLevelProgress > 0.0:
		winchLevelProgress -= _delta
		if winchLevelProgress <= 0.0:
			winchLevelProgress = 0.0
		set_levels()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
