extends TextureProgress



func _process(delta):
	value = get_parent().health
	if get_parent().health <= 50 && get_parent().health > 20:
		self.tint_progress = Color.orange
	elif get_parent().health <= 20 :
		self.tint_progress = Color.red
	else: 
		self.tint_progress = Color.green