extends Area2D

var speed = 400
var velocity = Vector2()

func _ready():
	pass
	
func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_Patru_body_entered(body):
	if body.name != "ElKilla":
		if body.name == "Player":
			body.take_damage()
		queue_free()
	
