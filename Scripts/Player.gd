extends KinematicBody2D


export var MAX_SPEED = 160
export var ACCELERATION = 1200
export var AIR_RESISTANCE = 0.02
export var FRICTION = 0.25
export var GRAVITY = 42
export var JUMP_FORCE  = 500



var health = 100
var dmg = 10
var mouse_pos

var check_death = false
var is_jumping = false
var face_right = true
var gun_show = false
var can_shoot = true
var can_slowmo = true
var in_slowmo = false #this check if you're in recovery

const FIREBALL = preload("res://Scenes/Fireball.tscn")
const BULLET = preload("res://Scenes/Bullet.tscn")

var motion = Vector2.ZERO



onready var sprite = $PlayerNode/Sprite
onready var animation_player = $AnimationPlayer
onready var pos = $PlayerNode/Position2D

func _ready():
	$PlayerNode/Gun.hide()
	$SlowMoBar.hide()
	$ShootTimer.wait_time = .1
	$SlowMoTimer.wait_time = 1.2
	$SlowMoRecovery.wait_time = 3

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		animation_player.play("RUn")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

	#Change the player to face either left or right
	if x_input < 0:
		face_right = false
	elif x_input > 0:
		face_right = true
	
	$PlayerNode.scale.x = -1 if !face_right else 1
	
	motion.y += GRAVITY * delta
	
	var snap = Vector2.DOWN * 32 if !is_jumping else Vector2.ZERO
	
	if is_on_floor():
		if x_input == 0:
			motion.x  = lerp(motion.x, 0, FRICTION)
			
		is_jumping = false
		
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
			is_jumping = true
	
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
			
		if x_input == 0: 
			motion.x  = lerp(motion.x, 0, AIR_RESISTANCE)
	
		
	motion = move_and_slide_with_snap(motion, snap, Vector2.UP)

func _process(delta):

	if health <= 0:
			check_death = true
	if check_death == true:
		get_tree().reload_current_scene()
	if position.y > 1500:
		check_death = true
		
	if Input.is_action_just_pressed("ui_focus_next") and !gun_show:
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.global_position = $PlayerNode/Position2D.global_position
		fireball.direction = -1 if !face_right else 1
	
	if gun_show:
		mouse_pos = get_global_mouse_position()
		$PlayerNode/Gun.look_at(mouse_pos)
		$SlowMoBar.show()
		
		if Input.is_action_pressed("ui_focus_next") and can_shoot:
			shoot(pos)
			
		if Input.is_action_just_pressed("ui_focus_prev") and can_slowmo:
			$SlowMoTimer.start()
			in_slowmo = true
			
		if Input.is_action_just_released("ui_focus_prev") and can_slowmo:
			can_slowmo = false
			in_slowmo = false
			$SlowMoRecovery.start()
			$SlowMoTimer.stop()
			
		if can_slowmo:
			if Input.is_action_pressed("ui_focus_prev") and in_slowmo:
				Engine.time_scale = .3
		else:
			Engine.time_scale = 1
			 
	


	
func take_damage():
	health -= dmg
	
func change_level():
	get_tree().change_scene("Scenes/Level2.tscn")
	
func gun_pickup():
	$PlayerNode/Gun.show()
	gun_show = true
	
func shoot(pos):
	var b = BULLET.instance()
	var a = (mouse_pos - $PlayerNode/Gun.global_position).angle()
	#TODO post pe reddit sau issue de ce trb sa fac chestia asta ca sa mearga lol
	b.start($PlayerNode/Gun/BulletPoint.global_position - global_position + position, a)
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()
	

func _on_ShootTimer_timeout():
	can_shoot = true

func _on_SlowMoTimer_timeout():
	can_slowmo = false
	in_slowmo = false
	$SlowMoTimer.stop()
	$SlowMoRecovery.start()

func _on_SlowMoRecovery_timeout():
	can_slowmo = true
	$SlowMoRecovery.stop()
