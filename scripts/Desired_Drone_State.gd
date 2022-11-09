extends Spatial

onready var drone = $MeshInstance2
var ds = Vector3.ZERO
var dyaw = 0.0
var droll = 0.0
var dpitch = 0.0
const ZSPEED = 5
const YAWSPEED = 1
const ROLLSPEED = 1
const PITCHSPEED = 1


func _ready():
	# print(get_transform().basis.y)
	pass

func _process(delta):
	dyaw = Input.get_axis("yaw_right", "yaw_left") * YAWSPEED
	droll = Input.get_axis("roll_right", "roll_left") * ROLLSPEED
	dpitch = Input.get_axis("pitch_forward", "pitch_backward") * PITCHSPEED
	ds.y = Input.get_axis("down_thrust", "up_thrust") * ZSPEED
	
	if Input.is_key_pressed(KEY_UP):
		ds = Vector3(0,1,0) * ZSPEED
	elif Input.is_key_pressed(KEY_DOWN):
		ds = Vector3(0,-1,0) * ZSPEED
	
	# print(dr)
	if ds != Vector3.ZERO or dyaw != 0.0 or droll != 0.0:
		self.global_translate(ds * delta)
		self.rotate(get_transform().basis.y.normalized(), dyaw * delta)
		self.rotate(get_transform().basis.z.normalized(), (-1) * droll * delta)
		self.rotate(get_transform().basis.x.normalized(), (-1) * dpitch * delta)
	# print(self.translation.y)
	# print(self.rotation_degrees.y)
	if self.translation.y < 0.2:
		self.global_translate(Vector3(0, (-1) * self.translation.y + 0.2,0))
