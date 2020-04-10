extends Path2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_follow = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta): 
	if is_follow:
			$PathFollow2D.set_offset($PathFollow2D.get_offset() + 40 * delta) 