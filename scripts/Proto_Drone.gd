extends RigidBody

onready var desired_drone_state = get_node("/root/Spatial/Desired_Drone_State")

var dir : int
var previous_error : float
var error : float
var error_derivative : float
var error_integral : float
var force : Vector3

var previous_error_yaw : float
var error_yaw : float
var error_yaw_derivative : float
var error_yaw_integral : float
var torque : Vector3

const PGAIN = 20
const DGAIN = 3
const IGAIN = 2

func _ready():
	previous_error = 0.0
	error_integral = 0.0

	previous_error_yaw = 0.0
	error_yaw_integral = 0.0
	dir = 0


func _process(delta):
	if desired_drone_state.get_transform().basis.z.cross(self.get_transform().basis.z).y >= 0:
		dir = -1
	else:
		dir = 1
	error_yaw = (dir) * desired_drone_state.get_transform().basis.z.angle_to(self.get_transform().basis.z)
	# print(rad2deg(error_yaw))
	error_yaw_derivative = (error_yaw - previous_error_yaw) / delta
	previous_error_yaw = error_yaw
	error_yaw_integral = error_yaw_integral + error_yaw * delta

	error = desired_drone_state.translation.y - self.translation.y
	# print(error, previous_error)
	error_derivative = (error - previous_error) / delta
	# print(error_derivative)
	previous_error = error
	# print(error_integral)
	error_integral = error_integral + error * delta

func _physics_process(delta):
	# add_force(Vector3(0, error, 0) * PGAIN, Vector3(0, 0, 0))
	force = (
		Vector3(0, error, 0) * PGAIN +
		Vector3(0, error_derivative, 0) * DGAIN +
		Vector3(0, error_integral, 0) * IGAIN
	)
	# force = (Vector3(0, error, 0) * PGAIN)
	# add_force(Vector3(0, clamp(force.y, 0, 100), 0), Vector3(0, 0, 0))
	add_force(force, Vector3(0, 0, 0))
	# print(force.y)

	torque = (
		Vector3(0, error_yaw, 0) * (PGAIN / 4.0) +
		Vector3(0, error_yaw_derivative, 0) * (DGAIN) +
		Vector3(0, error_yaw_integral, 0) * IGAIN
	)
	add_torque(torque)
