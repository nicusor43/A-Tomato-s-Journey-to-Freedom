extends KinematicBody2D


export (int) var detect_radius  # size of the visibility circle
export (float) var fire_rate  # delay time (s) between bullets
export (PackedScene) var Patru


var health = 40
var dmg = 10

var target  # who are we shooting at?
var can_shoot = true

func _ready():
	# dim the sprite when not active

	# set the collision area's radius
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/CollisionShape2D.shape = shape
	$ShootTimer.wait_time = fire_rate

func _physics_process(delta):
	update()
	# if there's a target, rotate towards it and fire
	if target:
		if can_shoot:
			shoot(target.position)
			
func _process(delta):
	if health <= 0: 
		queue_free()

func shoot(pos):
	var b = Patru.instance()
	var a = (pos - global_position).angle()
	b.start(self.position, a)
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()

func _on_Visibility_body_entered(body):
	# connect this to the "body_entered" signal
	if target:
		return
	elif body.name == "Player":
		target = body


func _on_Visibility_body_exited(body):
	# connect this to the "body_exited" signal
	if body == target:
		target = null


func _on_ShootTimer_timeout():
	can_shoot = true
	
func take_damage():
	health -= dmg
