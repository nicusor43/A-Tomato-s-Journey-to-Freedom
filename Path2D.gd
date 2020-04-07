extends Path2D


func _ready():
	pass

func _process(delta):
	$PathFollow2D.set_offset($PathFollow2D.get_offset() + 100 * delta) 
