extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func launch_hook():
	var caught = $Cast.launch_hook()
	print("Caught %s!" % caught.color)

func _on_TestStart_pressed():
	$Cast.start_fishing()


func _on_Fish_pressed():
	launch_hook()
