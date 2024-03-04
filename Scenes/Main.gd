extends Node2D

var narrative = null
var player = null
var radio = null
var playerTracker = null
var inventory = null
var fishing = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var soundtrackDelay = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	narrative = $Narrative
	player = $Player
	radio = $PlayerTracker/Camera/Radio
	playerTracker = $PlayerTracker
	inventory = $Inventory
	fishing = $Fishing
	narrative.set_player(player)
	narrative.set_radio(radio)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	playerTracker.position = player.get_player_position()
	if soundtrackDelay >= 0.0:
		soundtrackDelay -= _delta
		if soundtrackDelay < 0.0:
			$Soundtrack.play()

func caught_fish(_fish):
	inventory.update_amount(_fish, 1)
	fishing.finished_waiting(false)

func radio_pressed():
	narrative.radio_pressed()

func set_radio_receiving(_on : bool):
	radio.set_radio_receiving(_on)

func set_radio_speaking(_on : bool):
	radio.set_radio_speaking(_on)

func start_fishing():
	$Fishing.start_fishing()

func stop_fishing():
	$Fishing.stop_fishing()

func start_feeding():
	$Ship/Rig/Crane.start_feeding()

func stop_feeding():
	$Ship/Rig/Crane.stop_feeding()

func start_fish_selection():
	pass
	# ignore - we just take something random at the moment.

func take_fish():
	return $Inventory.take_random_fish()

func cancel_fish_selection():
	pass

func whale_fed(_fish : String):
	$Ship/Rig/Crane.start_feeding()


func _on_Soundtrack_finished():
	soundtrackDelay = 60.0 + (randf() * 60.0)
