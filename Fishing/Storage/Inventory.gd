extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_storage_of_type(_type : String):
	for child in $Storages.get_children():
		if child.stackType == _type:
			return child

func update_amount(_type : String, _delta : int):
	var storage = get_storage_of_type(_type)
	storage.update_amount(_delta)

func get_amount(_type : String):
	var storage = get_storage_of_type(_type)
	return storage.get_amount()

func take_random_fish():
	var availableFish = []
	for child in $Storages.get_children():
		if child.get_amount() > 0:
			availableFish.append(child.stackType)
	
	if !availableFish.empty():
		var chosenFish = availableFish[randi() % availableFish.size()]
		update_amount(chosenFish, -1)
		return chosenFish
	return null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
