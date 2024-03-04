extends Node2D

export var fish = {
	"Red": null,
	"Green": null,
	"Blue": null,
	"Purple": null,
	"Gold": null,
}

func set_fish(_fishID : String):
	for fishChild in get_children():
		fishChild.queue_free()
	if fish.has(_fishID):
		var fishScene = fish[_fishID]
		var fishInstance = fishScene.instance()
		add_child(fishInstance)
