extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _process(delta):
	if get_child(0).position.x > 3500 and get_child(0).position.y < 50:
		 get_child(0).change_level()

