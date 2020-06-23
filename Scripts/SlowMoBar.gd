extends TextureProgress

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if get_parent().get_node("SlowMoTimer").time_left != 0:
		self.max_value = 1.2
		self.step = 0.015
		self.value = get_parent().get_node("SlowMoTimer").time_left
	if get_parent().get_node("SlowMoRecovery").time_left != 0:
		self.max_value = 3
		self.step = 0.05
		self.value = 3 - get_parent().get_node("SlowMoRecovery").time_left
