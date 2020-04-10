extends Area2D


var velocity = Vector2.ZERO
export (float) var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(pos, dir):
	position = pos
	rotation = dir
	if dir < 180:
		velocity = Vector2(-speed, 0)
	else:
		velocity = Vector2(speed, 0)
	
func _physics_process(delta):
	position += velocity * delta
	

func _on_DustProj_body_entered(body):
	if body.name != "DustBoss":
		if body.name == "Player":
			body.take_damage()
		queue_free()
