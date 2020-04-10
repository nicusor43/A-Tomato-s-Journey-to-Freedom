extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$CollisionShape2D.disabled = true

func _process(delta):
	if get_parent().get_node("Player").global_position.x > 3700:
		show()
		$CollisionShape2D.disabled = false
