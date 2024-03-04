extends Node2D

var receiving = false
var speaking = false

var standardModulation = 0.5
var pulseModulation = Vector2(0.6, 1.2)
var pulseProgress = 0.0
var pulseInterval = 2.0

var speakingModulation = Vector2(0.3, 1.0)
var speakingProgress = 0.0
var speakingInterval = 2.0

var standardReceivingModulation = 1.0
var receivingModulation = Vector2(0.5, 0.95)

var normalColor = Color(0.832031, 0.832031, 0.832031)
var receivingColor = Color(1, 0.34902, 0.34902)
var speakingColor = Color(0, 0.694118, 1)

func _ready():
	set_radio_receiving(false)
	set_radio_speaking(false)

func set_radio_receiving(_on : bool):
	$Radio_Receiving.visible = _on or speaking
	pulseProgress = 0.0
	receiving = _on
	if !speaking and !receiving:
		$Radio_C.modulate.a = standardModulation

func set_radio_speaking(_on : bool):
	$Radio_Speaking.visible = _on
	$Radio_Receiving.visible = _on or receiving
	speakingProgress = 0.0
	speaking = _on
	if !speaking and !receiving:
		$Radio_C.modulate = normalColor
		$Radio_C.modulate.a = standardModulation

func _process(delta):
	if receiving:
		pulseProgress += delta
		if pulseProgress > pulseInterval:
			pulseProgress -= pulseInterval
		var pulseProp = pulseProgress / pulseInterval
		#var sinPulseProp = sin(pulseProp * PI)
		var blinkProp = round(pulseProp)
		var prop = blinkProp
		
		$Radio_Receiving.modulate.a = lerp(receivingModulation.x, receivingModulation.y, prop)
		$Radio_C.modulate = receivingColor
		$Radio_C.modulate.a = lerp(pulseModulation.x, pulseModulation.y, prop)
		$Radio_Speaking.visible = false
	elif speaking:
		speakingProgress += delta
		if speakingProgress > speakingInterval:
			speakingProgress -= speakingInterval
		var speakingProp = speakingProgress / speakingInterval
		#var sinSpeakingProp = sin(speakingProp * PI)
		var blinkProp = round(speakingProp)
		var prop = blinkProp
		
		$Radio_Speaking.modulate.a = lerp(receivingModulation.x, receivingModulation.y, prop)
		$Radio_C.modulate = speakingColor
		$Radio_C.modulate.a = lerp(pulseModulation.x, pulseModulation.y, prop)
		$Radio_Receiving.modulate.a = standardReceivingModulation
	#if blinker:
	#	blinkerTimer += delta
	##	if blinkerTimer >= blinkerInterval:
	#		if on:
	#			set_off()
	#		else:
	#			set_on()
	#		blinkerTimer -= blinkerInterval
