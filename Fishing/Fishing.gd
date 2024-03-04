extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum State {NONE, CASTING, HOOKING, REELING, WAITINGSTART, WAITING}
var state = State.NONE
var nextState = State.NONE

var targetFish = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Crane.set_fish("")
	$Display.render_closest("")

func start_fishing():
	set_deferred_state(State.CASTING)

func stop_fishing():
	set_deferred_state(State.NONE)

func state_change(_nextState):
	match state:
		_: pass
	
	match _nextState:
		State.CASTING:
			$Cast.start_fishing()
		State.HOOKING:
			$Crane.reset_hook()
		State.REELING:
			$Crane.start_reel()
			$Crane.set_fish(targetFish)
		State.NONE:
			$Crane.reset_hook()
	
	if _nextState != State.REELING:
		$Crane.set_fish("")
	if _nextState != State.REELING and _nextState != State.HOOKING:
		$Display.render_closest("")
	
	state = nextState

func set_deferred_state(_state):
	nextState = _state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state != nextState:
		state_change(nextState)
	
	match state:
		State.NONE: return
		State.CASTING:
			$Cast.cast_advance(delta)
			
			var foundWeights = $Cast.get_weights()
			$Display.render_display(foundWeights)
			
			#var displayTargetFish = $Cast.get_target_fish()
			#if displayTargetFish != null:
			#	$Display.render_closest(displayTargetFish.color)
			#else:
			#	$Display.render_closest("")
			
			var targetLocation = $Cast.get_target_position()
			$Crane.crane_target(targetLocation)
		State.HOOKING:
			var finished = $Crane.advance_hook(delta)
			if finished:
				set_deferred_state(State.REELING)
		State.REELING:
			var distance = $Crane.advance_reel(delta)
			if distance < 0.0:
				distance = 0.0
				set_deferred_state(State.WAITINGSTART)
			
			$Reel/Distance.text = "%.0fm" % distance
		State.WAITINGSTART:
			var main = get_node("/root/Main")
			set_deferred_state(State.WAITING)
			main.caught_fish(targetFish)
		State.WAITING:
			pass # reliant on main to send us an event here

func finished_waiting(_exit : bool = false):
	if _exit:
		set_deferred_state(State.NONE)
	else:
		set_deferred_state(State.CASTING)

func launch_hook():
	if state == State.CASTING:
		targetFish = $Cast.get_target_fish()
		if targetFish != null:
			$Display.render_closest(targetFish)
			set_deferred_state(State.HOOKING)
		else:
			$Display.render_closest("")
	#var caught = $Cast.launch_hook()
	#print("Caught %s!" % caught.color)

func reel_hook():
	if state == State.REELING:
		$Crane.hit_reel()

func _on_TestStart_pressed():
	set_deferred_state(State.CASTING)

func _on_Fish_pressed():
	launch_hook()

func _on_Reel_pressed():
	reel_hook()
