extends Sprite

# Declare member variables here. Examples:
signal hit
# var b = "text"
var mouse_pos
var pos = Vector2()
# Called when the node enters the scene tree for the first time.
#func _ready():
	#self.hide()
	
func _process(delta):
	mouse_pos = get_global_mouse_position()
	look_at_mouse()
	if Input.is_action_just_pressed("ui_accept"): 
		shoot()
		
func look_at_mouse():
	look_at(mouse_pos)
	
func shoot():
	$RayCast2D.set_cast_to(get_local_mouse_position())
	if $RayCast2D.is_colliding():
		pos = $RayCast2D.get_collision_point()
		get_parent().get_node("Line2D").points = PoolVector2Array([ get_parent().position, to_local(pos)])