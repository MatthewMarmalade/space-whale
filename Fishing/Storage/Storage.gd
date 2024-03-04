extends Node2D

export var stackItem : PackedScene
export var stackType : String
export var stackLimit : int = 10

var amount : int = 0
var stackOffset : float = 10.0

var stackedItems = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Type.text = "%s" % stackType
	clear_stack()
	render_amount(0)

func clear_stack():
	stackedItems = []
	for child in $Stack.get_children():
		child.queue_free()

func increase_stack():
	if stackedItems.size() < stackLimit:
		var newItem = stackItem.instance()
		newItem.position.y = -stackOffset * stackedItems.size()
		$Stack.add_child(newItem)
		stackedItems.append(newItem)

func decrease_stack():
	if !stackedItems.empty():
		var lastItem = stackedItems.pop_back()
		lastItem.queue_free()

func render_amount(_newAmount):
	$Count.text = "%d" % _newAmount
	
	if _newAmount > amount:
		for _i in range(_newAmount - amount):
			increase_stack()
	elif _newAmount < amount:
		for _i in range(amount - _newAmount):
			decrease_stack()

func update_amount(_delta : int):
	var newAmount = amount + _delta
	if newAmount < 0:
		newAmount = 0
	if newAmount > stackLimit:
		newAmount = stackLimit
	render_amount(newAmount)
	amount = newAmount

func get_amount() -> int:
	return amount
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
