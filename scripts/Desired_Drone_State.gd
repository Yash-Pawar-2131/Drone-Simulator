extends Spatial


const XSPEED = 0.2


func _ready():
	# print(get_transform().basis.y)
	pass

func _process(delta):
	
	# x-axis movement 
	if Input.is_key_pressed(KEY_RIGHT):
		self.translate(Vector3(1,0,0) * XSPEED)
	elif Input.is_key_pressed(KEY_LEFT):
		self.translate(Vector3(-1,0,0) * XSPEED)
		
	
	
