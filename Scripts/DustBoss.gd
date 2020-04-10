extends KinematicBody2D

var health = 100
var is_player = false
var can_shoot = false
export var shoot_time = 1
export (PackedScene) var DustProj 

func _ready():
	$ShootTimer.wait_time = shoot_time
	$ShootTimer.start()

func _on_VisibilityNotifier2D_screen_entered():
	is_player = true
	
func _process(delta):
	if is_player:
		get_parent().get_parent().is_follow = true
	
	if can_shoot and is_player:
		var dust_proj1 = DustProj.instance()
		var dust_proj2 = DustProj.instance()
		dust_proj1.start($LeftPosition.position, 0)
		dust_proj2.start($RightPosition.position, 180)
		get_parent().add_child(dust_proj1)
		get_parent().add_child(dust_proj2)
		can_shoot = false
		$ShootTimer.start()
	
	if health < 0:
		queue_free()
		
	print(health)
func _on_ShootTimer_timeout():
	can_shoot = true

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage()
	
	
func take_damage():
	health -= 1
