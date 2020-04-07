extends Path2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 160
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	$PathFollow2D.set_offset($PathFollow2D.get_offset() + speed * delta) 
