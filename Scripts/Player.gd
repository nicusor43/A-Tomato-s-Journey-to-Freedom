extends KinematicBody2D


export var MAX_SPEED = 160
export var ACCELERATION = 1200
export var AIR_RESISTANCE = 0.02
export var FRICTION = 0.25
export var GRAVITY = 42
export var JUMP_FORCE  = 500



var health = 100
var dmg = 10

var check_death = false
var is_jumping = false

const FIREBALL = preload("res://Scenes/Fireball.tscn")

var motion = Vector2.ZERO



onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var pos = $Position2D

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		animation_player.play("RUn")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0 
	
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
			
	if Input.is_action_just_pressed("ui_focus_next"):
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.global_position = $Position2D.global_position
		fireball.direction = -1 if sprite.flip_h else 1
		
	motion = move_and_slide_with_snap(motion, snap, Vector2.UP)

func _process(delta):
	if health <= 0:
			check_death = true
	if check_death == true:
		get_tree().reload_current_scene()
	if position.y > 1500:
		check_death = true

	
func take_damage():
	health -= dmg
	
func change_level():
	get_tree().change_scene("Level2.tscn")
	

