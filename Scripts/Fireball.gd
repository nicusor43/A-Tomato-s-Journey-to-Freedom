extends Area2D

export var SPEED = 1000
var velocity = Vector2.ZERO
var direction = 1



func _ready():
	pass
	

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Fireball_body_entered(body):
	if body.name != "Player":
		if body.name == "ElKilla":
			body.take_damage()
			
		elif body.name == "Sickle":
			body.take_damage()
		queue_free()
