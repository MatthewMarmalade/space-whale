extends Node2D

export var barks : PoolStringArray = []
export var plotline : PoolStringArray = []

var firstConversation = true
var nextConversation = null
var waitDuration = 0.0

var fixedWaitDuration = 30.0

func conversation_queued():
	return $Conversation.conversation_queued()

func radio_pressed():
	if conversation_queued():
		$Conversation.radio_pressed()
	else:
		play_bark()

func play_bark():
	var barksArray = Array(barks)
	var barkOptions = barksArray.duplicate()
	
	# do any checks to limit what barks we can play
	# pick a bark at random
	if !barkOptions.empty():
		var chosenBarkID = barkOptions[randi() % barkOptions.size()]
		$Conversation.force_conversation(chosenBarkID)

func set_player(_player):
	$Conversation.set_player(_player)

func set_radio(_radio):
	$Conversation.set_radio(_radio)

func _process(delta):
	if nextConversation == null:
		if !plotline.empty():
			nextConversation = plotline[0]
			plotline.remove(0)
			if firstConversation:
				firstConversation = false
			else:
				waitDuration = fixedWaitDuration
	else:
		if !conversation_queued():
			if waitDuration >= 0.0:
				waitDuration -= delta
				if waitDuration <= 0.0:
					$Conversation.queue_conversation(nextConversation)
					nextConversation = null
