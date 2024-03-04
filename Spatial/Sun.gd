extends OmniLight


func _ready():
	pass

func _process(delta):
	if get_parent().get_parent().visible:
		if Input.is_action_just_released("switch_color"):
			var color = Color(randf(), randf(), randf())
			light_color = color
			get_parent().material.albedo_color = color
