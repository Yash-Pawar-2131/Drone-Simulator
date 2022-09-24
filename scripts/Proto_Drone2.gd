extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	# print(Input.get_axis("down_thrust", "up_thrust"))
	# add_force(self.get_transform().basis.z * Input.get_axis("down_thrust", "up_thrust") * 20, Vector3(0, 0, 0))
	
	add_force(self.get_transform().basis.y * Input.get_axis("down_thrust", "up_thrust") * 10, $Proto_Drone_Mesh/P1.get_transform().origin)
	add_force(self.get_transform().basis.y * Input.get_axis("down_thrust", "up_thrust") * 10, $Proto_Drone_Mesh/P2.get_transform().origin)
	add_force(self.get_transform().basis.y * Input.get_axis("down_thrust", "up_thrust") * 10, $Proto_Drone_Mesh/P3.get_transform().origin)
	add_force(self.get_transform().basis.y * Input.get_axis("down_thrust", "up_thrust") * 10, $Proto_Drone_Mesh/P4.get_transform().origin)
	
	add_torque(Vector3(0, Input.get_axis("yaw_right", "yaw_left") * 10, 0))
