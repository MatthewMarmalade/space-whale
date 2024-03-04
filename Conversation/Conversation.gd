extends Node2D

export var conversations : Script
export var barks : Script

var player = null
var radio = null

var conversationMap = {}
var currentConversation = null
var conversationQueue = []
var playerBox = false

var awaitingStart = false

func set_player(_player):
	player = _player

func set_radio(_radio):
	radio = _radio

func conversation_queued():
	return currentConversation != null

# Called when the node enters the scene tree for the first time.
func _ready():
	parse_maps()
	hide_boxes()
	pass # Replace with function body.

func parse_maps():
	var conversationScript = conversations.new()
	for conversationID in conversationScript.convos:
		conversationMap[conversationID] = conversationScript.convos[conversationID]
	
	var barkScript = barks.new()
	for barkID in barkScript.convos:
		conversationMap[barkID] = barkScript.convos[barkID]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if currentConversation != null:
		track_player()
		track_radio()
	else:
		if !conversationQueue.empty():
			var nextConversation = conversationQueue.pop_front()
			start_conversation(nextConversation)

func track_player():
	if player:
		var textPosition = player.get_player_position()
		$PlayerBox.position = textPosition

func track_radio():
	if radio:
		var textPosition = radio.get_text_box_position()
		$RadioBox.position = textPosition

func force_conversation(_identifier : String, _endCurrent : bool = false):
	if currentConversation == null or _endCurrent:
		if _endCurrent:
			end_conversation()
		if conversationMap.has(_identifier):
			start_conversation(conversationMap[_identifier], false)
		else:
			print("Invalid conversation identifier: %s" % _identifier)
			print("Valid identifiers:")
			for identifier in conversationMap:
				print("- %s" % identifier)

func queue_conversation(_identifier : String):
	if conversationMap.has(_identifier):
		conversationQueue.append(conversationMap[_identifier])
	else:
		print("Invalid conversation identifier: %s" % _identifier)
		print("Valid identifiers:")
		for identifier in conversationMap:
			print("- %s" % identifier)

func start_conversation(_conversation : Array, _awaitRadio : bool = true):
	currentConversation = _conversation
	if _awaitRadio:
		awaitingStart = true
		set_radio_receiving(true)
	else:
		advance_conversation()

func end_conversation():
	if currentConversation != null:
		hide_boxes()
		set_radio_speaking(false)
		currentConversation = null

func hide_boxes():
	$PlayerBox.set_hidden()
	$RadioBox.set_hidden()

func advance_conversation():
	if currentConversation != null:
		if awaitingStart:
			awaitingStart = false
			set_radio_receiving(false)
		
		set_radio_speaking(true)
		
		var hasStatement = false
		while !hasStatement and !currentConversation.empty():
			var statement = currentConversation.pop_front() as String
			if statement.begins_with("> "):
				handle_name(statement)
			elif statement.begins_with("#"):
				handle_comment(statement)
			else:
				handle_line(statement)
				hasStatement = true
		
		if !hasStatement and currentConversation.empty():
			end_conversation()

func radio_pressed():
	advance_conversation()

func set_radio_receiving(_on : bool):
	var main = get_node("/root/Main")
	main.set_radio_receiving(_on)

func set_radio_speaking(_on : bool):
	var main = get_node("/root/Main")
	main.set_radio_speaking(_on)

func handle_name(_statement : String):
	var extractedName = _statement.trim_prefix("> ")
	playerBox = extractedName.to_lower() == "hush" or extractedName.to_lower() == "??"
	if playerBox:
		#$PlayerBox.set_name(extractedName)
		$RadioBox.set_hidden()
	else:
		$RadioBox.set_conversation_name(extractedName)
		$PlayerBox.set_hidden()

func handle_comment(_statement : String):
	var extractedComment = _statement.trim_prefix("#")
	var extractedID = extractedComment.split(" ")[0]
	print("Extracted id: %s from '%s'" % [extractedID, extractedComment])

func handle_line(_statement : String):
	if playerBox:
		$PlayerBox.set_text(_statement)
		$RadioBox.set_hidden()
	else:
		$RadioBox.set_text(_statement)
		$PlayerBox.set_hidden()

# ROLES:
# X keep player box tracked to player
# - Load conversation files on request
# - Tell the radio box when to display its readiness
# - Respond to radio clicks and try to advance the current conversation state
# - Tidy up when a conversation is finished
