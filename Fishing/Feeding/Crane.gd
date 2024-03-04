extends Node2D

enum State {MOVING, STILL_NORMAL, STILL_UP, STILL_DOWN}
var currentState = State.STILL_NORMAL

enum Position {NORMAL, UP, DOWN}
var prevPosition = Position.NORMAL
var nextPosition = Position.NORMAL
var queuedPosition = null
var carryingFishID = null

func start_feeding():
	crane_up()

func stop_feeding():
	crane_return()
	if prevPosition == Position.UP:
		cancel_selection()

func move():
	var oldState = currentState
	currentState = State.MOVING
	match prevPosition:
		Position.NORMAL:
			match nextPosition:
				Position.UP:
					$AnimationPlayer.play("Crane_Up")
					return
		Position.UP:
			match nextPosition:
				Position.NORMAL:
					$AnimationPlayer.play("Crane_Up_Return")
					return
				Position.DOWN:
					$AnimationPlayer.play("Crane_Down")
					return
		Position.DOWN:
			match nextPosition:
				Position.NORMAL:
					$AnimationPlayer.play("Crane_Down_Return")
					return
	
	# if we get here, then we failed
	currentState = oldState
	finish_move()

func crane_up():
	if currentState == State.STILL_NORMAL:
		nextPosition = Position.UP
		move()

func crane_down():
	if currentState == State.STILL_UP:
		nextPosition = Position.DOWN
		move()

func crane_return():
	if currentState == State.STILL_UP or currentState == State.STILL_DOWN:
		nextPosition = Position.NORMAL
		move()
	else:
		queuedPosition = Position.NORMAL

func ready_to_select():
	var main = get_node("/root/Main")
	main.start_fish_selection()

func cancel_selection():
	var main = get_node("/root/Main")
	main.cancel_fish_selection()

func ready_to_feed():
	var main = get_node("/root/Main")
	main.whale_fed(carryingFishID)
	set_fish("")

func take_fish():
	var main = get_node("/root/Main")
	return main.take_fish()

func set_fish(_fishID : String):
	carryingFishID = _fishID
	$FirstPivot/SecondPivot/ThirdPivot/Clamp/FishAttach.set_fish(_fishID)

func finish_move():
	match nextPosition:
		Position.UP:
			currentState = State.STILL_UP
			ready_to_select()
		Position.DOWN:
			currentState = State.STILL_DOWN
			ready_to_feed()
		Position.NORMAL:
			currentState = State.STILL_NORMAL
	prevPosition = nextPosition
	
	if queuedPosition != null and prevPosition != queuedPosition:
		nextPosition = queuedPosition
		queuedPosition = null
		move()

func _on_AnimationPlayer_animation_finished(_anim_name):
	if currentState == State.MOVING:
		finish_move()


func _on_CraneUP_pressed():
	crane_up()


func _on_CraneNORM_pressed():
	crane_return()


func _on_CraneDOWN_pressed():
	crane_down()

func _on_Feed_pressed():
	if currentState == State.STILL_UP:
		var fish = take_fish()
		if fish != null:
			set_fish(fish)
			crane_down()
	
