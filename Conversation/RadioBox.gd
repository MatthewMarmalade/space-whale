extends Node2D

var conversationText = ""
var conversationName = ""
var conversationProgress = 0.0
var conversationMaxCharacters = 0.0
var charactersPerSecond = 30.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_hidden():
	set_conversation("", "")
	visible = false

func set_complete():
	conversationProgress = conversationMaxCharacters
	render_progress()

func set_conversation(_text : String, _name = null):
	set_text(_text)
	if _name and _name is String:
		set_conversation_name(_name)

func set_text(_text : String):
	visible = true
	$Shifter/Text.text = "%s: %s" % [conversationName, _text]
	conversationText = _text
	conversationProgress = 0.0
	conversationMaxCharacters = float($Shifter/Text.text.length())
	render_progress()

func set_conversation_name(_name : String):
	#$Shifter/Name.text = _name
	conversationName = _name

func render_progress():
	$Shifter/Text.visible_characters = int(conversationProgress)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if conversationProgress <= conversationMaxCharacters:
		conversationProgress += delta * charactersPerSecond
		render_progress()
