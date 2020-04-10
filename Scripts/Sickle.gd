extends KinematicBody2D

export var offset = 20
export var attack_rate = .3
var player_seen = false
var can_attack = false
var timer = true
var target

var health = 100

var speed = 120
var velocity = Vector2.ZERO

func _ready():
		$AttackTimer.wait_time = attack_rate

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Sickle_Anim")
		player_seen = true
		target = body
		
func _process(delta):
	if health <= 0: 
		queue_free()


func _physics_process(delta):
	velocity = Vector2(speed, 0)
	if target != null:
		if global_position.x <= target.global_position.x and global_position.x < 2295:
			position += velocity * delta
		elif global_position.x > 2007:
			position -= velocity * delta
	if can_attack and timer: 
		target.take_damage()
		timer = false
		$AttackTimer.start(attack_rate)


func _on_Area2D2_body_entered(body):
	if body.name == "Player": 
		can_attack = true


func _on_Area2D2_body_exited(body):
	if body.name == "Player": 
		can_attack = false


func _on_AttackTimer_timeout():
	timer = true
	
func take_damage():
	health -= 10


