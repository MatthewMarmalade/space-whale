extends AnimatedSprite

func _on_Click_input_event(_viewport, event, _shape_idx):
	if event.is_pressed():
		var main = get_node("/root/Main")
		main.radio_pressed()

func get_text_box_position():
	return global_position

func set_radio_receiving(_on : bool):
	$Visual.set_radio_receiving(_on)

func set_radio_speaking(_on : bool):
	$Visual.set_radio_speaking(_on)
