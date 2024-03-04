extends Path2D

var playerSpeed = 200.0
var inStation = false
var inCrane = false
var inHarpoon = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_player_position():
	return $PlayerFollow.global_position

func get_radio_box_position():
	return $PlayerFollow/Camera/Radio.global_position

func go_left(_delta : float):
	$PlayerFollow.offset -= playerSpeed * _delta
	$PlayerFollow/PlayerObject/Flipper.scale.x = -1

func go_right(_delta : float):
	$PlayerFollow.offset += playerSpeed * _delta
	$PlayerFollow/PlayerObject/Flipper.scale.x = 1

func at_crane():
	return inCrane or $PlayerFollow.unit_offset < 0.01

func at_harpoon():
	return inHarpoon or $PlayerFollow.unit_offset > 0.99

func enter_crane():
	$PlayerFollow.unit_offset = 0.0
	inCrane = true
	var main = get_node("/root/Main")
	main.start_feeding()

func exit_crane():
	inCrane = false
	var main = get_node("/root/Main")
	main.stop_feeding()

func enter_harpoon():
	$PlayerFollow.unit_offset = 1.0
	inHarpoon = true
	var main = get_node("/root/Main")
	main.start_fishing()

func exit_harpoon():
	inHarpoon = false
	var main = get_node("/root/Main")
	main.stop_fishing()

func enter_station():
	if at_crane():
		enter_crane()
		inStation = true
	elif at_harpoon():
		enter_harpoon()
		inStation = true
	else:
		pass

func exit_station():
	if inStation:
		if at_crane():
			exit_crane()
		elif at_harpoon():
			exit_harpoon()
	inStation = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	if inStation:
		if Input.is_action_pressed("exit_station"):
			exit_station()
	else:
		var velocity = 0.0
		if Input.is_action_pressed("go_left"):
			velocity -= 1.0
		elif Input.is_action_pressed("go_right"):
			velocity += 1.0
		
		if velocity < 0.0:
			go_left(delta)
		elif velocity > 0.0:
			go_right(delta)
		
		if Input.is_action_pressed("enter_station"):
			enter_station()
