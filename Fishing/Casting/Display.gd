extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var maxBarHeight = 100.0
var baseBarPixels = 40.0
var maxBarScale = maxBarHeight / baseBarPixels

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func render_closest(_color):
	$Selection.visible = _color != ""
	match _color:
		"Red": $Selection.position = $Red.position
		"Green": $Selection.position = $Green.position
		"Blue": $Selection.position = $Blue.position
		"Purple": $Selection.position = $Purple.position
		"Gold": $Selection.position = $Gold.position

func scale_weights(_value : float):
	assert(_value <= 1.0 and _value >= 0.0)
	if _value <= 0.5:
		return 2.0 * pow(_value, 2.0)
	else:
		return (-2.0 * pow((_value - 1.0), 2.0)) + 1.0

func set_bar_scale(_node : Node2D, _value : float):
	var value = _value#scale_weights(_value)
	var barScale = value * maxBarScale
	var bar = _node.get_node("Bar")
	bar.scale.y = barScale
	var halfPoint = baseBarPixels * 0.5 * barScale
	bar.position.y = -halfPoint

func render_display(_weights):
	for weightName in _weights:
		var weight = _weights[weightName]
		if weightName == "Red":
			set_bar_scale($Red, weight)
		elif weightName == "Blue":
			set_bar_scale($Blue, weight)
		elif weightName == "Green":
			set_bar_scale($Green, weight)
		elif weightName == "Purple":
			set_bar_scale($Purple, weight)
		elif weightName == "Gold":
			set_bar_scale($Gold, weight)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
